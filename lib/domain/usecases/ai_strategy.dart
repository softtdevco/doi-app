import 'dart:math';

import 'package:doi_mobile/core/utils/logger.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/guess_model.dart';

class AiStrategy {
  static String generateAiGuess({
    required List<Guess> previousGuesses,
    required int difficulty,
    required String secretCode,
  }) {
    debugLog('AI analyzing - Mode: ${difficulty == 0 ? "Easy" : "Hard"}');

    if (difficulty == 0) {
      return _generateEasyModeGuess(previousGuesses);
    } else {
      return _generateHardModeGuess(previousGuesses);
    }
  }

  static String _generateEasyModeGuess(List<Guess> previousGuesses) {
    if (previousGuesses.isEmpty) {
      final firstGuess = generateSecretCode();
      debugLog('AI (Easy) - First guess: $firstGuess');
      return firstGuess;
    }

    // Check if we're repeating guesses
    if (previousGuesses.length >= 2) {
      String lastGuess = previousGuesses.last.code;
      String secondLastGuess = previousGuesses[previousGuesses.length - 2].code;

      if (lastGuess == secondLastGuess) {
        String newGuess;
        do {
          newGuess = generateSecretCode();
        } while (previousGuesses.any((g) => g.code == newGuess));

        debugLog('AI (Easy) - Breaking repeat loop with new guess: $newGuess');
        return newGuess;
      }
    }

    // Track confirmed positions, potential digits, and excluded digits
    Map<int, String> confirmedPositions = {};
    Set<String> potentialDigits = {};
    Set<String> excludedDigits = {};

    // Analyze previous guesses
    for (var guess in previousGuesses) {
      // If the guess had 0 dead and 0 injured, none of its digits are in the code
      if (guess.deadCount == 0 && guess.injuredCount == 0) {
        for (int i = 0; i < 4; i++) {
          excludedDigits.add(guess.code[i]);
        }
        continue;
      }

      // If the guess had high dead count, try to identify confirmed positions
      if (guess.deadCount >= 1) {
        for (int i = 0; i < 4; i++) {
          // Only consider confirmed if this position worked in at least one guess with dead > 0
          // and never failed in a guess with the same digit at this position
          bool isConfirmed = true;

          for (var otherGuess in previousGuesses) {
            // If another guess had same digit in same position but no dead, not confirmed
            if (otherGuess.code[i] == guess.code[i] &&
                otherGuess.deadCount == 0) {
              isConfirmed = false;
              break;
            }
          }

          if (isConfirmed) {
            // Don't immediately confirm, just mark as potential
            // Will later verify against best guess's performance
            potentialDigits.add(guess.code[i]);
            if (guess.deadCount >= 2) {
              confirmedPositions[i] = guess.code[i];
            }
          }
        }
      }

      // Add digits from guesses with decent feedback as potential
      if (guess.deadCount > 0 || guess.injuredCount > 0) {
        for (int i = 0; i < 4; i++) {
          if (!excludedDigits.contains(guess.code[i])) {
            potentialDigits.add(guess.code[i]);
          }
        }
      }
    }

    // Find the best guess so far
    Guess? bestGuess;
    for (var guess in previousGuesses) {
      if (bestGuess == null ||
          guess.deadCount > bestGuess.deadCount ||
          (guess.deadCount == bestGuess.deadCount &&
              guess.injuredCount > bestGuess.injuredCount)) {
        bestGuess = guess;
      }
    }

    // Sanity check: If all positions are confirmed but best guess wasn't perfect
    // then our confirmation logic is wrong
    if (confirmedPositions.length == 4 &&
        bestGuess != null &&
        bestGuess.deadCount < 4) {
      debugLog('AI (Easy) - Incorrect confirmation logic detected, resetting');
      confirmedPositions.clear();

      // Only keep positions from best guess if it had good feedback
      if (bestGuess.deadCount >= 2) {
        for (int i = 0; i < min(bestGuess.deadCount, 2); i++) {
          confirmedPositions[i] = bestGuess.code[i];
        }
      }
    }

    debugLog('AI (Easy) - Confirmed positions: $confirmedPositions');
    debugLog('AI (Easy) - Potential digits: $potentialDigits');

    // Generate a new guess
    List<String> newGuessDigits = List.filled(4, '');

    // Start with confirmed positions
    confirmedPositions.forEach((position, digit) {
      newGuessDigits[position] = digit;
    });

    // For remaining positions, use potential digits or new ones
    List<String> availableDigits = [];

    // First try potential digits that worked well
    for (String digit in potentialDigits) {
      if (!newGuessDigits.contains(digit) && !excludedDigits.contains(digit)) {
        availableDigits.add(digit);
      }
    }

    // If needed, add other digits not yet excluded
    if (availableDigits.length < 4 - confirmedPositions.length) {
      for (int i = 0; i < 10; i++) {
        String digit = i.toString();
        if (!newGuessDigits.contains(digit) &&
            !availableDigits.contains(digit) &&
            !excludedDigits.contains(digit)) {
          availableDigits.add(digit);
        }
      }
    }

    // If still not enough digits, use any digit not in our guess yet
    if (availableDigits.length < 4 - confirmedPositions.length) {
      for (int i = 0; i < 10; i++) {
        String digit = i.toString();
        if (!newGuessDigits.contains(digit) &&
            !availableDigits.contains(digit)) {
          availableDigits.add(digit);
        }
      }
    }

    // Shuffle available digits
    availableDigits.shuffle(Random());

    // Fill empty positions
    for (int i = 0; i < 4; i++) {
      if (newGuessDigits[i].isEmpty && availableDigits.isNotEmpty) {
        newGuessDigits[i] = availableDigits.removeAt(0);
      }
    }

    // Final check - make sure all positions are filled
    for (int i = 0; i < 4; i++) {
      if (newGuessDigits[i].isEmpty) {
        // Emergency fallback
        for (int j = 0; j < 10; j++) {
          String digit = j.toString();
          if (!newGuessDigits.contains(digit)) {
            newGuessDigits[i] = digit;
            break;
          }
        }
      }
    }

    String newGuess = newGuessDigits.join();

    // Check if we've guessed this before - if so, make a new random guess
    if (previousGuesses.any((g) => g.code == newGuess)) {
      String randomGuess;
      int attempts = 0;
      do {
        randomGuess = generateSecretCode();
        attempts++;
        if (attempts > 10) break; // Safety valve
      } while (previousGuesses.any((g) => g.code == randomGuess));

      debugLog('AI (Easy) - Avoiding repeat, using new guess: $randomGuess');
      return randomGuess;
    }

    debugLog('AI (Easy) - New guess: $newGuess');
    return newGuess;
  }

