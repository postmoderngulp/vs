import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vs1/domain/session%204/check_info_model.dart';
import 'package:vs1/presentation/style/colors.dart';
import 'package:vs1/presentation/style/fontStyle.dart';

class CheckInfo extends StatelessWidget {
  const CheckInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CheckInfoModel(),
      child: const SubCheckInfo(),
    );
  }
}

class SubCheckInfo extends StatelessWidget {
  const SubCheckInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<CheckInfoModel>();
    return Container(
      child: SafeArea(
          child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(84.h),
          child: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
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
                            child: SvgPicture.asset(
                                'assets/image/back_button.svg')),
                      ),
                      const Spacer(),
                      Text(
                        'Package Delivered',
                        style: Theme.of(context).brightness == Brightness.dark
                            ? fontStyle.activeTrackId
                            : fontStyle.appBarTitle,
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
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                const PackageInformation(),
                SizedBox(
                  height: 37.h,
                ),
                Center(
                    child: SvgPicture.asset(
                        Theme.of(context).brightness == Brightness.dark
                            ? 'assets/image/divider_dark.svg'
                            : 'assets/image/divider.svg')),
                const Charges(),
                Center(
                    child: SvgPicture.asset(
                        Theme.of(context).brightness == Brightness.dark
                            ? 'assets/image/divider_dark.svg'
                            : 'assets/image/divider.svg')),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Package total',
                      style: Theme.of(context).brightness == Brightness.dark
                          ? fontStyle.countMsg
                          : fontStyle.hintSend,
                    ),
                    const Spacer(),
                    Text(
                      'N${model.total}.00',
                      style: fontStyle.hintSecondary,
                    ),
                  ],
                ),
                SizedBox(
                  height: 24.h,
                ),
                Text(
                  'Click on  delivered for successful delivery and rate rider or report missing item',
                  style: fontStyle.bottomLabelActive,
                ),
                SizedBox(
                  height: 24.h,
                ),
                const GroupButton()
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class GroupButton extends StatelessWidget {
  const GroupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReportButton(),
        Spacer(),
        SuccesfultButton(),
      ],
    ));
  }
}

class ReportButton extends StatelessWidget {
  const ReportButton({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<CheckInfoModel>();
    return SizedBox(
        width: 158.w,
        height: 46.h,
        child: ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
              elevation: const MaterialStatePropertyAll(0),
              backgroundColor: MaterialStatePropertyAll(
                  Theme.of(context).colorScheme.primary),
              shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                  side: BorderSide(color: colors.main),
                  borderRadius: BorderRadius.all(Radius.circular(8))))),
          child: Text(
            'Report',
            style: fontStyle.titleLabelMain,
          ),
        ));
  }
}

class PackageInformation extends StatelessWidget {
  const PackageInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<CheckInfoModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24.h,
        ),
        Text(
          'Package Information',
          style: fontStyle.titleInfo,
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(
          'Origin details',
          style: Theme.of(context).brightness == Brightness.dark
              ? fontStyle.labelGrayBlue
              : fontStyle.labelBlack,
        ),
        SizedBox(
          height: 4.h,
        ),
        Text(
          '${model.packageInfo != null ? model.packageInfo!.originDetail.address : ''}, ${model.packageInfo != null ? model.packageInfo!.originDetail.state : ''}',
          style: Theme.of(context).brightness == Brightness.dark
              ? fontStyle.countMsg
              : fontStyle.hintSend,
        ),
        SizedBox(
          height: 4.h,
        ),
        Text(
          '+${model.packageInfo != null ? model.packageInfo!.originDetail.number : ''}',
          style: Theme.of(context).brightness == Brightness.dark
              ? fontStyle.countMsg
              : fontStyle.hintSend,
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(
          'Destination details',
          style: Theme.of(context).brightness == Brightness.dark
              ? fontStyle.labelGrayBlue
              : fontStyle.labelBlack,
        ),
        SizedBox(
          height: 4.h,
        ),
        const Destinations(),
        SizedBox(
          height: 9.h,
        ),
        Text(
          'Other details',
          style: Theme.of(context).brightness == Brightness.dark
              ? fontStyle.labelGrayBlue
              : fontStyle.labelBlack,
        ),
        SizedBox(
          height: 4.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Package Items',
              style: Theme.of(context).brightness == Brightness.dark
                  ? fontStyle.countMsg
                  : fontStyle.hintSend,
            ),
            const Spacer(),
            Text(
              model.packageInfo != null ? model.packageInfo!.package.items : '',
              style: fontStyle.hintSecondary,
            ),
          ],
        ),
        SizedBox(
          height: 8.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Weight of items',
              style: Theme.of(context).brightness == Brightness.dark
                  ? fontStyle.countMsg
                  : fontStyle.hintSend,
            ),
            const Spacer(),
            Text(
              '${model.packageInfo != null ? model.packageInfo!.package.weight : ''}kg',
              style: fontStyle.hintSecondary,
            ),
          ],
        ),
        SizedBox(
          height: 7.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Worth of Items',
              style: Theme.of(context).brightness == Brightness.dark
                  ? fontStyle.countMsg
                  : fontStyle.hintSend,
            ),
            const Spacer(),
            Text(
              'N${model.packageInfo != null ? model.packageInfo!.package.worthItems : ''}',
              style: fontStyle.hintSecondary,
            ),
          ],
        ),
        SizedBox(
          height: 8.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tracking Number',
              style: Theme.of(context).brightness == Brightness.dark
                  ? fontStyle.countMsg
                  : fontStyle.hintSend,
            ),
            const Spacer(),
            Text(
              'R-${model.uuid}',
              style: fontStyle.hintSecondary,
            ),
          ],
        ),
      ],
    );
  }
}

