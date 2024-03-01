import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vs1/presentation/style/colors.dart';
import 'package:vs1/presentation/style/fontStyle.dart';
import '../domain/transaction_model.dart';

class Transaction extends StatelessWidget {
  const Transaction({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TransactionModel(),
      child: const SubTransaction(),
    );
  }
}

class SubTransaction extends StatelessWidget {
  const SubTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TransactionModel>();
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
      body: Center(
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
                    height: 130.h,
                  ),
            model.time == 0
                ? Text(
                    'Transaction Successful',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).brightness == Brightness.dark
                        ? fontStyle.titleProfile
                        : fontStyle.title,
                  )
                : const SizedBox(),
            model.time == 0
                ? SizedBox(
                    height: 8.h,
                  )
                : const SizedBox(),
            Text(
              'Your rider is on the way to your destination',
              textAlign: TextAlign.center,
              style: Theme.of(context).brightness == Brightness.dark
                  ? fontStyle.labelWhite
                  : fontStyle.bigLabelBlack,
            ),
            SizedBox(
              height: 8.h,
            ),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'Tracking Number',
                    style: Theme.of(context).brightness == Brightness.dark
                        ? fontStyle.labelWhite
                        : fontStyle.bigLabelBlack,
                    children: [
                      TextSpan(
                        text: ' R-${model.uuid}',
                        style: fontStyle.timeLabelResend,
                      )
                    ])),
            SizedBox(
              height: 141.h,
            ),
            const TrackButton(),
            SizedBox(
              height: 8.h,
            ),
            const BackButton()
          ],
        ),
      ),
    ));
  }
}

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TransactionModel>();
    return SizedBox(
        width: 342.w,
        height: 46.h,
        child: ElevatedButton(
          onPressed: () => model.goToHome(context),
          style: ButtonStyle(
              elevation: const MaterialStatePropertyAll(0),
              backgroundColor: MaterialStatePropertyAll(
                  Theme.of(context).colorScheme.primary),
              shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                  side: BorderSide(color: colors.main),
                  borderRadius: BorderRadius.all(Radius.circular(8))))),
          child: Text(
            'Go back to homepage',
            style: fontStyle.titleLabelMain,
          ),
        ));
  }
}

class TrackButton extends StatelessWidget {
  const TrackButton({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TransactionModel>();
    return SizedBox(
        width: 342.w,
        height: 46.h,
        child: ElevatedButton(
          onPressed: () => model.goTrack(context),
          style: const ButtonStyle(
              elevation: MaterialStatePropertyAll(0),
              backgroundColor: MaterialStatePropertyAll(colors.main),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))))),
          child: Text(
            'Track my item',
            style: fontStyle.titleLabelWhite,
          ),
        ));
  }
}
