/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/horizontallogo.svg
  SvgGenImage get horizontallogo =>
      const SvgGenImage('assets/images/horizontallogo.svg');

  /// File path: assets/images/obscured.svg
  SvgGenImage get obscured => const SvgGenImage('assets/images/obscured.svg');

  $AssetsImagesShowsGen get shows => const $AssetsImagesShowsGen();

  /// File path: assets/images/topleft.svg
  SvgGenImage get topleft => const SvgGenImage('assets/images/topleft.svg');

  /// File path: assets/images/topright.svg
  SvgGenImage get topright => const SvgGenImage('assets/images/topright.svg');

  /// File path: assets/images/visible.svg
  SvgGenImage get visible => const SvgGenImage('assets/images/visible.svg');

  /// File path: assets/images/welcomeicon.svg
  SvgGenImage get welcomeicon =>
      const SvgGenImage('assets/images/welcomeicon.svg');
}

class $AssetsImagesShowsGen {
  const $AssetsImagesShowsGen();

  /// File path: assets/images/shows/krv_nije_voda.png
  AssetGenImage get krvNijeVoda =>
      const AssetGenImage('assets/images/shows/krv_nije_voda.png');

  /// File path: assets/images/shows/no_shows.svg
  SvgGenImage get noShows =>
      const SvgGenImage('assets/images/shows/no_shows.svg');

  /// File path: assets/images/shows/profile_pic.svg
  SvgGenImage get profilePic =>
      const SvgGenImage('assets/images/shows/profile_pic.svg');

  /// File path: assets/images/shows/stranger_things.png
  AssetGenImage get strangerThings =>
      const AssetGenImage('assets/images/shows/stranger_things.png');

  /// File path: assets/images/shows/the_office.png
  AssetGenImage get theOffice =>
      const AssetGenImage('assets/images/shows/the_office.png');
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
    bool cacheColorFilter = false,
    SvgTheme? theme,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      color: color,
      colorBlendMode: colorBlendMode,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
      theme: theme,
    );
  }

  String get path => _assetName;
}
