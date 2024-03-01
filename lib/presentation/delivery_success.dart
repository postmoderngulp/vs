import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vs1/domain/success_delivery_model.dart';
import 'package:vs1/presentation/style/colors.dart';
import 'package:vs1/presentation/style/fontStyle.dart';

class SuccessDelivery extends StatelessWidget {
  const SuccessDelivery({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SuccessDeliveryModel(),
      child: const SubSuccessDelivery(),
    );
  }
}

class SubSuccessDelivery extends StatelessWidget {
  const SubSuccessDelivery({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SuccessDeliveryModel>();
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
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            model.time == 0
                ? SizedBox(
                    height: 111.h,
                  )
                : SizedBox(
                    height: 99.h,
                  ),
            model.time == 0
                ? SvgPicture.asset('assets/image/success.svg')
                : AnimatedRotation(
                    turns: model.turns,
                    duration: const Duration(seconds: 1),
                    child: SizedBox(
                        width: 119.w,
                        height: 119.h,
                        child: Image.asset('assets/image/loading.png'))),
            model.time == 0
                ? SizedBox(
                    height: 75.h,
                  )
                : SizedBox(
                    height: 219.h,
                  ),
            model.time == 0
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Delivery Successful',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).brightness == Brightness.dark
                            ? fontStyle.titleProfile
                            : fontStyle.title,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        'Your Item has been delivered successfully',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).brightness == Brightness.dark
                            ? fontStyle.labelWhite
                            : fontStyle.bigLabelBlack,
                      ),
                      SizedBox(
                        height: 67.h,
                      ),
                    ],
                  )
                : const SizedBox(),
            Text(
              'Rate Rider',
              style: fontStyle.timeLabelResend,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 16.h,
            ),
            Wrap(
                children: List.generate(
                    model.stars.length,
                    (index) => Padding(
                          padding: EdgeInsets.only(
                              right:
                                  index == model.stars.length - 1 ? 0.w : 16.w),
                          child: SvgPicture.asset(
                            Theme.of(context).brightness == Brightness.dark
                                ? 'assets/image/star_dark.svg'
                                : 'assets/image/star.svg',
                            colorFilter: ColorFilter.mode(
                                model.stars[index] == true
                                    ? colors.warning
                                    : Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : colors.gray2,
                                BlendMode.srcIn),
                          ),
                        ))),
            SizedBox(
              height: 36.59.h,
            ),
            Feedback(),
            SizedBox(
              height: 76.h,
            ),
            const DoneButton(),
          ],
        ),
      ),
    ));
  }
}

class Feedback extends StatelessWidget {
  Feedback({super.key});
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SuccessDeliveryModel>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 23.w),
      child: Center(
        child: Container(
          width: 342.w,
          height: 50.h,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? colors.secondaryDark
                : Colors.white,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor,
                spreadRadius: 0,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
              BoxShadow(
                  color: Theme.of(context).shadowColor,
                  offset: const Offset(0, 2),
                  blurRadius: 5,
                  spreadRadius: 0),
            ],
          ),
          child: TextField(
            controller: controller,
            onChanged: (value) {
              if (value.length <= 10) {
                model.body = value;
              } else if (value.length >= 10) {
                controller.text = value.substring(0, 10);
              }
            },
            cursorColor: colors.main,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 22.h),
                prefixIcon: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 17.h),
                  child: SvgPicture.asset('assets/image/feedback.svg'),
                ),
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: 'Add feedback',
                hintStyle: Theme.of(context).brightness == Brightness.dark
                    ? fontStyle.countMsg
                    : fontStyle.termsLabel,
                disabledBorder: InputBorder.none),
          ),
        ),
      ),
    );
  }
}

class DoneButton extends StatelessWidget {
  const DoneButton({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SuccessDeliveryModel>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Center(
        child: SizedBox(
            width: 342.w,
            height: 46.h,
            child: ElevatedButton(
              onPressed: () => model.sendFeedback(model.body, context),
              style: const ButtonStyle(
                  elevation: MaterialStatePropertyAll(0),
                  backgroundColor: MaterialStatePropertyAll(colors.main),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))))),
              child: Text(
                'Done',
                style: fontStyle.titleLabelWhite,
              ),
            )),
      ),
    );
  }
}
