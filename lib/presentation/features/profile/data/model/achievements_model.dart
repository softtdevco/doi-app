class AchievementsModel {
  final String name;
  final bool isAchieved;

  AchievementsModel({
    required this.name,
    this.isAchieved = false,
  });
}

final List<AchievementsModel> achievements = [
  AchievementsModel(
    name: 'Speed Demon',
    isAchieved: true,
  ),
  AchievementsModel(
    name: 'Flawless Victory',
    isAchieved: true,
  ),
  AchievementsModel(
    name: 'Explorer',
    isAchieved: true,
  ),
  AchievementsModel(
    name: 'Comeback King',
    isAchieved: true,
  ),
  AchievementsModel(
    name: 'Collector',
    isAchieved: true,
  ),
  AchievementsModel(
    name: 'Master Decoder',
    isAchieved: true,
  ),
  AchievementsModel(
    name: 'Blitz',
  ),
  AchievementsModel(
    name: 'Brainiac',
  ),
  AchievementsModel(
    name: 'Clutch',
  ),
  AchievementsModel(
    name: 'Sniper',
  ),
  AchievementsModel(
    name: 'Streaker',
  ),
  AchievementsModel(
    name: 'Legend',
  ),
  AchievementsModel(
    name: 'Elite',
  ),
  AchievementsModel(
    name: 'Alchemist',
  ),
  AchievementsModel(
    name: 'Phantom',
  ),
];