class Charges extends StatelessWidget {
  const Charges({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<CheckInfoModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 8.h,
        ),
        Text(
          'Charges',
          style: fontStyle.titleInfo,
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Delivery Charges',
              style: Theme.of(context).brightness == Brightness.dark
                  ? fontStyle.countMsg
                  : fontStyle.hintSend,
            ),
            const Spacer(),
            Text(
              'N${model.deliveryCharges}.00',
              style: fontStyle.hintSecondary,
            ),
          ],
        ),
        SizedBox(
          height: 8.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Instant delivery',
              style: Theme.of(context).brightness == Brightness.dark
                  ? fontStyle.countMsg
                  : fontStyle.hintSend,
            ),
            const Spacer(),
            Text(
              'N${model.instantDelivery}.00',
              style: fontStyle.hintSecondary,
            ),
          ],
        ),
        SizedBox(
          height: 8.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tax and Service Charges',
              style: Theme.of(context).brightness == Brightness.dark
                  ? fontStyle.countMsg
                  : fontStyle.hintSend,
            ),
            const Spacer(),
            Text(
              'N${model.tax}.00',
              style: fontStyle.hintSecondary,
            ),
          ],
        ),
        SizedBox(
          height: 9.h,
        ),
      ],
    );
  }
}

class Destinations extends StatelessWidget {
  const Destinations({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<CheckInfoModel>();
    return ListView.builder(
      itemCount: model.packageInfo != null
          ? model.packageInfo?.destinationDetails.length
          : 0,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: EdgeInsets.only(bottom: index == 1 ? 0.h : 8.h),
        child: DestinationsItem(index: index),
      ),
    );
  }
}

class DestinationsItem extends StatelessWidget {
  int index;
  DestinationsItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<CheckInfoModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${index + 1}. ${model.packageInfo != null ? model.packageInfo!.destinationDetails[index].address : ''},  ${model.packageInfo != null ? model.packageInfo!.destinationDetails[index].state : ''}',
          style: Theme.of(context).brightness == Brightness.dark
              ? fontStyle.countMsg
              : fontStyle.hintSend,
        ),
        SizedBox(
          height: 4.h,
        ),
        Text(
          '+${model.packageInfo != null ? model.packageInfo!.destinationDetails[index].number : ''}',
          style: Theme.of(context).brightness == Brightness.dark
              ? fontStyle.countMsg
              : fontStyle.hintSend,
        ),
      ],
    );
  }
}

class SuccesfultButton extends StatelessWidget {
  const SuccesfultButton({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<CheckInfoModel>();
    return SizedBox(
        width: 159.w,
        height: 48.h,
        child: ElevatedButton(
          onPressed: () => model.goToSuccess(context),
          style: const ButtonStyle(
              elevation: MaterialStatePropertyAll(0),
              backgroundColor: MaterialStatePropertyAll(colors.main),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))))),
          child: Text(
            'Successful',
            style: Theme.of(context).brightness == Brightness.dark
                ? fontStyle.titleLabelPrimary
                : fontStyle.titleLabelWhite,
          ),
        ));
  }
}
