// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:vs1/domain/track_model.dart';
import 'package:vs1/entity/stage.dart';
import 'package:vs1/presentation/style/colors.dart';
import 'package:vs1/presentation/style/fontStyle.dart';

class TrackPage extends StatelessWidget {
  const TrackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TrackModel(),
      child: const SubTrack(),
    );
  }
}

class SubTrack extends StatelessWidget {
  const SubTrack({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TrackModel>();
    if (model.connective == 'none' && !model.connectiveAlert) {
      model.connectiveAlert = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'No internet',
                  style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : colors.secondaryDark),
                ),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        model.connectiveAlert = false;
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Back',
                        style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : colors.secondaryDark),
                      )),
                ],
              );
            });
      });
    }
    if (model.Error != null && !model.alertError) {
      model.alertError = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  '${model.Error}',
                  style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : colors.secondaryDark),
                ),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        model.alertError = false;
                        model.Error = null;
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Back',
                        style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : colors.secondaryDark),
                      )),
                ],
              );
            });
      });
    }
    return Scaffold(
        body: model.isTrack && model.stream != null
            ? StreamBuilder<List<Stage>>(
                stream: model.getStream(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 320.h,
                                child: YandexMap(
                                  onMapTap: (argument) {},
                                  mapObjects: model.placemarks,
                                  mode2DEnabled: false,
                                  mapType: MapType.vector,
                                  nightModeEnabled:
                                      Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? true
                                          : false,
                                  onMapCreated: (controller) {
                                    model.mapController.complete(controller);
                                    controller.moveCamera(
                                        CameraUpdate.newCameraPosition(
                                            CameraPosition(
                                                zoom: 4.5,
                                                target: Point(
                                                    latitude: model.placemarks
                                                        .first.point.latitude,
                                                    longitude: model
                                                        .placemarks
                                                        .first
                                                        .point
                                                        .longitude))));
                                  },
                                  gestureRecognizers: <Factory<
                                      OneSequenceGestureRecognizer>>{
                                    Factory<OneSequenceGestureRecognizer>(
                                      () => EagerGestureRecognizer(),
                                    ),
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 42.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25.w),
                                child: Text(
                                  'Tracking Number',
                                  style: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? fontStyle.titleLabelWhite
                                      : fontStyle.titleLabel,
                                ),
                              ),
                              SizedBox(
                                height: 24.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25.w),
                                child: Row(
                                  children: [
                                    SvgPicture.asset('assets/image/sun.svg'),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Text(
                                      'R-${model.uuid.toUpperCase()}',
                                      style: fontStyle.trackId,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25.w),
                                child: Text(
                                  'Package Status',
                                  style: fontStyle.timeLabel,
                                ),
                              ),
                              SizedBox(
                                height: 24.h,
                              ),
                              snapshot.data?.first.stage == 'stage1'
                                  ? ProgressItemStage1(
                                      stage: snapshot.data!.first,
                                    )
                                  : snapshot.data?.first.stage == 'stage2'
                                      ? ProgressItemStage2(
                                          stage: snapshot.data!.first,
                                        )
                                      : snapshot.data?.first.stage == 'stage3'
                                          ? ProgressItemStage3(
                                              stage: snapshot.data!.first,
                                            )
                                          : ProgressItemStage4(
                                              stage: snapshot.data!.first,
                                            ),
                              SizedBox(
                                height: 40.h,
                              ),
                              const ViewPackageInfoButton(),
                            ],
                          ),
                        )
                      : const Column(
                          children: [],
                        );
                })
            : const Column(
                children: [],
              ));
  }
}

class ViewPackageInfoButton extends StatelessWidget {
  const ViewPackageInfoButton({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TrackModel>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Center(
        child: SizedBox(
            width: 342.w,
            height: 46.h,
            child: ElevatedButton(
              onPressed: () => model.goToCheckInfo(context),
              style: const ButtonStyle(
                  elevation: MaterialStatePropertyAll(0),
                  backgroundColor: MaterialStatePropertyAll(colors.main),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))))),
              child: Text(
                'View Package Info',
                style: fontStyle.titleLabelWhite,
              ),
            )),
      ),
    );
  }
}

