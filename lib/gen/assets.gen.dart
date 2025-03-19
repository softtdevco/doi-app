/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/Pattern.png
  AssetGenImage get pattern => const AssetGenImage('assets/images/Pattern.png');

  /// File path: assets/images/doi.png
  AssetGenImage get doi => const AssetGenImage('assets/images/doi.png');

  /// List of all assets
  List<AssetGenImage> get values => [pattern, doi];
}

class $AssetsSvgsGen {
  const $AssetsSvgsGen();

  /// File path: assets/svgs/Checked.svg
  String get checked => 'assets/svgs/Checked.svg';

  /// File path: assets/svgs/Coin.svg
  String get coin => 'assets/svgs/Coin.svg';

  /// File path: assets/svgs/Union.svg
  String get union => 'assets/svgs/Union.svg';

  /// File path: assets/svgs/add_circle.svg
  String get addCircle => 'assets/svgs/add_circle.svg';

  /// File path: assets/svgs/ai.svg
  String get ai => 'assets/svgs/ai.svg';

  /// File path: assets/svgs/alarm.svg
  String get alarm => 'assets/svgs/alarm.svg';

  /// File path: assets/svgs/arrow-up.svg
  String get arrowUp => 'assets/svgs/arrow-up.svg';

  /// File path: assets/svgs/back.svg
  String get back => 'assets/svgs/back.svg';

  /// File path: assets/svgs/circle-clock.svg
  String get circleClock => 'assets/svgs/circle-clock.svg';

  /// File path: assets/svgs/delete.svg
  String get delete => 'assets/svgs/delete.svg';

  /// File path: assets/svgs/dices.svg
  String get dices => 'assets/svgs/dices.svg';

  /// File path: assets/svgs/doi.svg
  String get doi => 'assets/svgs/doi.svg';

  /// File path: assets/svgs/friends.svg
  String get friends => 'assets/svgs/friends.svg';

  /// File path: assets/svgs/home.svg
  String get home => 'assets/svgs/home.svg';

  /// File path: assets/svgs/info.svg
  String get info => 'assets/svgs/info.svg';

  /// File path: assets/svgs/leader.svg
  String get leader => 'assets/svgs/leader.svg';

  /// File path: assets/svgs/lightbulb.svg
  String get lightbulb => 'assets/svgs/lightbulb.svg';

  /// File path: assets/svgs/pause.svg
  String get pause => 'assets/svgs/pause.svg';

  /// File path: assets/svgs/settings.svg
  String get settings => 'assets/svgs/settings.svg';

  /// File path: assets/svgs/skull.svg
  String get skull => 'assets/svgs/skull.svg';

  /// File path: assets/svgs/streak.svg
  String get streak => 'assets/svgs/streak.svg';

  /// File path: assets/svgs/tournaments.svg
  String get tournaments => 'assets/svgs/tournaments.svg';

  /// File path: assets/svgs/unchecked.svg
  String get unchecked => 'assets/svgs/unchecked.svg';

  /// File path: assets/svgs/wallet.svg
  String get wallet => 'assets/svgs/wallet.svg';

  /// File path: assets/svgs/wand.svg
  String get wand => 'assets/svgs/wand.svg';

  /// File path: assets/svgs/warning.svg
  String get warning => 'assets/svgs/warning.svg';

  /// List of all assets
  List<String> get values => [
        checked,
        coin,
        union,
        addCircle,
        ai,
        alarm,
        arrowUp,
        back,
        circleClock,
        delete,
        dices,
        doi,
        friends,
        home,
        info,
        leader,
        lightbulb,
        pause,
        settings,
        skull,
        streak,
        tournaments,
        unchecked,
        wallet,
        wand,
        warning
      ];
}

class Assets {
  const Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsSvgsGen svgs = $AssetsSvgsGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
