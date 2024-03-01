import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vs1/domain/notification_model.dart';
import 'package:vs1/presentation/style/colors.dart';
import 'package:vs1/presentation/style/fontStyle.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NotificationModel(),
      child: const SubNotificationWidget(),
    );
  }
}

class SubNotificationWidget extends StatelessWidget {
  const SubNotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<NotificationModel>();
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
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(84.h),
        child: AppBar(
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 15.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 22.w,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child:
                              SvgPicture.asset('assets/image/back_button.svg')),
                    ),
                    const Spacer(),
                    Text(
                      'Notification',
                      style: fontStyle.appBarTitle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      width: 34.w,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
          shadowColor: Theme.of(context).shadowColor,
          elevation: 3,
          centerTitle: true,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 128.h,
          ),
          Center(
            child: SvgPicture.asset(
              'assets/image/notification_banner.svg',
              colorFilter: ColorFilter.mode(
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : colors.gray2,
                  BlendMode.srcIn),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            'You have no notifications',
            textAlign: TextAlign.center,
            style: Theme.of(context).brightness == Brightness.dark
                ? fontStyle.titleLabelWhite
                : fontStyle.titleLabel,
          ),
        ],
      ),
    ));
  }
}