class ProgressItemStage4 extends StatelessWidget {
  Stage stage;
  ProgressItemStage4({
    Key? key,
    required this.stage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 14.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                        color: colors.main,
                        borderRadius: BorderRadius.circular(2.33)),
                    child: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: SvgPicture.asset(
                        'assets/image/ok.svg',
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.white
                                : colors.secondaryDark,
                            BlendMode.srcIn),
                      ),
                    ),
                  ),
                  SvgPicture.asset('assets/image/line.svg'),
                ],
              ),
              SizedBox(
                width: 7.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Courier requested',
                    style: fontStyle.timeLabelResend,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stage.stage1Time,
                        style: fontStyle.hintSecondary,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 14.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                        color: colors.main,
                        borderRadius: BorderRadius.circular(2.33)),
                    child: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: SvgPicture.asset(
                        'assets/image/ok.svg',
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.white
                                : colors.secondaryDark,
                            BlendMode.srcIn),
                      ),
                    ),
                  ),
                  SvgPicture.asset('assets/image/line.svg'),
                ],
              ),
              SizedBox(
                width: 7.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Courier requested',
                    style: fontStyle.timeLabelResend,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stage.stage2Time,
                        style: fontStyle.hintSecondary,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 14.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                        color: colors.main,
                        borderRadius: BorderRadius.circular(2.33)),
                    child: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: SvgPicture.asset(
                        'assets/image/ok.svg',
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.white
                                : colors.secondaryDark,
                            BlendMode.srcIn),
                      ),
                    ),
                  ),
                  SvgPicture.asset('assets/image/line.svg'),
                ],
              ),
              SizedBox(
                width: 7.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Courier requested',
                    style: fontStyle.timeLabelResend,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stage.stage3Time,
                        style: fontStyle.hintSecondary,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 14.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                        color: colors.main,
                        borderRadius: BorderRadius.circular(2.33)),
                    child: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: SvgPicture.asset(
                        'assets/image/ok.svg',
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.white
                                : colors.secondaryDark,
                            BlendMode.srcIn),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 7.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Courier requested',
                    style: fontStyle.timeLabelResend,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stage.stage4Time,
                        style: fontStyle.hintSecondary,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ProgressItemStage2 extends StatelessWidget {
  Stage stage;
  ProgressItemStage2({
    Key? key,
    required this.stage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 14.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                        color: colors.main,
                        borderRadius: BorderRadius.circular(2.33)),
                    child: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: SvgPicture.asset(
                        'assets/image/ok.svg',
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.white
                                : colors.secondaryDark,
                            BlendMode.srcIn),
                      ),
                    ),
                  ),
                  SvgPicture.asset('assets/image/line.svg'),
                ],
              ),
              SizedBox(
                width: 7.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Courier requested',
                    style: fontStyle.timeLabelResend,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stage.stage1Time,
                        style: fontStyle.hintSecondary,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 14.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                        color: colors.main,
                        borderRadius: BorderRadius.circular(2.33)),
                    child: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: SvgPicture.asset(
                        'assets/image/ok.svg',
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.white
                                : colors.secondaryDark,
                            BlendMode.srcIn),
                      ),
                    ),
                  ),
                  SvgPicture.asset('assets/image/line.svg'),
                ],
              ),
              SizedBox(
                width: 7.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Package ready for delivery',
                    style: fontStyle.timeLabelResend,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stage.stage2Time,
                        style: fontStyle.hintSecondary,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 14.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : colors.primaryDark,
                        border: Border.all(color: colors.main),
                        borderRadius: BorderRadius.circular(2.33)),
                  ),
                  SvgPicture.asset('assets/image/line.svg'),
                ],
              ),
              SizedBox(
                width: 7.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Package in transit',
                    style: fontStyle.timeLabelResend,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'July 7 2022',
                        style: fontStyle.hintSecondary,
                      ),
                      SizedBox(
                        width: 7.w,
                      ),
                      Text(
                        '08:00am',
                        style: fontStyle.hintSecondary,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 14.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.light
                            ? colors.gray
                            : Colors.white,
                        borderRadius: BorderRadius.circular(2.33)),
                    child: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: SvgPicture.asset(
                        'assets/image/line_stage.svg',
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.white
                                : colors.secondaryDark,
                            BlendMode.srcIn),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 7.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Package delivered',
                    style: fontStyle.timeLabelResend,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'July 7 2022',
                        style: fontStyle.hintSecondary,
                      ),
                      SizedBox(
                        width: 7.w,
                      ),
                      Text(
                        '08:00am',
                        style: fontStyle.hintSecondary,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ProgressItemStage3 extends StatelessWidget {
  Stage stage;
  ProgressItemStage3({
    Key? key,
    required this.stage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 14.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                        color: colors.main,
                        borderRadius: BorderRadius.circular(2.33)),
                    child: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: SvgPicture.asset(
                        'assets/image/ok.svg',
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.white
                                : colors.secondaryDark,
                            BlendMode.srcIn),
                      ),
                    ),
                  ),
                  SvgPicture.asset('assets/image/line.svg'),
                ],
              ),
              SizedBox(
                width: 7.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Courier requested',
                    style: fontStyle.timeLabelResend,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stage.stage1Time,
                        style: fontStyle.hintSecondary,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 14.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                        color: colors.main,
                        borderRadius: BorderRadius.circular(2.33)),
                    child: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: SvgPicture.asset(
                        'assets/image/ok.svg',
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.white
                                : colors.secondaryDark,
                            BlendMode.srcIn),
                      ),
                    ),
                  ),
                  SvgPicture.asset('assets/image/line.svg'),
                ],
              ),
              SizedBox(
                width: 7.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Package ready for delivery',
                    style: fontStyle.timeLabelResend,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stage.stage2Time,
                        style: fontStyle.hintSecondary,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 14.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                        color: colors.main,
                        borderRadius: BorderRadius.circular(2.33)),
                    child: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: SvgPicture.asset(
                        'assets/image/ok.svg',
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.white
                                : colors.secondaryDark,
                            BlendMode.srcIn),
                      ),
                    ),
                  ),
                  SvgPicture.asset('assets/image/line.svg'),
                ],
              ),
              SizedBox(
                width: 7.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Package in transit',
                    style: fontStyle.timeLabelResend,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stage.stage3Time,
                        style: fontStyle.hintSecondary,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 14.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.light
                            ? colors.gray
                            : Colors.white,
                        borderRadius: BorderRadius.circular(2.33)),
                    child: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: SvgPicture.asset(
                        'assets/image/line_stage.svg',
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.white
                                : colors.secondaryDark,
                            BlendMode.srcIn),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 7.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Package delivered',
                    style: fontStyle.timeLabelResend,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'July 7 2022',
                        style: fontStyle.hintSecondary,
                      ),
                      SizedBox(
                        width: 7.w,
                      ),
                      Text(
                        '08:00am',
                        style: fontStyle.hintSecondary,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ProgressItemStage1 extends StatelessWidget {
  Stage stage;
  ProgressItemStage1({
    Key? key,
    required this.stage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 14.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                        color: colors.main,
                        borderRadius: BorderRadius.circular(2.33)),
                    child: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: SvgPicture.asset(
                        'assets/image/ok.svg',
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.white
                                : colors.secondaryDark,
                            BlendMode.srcIn),
                      ),
                    ),
                  ),
                  SvgPicture.asset('assets/image/line.svg'),
                ],
              ),
              SizedBox(
                width: 7.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Courier requested',
                    style: fontStyle.timeLabelResend,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stage.stage1Time,
                        style: fontStyle.hintSecondary,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 14.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : colors.primaryDark,
                        border: Border.all(color: colors.main),
                        borderRadius: BorderRadius.circular(2.33)),
                  ),
                  SvgPicture.asset('assets/image/line.svg'),
                ],
              ),
              SizedBox(
                width: 7.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Package ready for delivery',
                    style: fontStyle.timeLabelResend,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'July 7 2022',
                        style: fontStyle.hintSecondary,
                      ),
                      SizedBox(
                        width: 7.w,
                      ),
                      Text(
                        '08:00am',
                        style: fontStyle.hintSecondary,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 14.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : colors.primaryDark,
                        border: Border.all(color: colors.main),
                        borderRadius: BorderRadius.circular(2.33)),
                    child: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: SvgPicture.asset(
                        'assets/image/ok.svg',
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.white
                                : colors.secondaryDark,
                            BlendMode.srcIn),
                      ),
                    ),
                  ),
                  SvgPicture.asset('assets/image/line.svg'),
                ],
              ),
              SizedBox(
                width: 7.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Package in transit',
                    style: fontStyle.timeLabelResend,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'July 7 2022',
                        style: fontStyle.hintSecondary,
                      ),
                      SizedBox(
                        width: 7.w,
                      ),
                      Text(
                        '08:00am',
                        style: fontStyle.hintSecondary,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 14.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.light
                            ? colors.gray
                            : Colors.white,
                        borderRadius: BorderRadius.circular(2.33)),
                    child: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: SvgPicture.asset(
                        'assets/image/line_stage.svg',
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.white
                                : colors.secondaryDark,
                            BlendMode.srcIn),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 7.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Package delivered',
                    style: fontStyle.timeLabelResend,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'July 7 2022',
                        style: fontStyle.hintSecondary,
                      ),
                      SizedBox(
                        width: 7.w,
                      ),
                      Text(
                        '08:00am',
                        style: fontStyle.hintSecondary,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
