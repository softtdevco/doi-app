import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/overlay_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/router/router.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/core/utils/logger.dart';
import 'package:doi_mobile/core/utils/validators.dart';
import 'package:doi_mobile/data/third_party_services/branch_service.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/l10n/l10n.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/create_game_request.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/min_textfield.dart';
import 'package:doi_mobile/presentation/features/dashboard/onlineGame/presentation/notifiers/online_game_notifier.dart';
import 'package:doi_mobile/presentation/features/profile/data/repository/user_repository_impl.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewGameWith extends ConsumerStatefulWidget {
  const NewGameWith({
    Key? key,
    this.isGroup = true,
    this.playerCount = 2,
    this.guessDigits = 4,
    required this.timerValue,
  }) : super(key: key);

  final bool isGroup;
  final String timerValue;
  final int playerCount;
  final int guessDigits;

  @override
  ConsumerState<NewGameWith> createState() => _NewGameWithState();
}

class _NewGameWithState extends ConsumerState<NewGameWith> {
  final TextEditingController _secretCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isEnabled = false;
  String? _inviteLink;
  bool isLoading = true;
  _createGame() {
    context.showLoading();
    final user = ref.watch(currentUserProvider);
    final type = ref.watch(onlineGameNotifierProvider.select((v) => v.type));

    int totalSeconds = int.parse(widget.timerValue) * 60;
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    final data = CreateGameRequest(
      userId: user.id ?? '',
      tournamentInfo: TournamentInfo(),
      gameMode: widget.isGroup ? 'gv1' : '1v1',
      duration: GameDuration(
        minute: minutes,
        seconds: seconds,
      ),
      playersCount: widget.playerCount,
      guessDigitCount: widget.guessDigits,
      gameType: type,
      secretCode: _secretCodeController.text.trim(),
    );
    ref.read(onlineGameNotifierProvider.notifier).createGame(
        data: data,
        onError: (p0) {
          context.hideOverLay();
          context.showError(
            message: p0,
          );
        },
        onCompleted: (p0) {
          _generateInviteLink(p0);
          context.hideOverLay();
        });
  }

  Future<void> _generateInviteLink(String code) async {
    final user = ref.watch(currentUserProvider);
    setState(() {
      isLoading = true;
    });

    try {
      final link = await BranchLinkService().createGameInviteLink(
        gameCode: code,
        inviteeName: user.username ?? '',
        digitCount: widget.guessDigits.toString(),
        playerCount: widget.playerCount.toString(),
      );

      setState(() {
        _inviteLink = link;
        isLoading = false;
      });
      debugLog('link: $_inviteLink');
      context.popAndPushNamed(
        AppRouter.gameCreated,
        arguments: (
          _inviteLink,
          widget.playerCount,
          code,
        ),
      );
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugLog('Failed to generate invite link');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 16, 32, 36),
      child: Form(
        key: _formKey,
        onChanged: () {
          setState(() {
            isEnabled = _formKey.currentState!.validate();
          });
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 28.w,
                height: 3.h,
                decoration: BoxDecoration(
                    color: Color(0xFFD7A07D),
                    borderRadius: BorderRadius.circular(8.r)),
              ),
              24.verticalSpace,
              Text(
                context.l10n.newGameWith,
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.secondaryColor,
                ),
              ),
              24.verticalSpace,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.isGroup
                      ? Assets.images.multiple.image()
                      : Assets.images.avatar2.image(),
                  8.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (user.username ?? '').toUpperCase(),
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: AppColors.secondaryColor,
                          fontSize: 20.sp,
                        ),
                      ),
                      Text(
                        widget.isGroup
                            ? '+ ${widget.playerCount - 1} other(s)'
                            : 'Online',
                        style: context.textTheme.bodySmall?.copyWith(
                          fontSize: 14.sp,
                          color:
                              AppColors.secondaryColor.withValues(alpha: 0.7),
                        ),
                      )
                    ],
                  )
                ],
              ).withContainer(
                color: AppColors.indicator,
                padding: EdgeInsets.only(
                  top: 8,
                  left: 8,
                  right: 20,
                  bottom: 8,
                ),
                borderRadius: BorderRadius.circular(
                  49.r,
                ),
              ),
              24.verticalSpace,
              Text(
                context.l10n.enterSecretCode,
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 14.sp,
                  color: AppColors.primaryColor,
                ),
              ),
              14.verticalSpace,
              MinFormField(
                hintText: '1234',
                keyboardType: TextInputType.number,
                controller: _secretCodeController,
                validateFunction: Validators.code(widget.guessDigits),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(widget.guessDigits),
                ],
                cursorColor: AppColors.secondaryColor,
                backgroundColor: AppColors.textFieldBg,
                bordercolor: AppColors.secondaryColor,
                hintStyle: context.textTheme.bodySmall!.copyWith(
                  fontSize: 20.sp,
                  color: AppColors.secondaryColor.withValues(alpha: 0.5),
                ),
              ),
              61.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: DoiButton(
                    text: context.l10n.startGame,
                    //isEnabled: isEnabled,
                    onPressed: () {
                      if (!isEnabled) {
                        _formKey.currentState?.save();
                        return;
                      }
                      _createGame();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _secretCodeController.dispose();
    super.dispose();
  }
}