  static String _generateHardModeGuess(List<Guess> previousGuesses) {
    if (previousGuesses.isEmpty) {
      // First guess is strategic - use "1234" as a good starting point
      debugLog('AI (Hard) - First strategic guess: 1234');
      return "1234";
    }

    // Check if we're repeating guesses
    if (previousGuesses.length >= 2) {
      String lastGuess = previousGuesses.last.code;
      String secondLastGuess = previousGuesses[previousGuesses.length - 2].code;

      if (lastGuess == secondLastGuess) {
        String newGuess;
        do {
          newGuess = generateSecretCode();
        } while (previousGuesses.any((g) => g.code == newGuess));

        debugLog('AI (Hard) - Breaking repeat loop with new guess: $newGuess');
        return newGuess;
      }
    }

    // Generate all possible codes
    var allPossibleCodes = _generateAllPossibleCodes();
    debugLog(
        'AI (Hard) - Starting with ${allPossibleCodes.length} possible codes');

    // Filter based on all previous guesses and feedback
    for (var guess in previousGuesses) {
      allPossibleCodes = allPossibleCodes.where((code) {
        // Calculate what feedback this code would give for the previous guess
        int deadCount = 0;
        int injuredCount = 0;

        var guessDigits = guess.code.split('');
        var codeDigits = code.split('');

        // Count dead (correct position)
        for (int i = 0; i < 4; i++) {
          if (guessDigits[i] == codeDigits[i]) {
            deadCount++;
            guessDigits[i] = 'X';
            codeDigits[i] = 'Y';
          }
        }

        // Count injured (wrong position)
        for (int i = 0; i < 4; i++) {
          if (guessDigits[i] != 'X') {
            int index = codeDigits.indexOf(guessDigits[i]);
            if (index != -1 && codeDigits[index] != 'Y') {
              injuredCount++;
              codeDigits[index] = 'Y';
            }
          }
        }

        // Keep this code as a possibility if it gives the same feedback
        return deadCount == guess.deadCount &&
            injuredCount == guess.injuredCount;
      }).toList();

      debugLog(
          'AI (Hard) - After analyzing ${guess.code} (D:${guess.deadCount}/I:${guess.injuredCount}): ${allPossibleCodes.length} codes remain');
    }

    if (allPossibleCodes.isEmpty) {
      debugLog('AI (Hard) - No valid codes found, using fallback');

      // Generate a guess that hasn't been used before
      String newGuess;
      do {
        newGuess = generateSecretCode();
      } while (previousGuesses.any((g) => g.code == newGuess));

      return newGuess;
    }

    if (allPossibleCodes.length <= 5) {
      debugLog('AI (Hard) - Possible codes: ${allPossibleCodes.join(', ')}');
    }

    // Choose a code that hasn't been guessed before
    for (String code in allPossibleCodes) {
      if (!previousGuesses.any((g) => g.code == code)) {
        debugLog('AI (Hard) - Selected guess: $code');
        return code;
      }
    }

    // If all possibilities have been guessed (unlikely), pick the first one
    debugLog('AI (Hard) - Selected guess: ${allPossibleCodes[0]}');
    return allPossibleCodes[0];
  }

  // Generate a random 4-digit code with no repeating digits
  static String generateSecretCode() {
    final random = Random();
    final digits = List<int>.generate(10, (i) => i)..shuffle(random);
    return digits.take(4).map((d) => d.toString()).join();
  }

  // Generate all possible 4-digit codes with no repeating digits
  static List<String> _generateAllPossibleCodes() {
    List<String> result = [];

    for (int i = 0; i <= 9; i++) {
      for (int j = 0; j <= 9; j++) {
        if (j == i) continue;
        for (int k = 0; k <= 9; k++) {
          if (k == i || k == j) continue;
          for (int l = 0; l <= 9; l++) {
            if (l == i || l == j || l == k) continue;
            result.add('$i$j$k$l');
          }
        }
      }
    }

    return result;
  }
}
