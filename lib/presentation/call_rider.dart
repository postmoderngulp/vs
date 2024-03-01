import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vs1/domain/call_rider_model.dart';
import 'package:vs1/presentation/style/colors.dart';
import 'package:vs1/presentation/style/fontStyle.dart';

class CallRider extends StatelessWidget {
  const CallRider({super.key});

  @override
  Widget build(BuildContext context) {
    final list = ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    return ChangeNotifierProvider(
      create: (context) => CallRiderModel(list[2]),
      child: const SubCallRider(),
    );
  }
}

class SubCallRider extends StatelessWidget {
  const SubCallRider({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<CallRiderModel>();
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
    final list = ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    return SafeArea(
        child: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 85.h,
          ),
          const Avatar(),
          SizedBox(
            height: 9.33.h,
          ),
          Center(
            child: Text(
              list[0],
              textAlign: TextAlign.center,
              style: fontStyle.titleCall,
            ),
          ),
          SizedBox(
            height: 9.33.h,
          ),
          Center(
            child: Text(
              "+${list[1]}",
              textAlign: TextAlign.center,
              style: fontStyle.titleNumber,
            ),
          ),
          SizedBox(
            height: 9.33.h,
          ),
          Center(
            child: Text(
              'calling...',
              textAlign: TextAlign.center,
              style: fontStyle.timeLabelResend,
            ),
          ),
          SizedBox(
            height: 113.43.h,
          ),
          const NumberPanel(),
        ],
      ),
    ));
  }
}

class Avatar extends StatelessWidget {
  const Avatar({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<CallRiderModel>();
    return Container(
      width: 84.w,
      height: 84.h,
      decoration: BoxDecoration(
          image: model.avatar != null
              ? DecorationImage(
                  image: MemoryImage(model.avatar as Uint8List),
                  fit: BoxFit.cover)
              : const DecorationImage(
                  image: AssetImage('assets/image/avatar.png'),
                  fit: BoxFit.cover),
          shape: BoxShape.circle),
    );
  }
}

class NumberPanel extends StatelessWidget {
  const NumberPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 341.52.w,
      height: 332.16.h,
      decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? colors.secondaryDark
              : colors.gray6,
          borderRadius: BorderRadius.circular(8.12)),
      child: Column(
        children: [
          SizedBox(
            height: 49.14.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 55.15.w),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/image/plus.svg',
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : colors.text4,
                      BlendMode.srcIn),
                ),
                const Spacer(),
                SvgPicture.asset(
                  'assets/image/pause.svg',
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : colors.text4,
                      BlendMode.srcIn),
                ),
                const Spacer(),
                SvgPicture.asset(
                  'assets/image/video.svg',
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : colors.text4,
                      BlendMode.srcIn),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 43.12.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 55.15.w),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/image/sound.svg',
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : colors.text4,
                      BlendMode.srcIn),
                ),
                const Spacer(),
                SvgPicture.asset(
                  'assets/image/off_mike.svg',
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : colors.text4,
                      BlendMode.srcIn),
                ),
                const Spacer(),
                SvgPicture.asset(
                  'assets/image/keypad.svg',
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : colors.text4,
                      BlendMode.srcIn),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 56.16.h,
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 71.21.w,
              height: 68.65.h,
              decoration: const BoxDecoration(
                  color: colors.error, shape: BoxShape.circle),
              child: Padding(
                padding: EdgeInsets.all(15.22.w),
                child: SvgPicture.asset('assets/image/call_off.svg'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
