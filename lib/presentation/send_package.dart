// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vs1/domain/send_model.dart';
import 'package:vs1/presentation/style/colors.dart';
import 'package:vs1/presentation/style/fontStyle.dart';

class SendPackage extends StatelessWidget {
  const SendPackage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SendModel(),
      child: const SubSendPackage(),
    );
  }
}

class SubSendPackage extends StatelessWidget {
  const SubSendPackage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SendModel>();
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
                      'Send a package',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 43.h,
              ),
              const OriginDetails(),
              SizedBox(
                height: 24.h,
              ),
              const Destination(),
              SizedBox(
                height: 10.h,
              ),
              const AddDestination(),
              SizedBox(
                height: 13.h,
              ),
              const Package(),
              SizedBox(
                height: 39.h,
              ),
              Text(
                'Select delivery type',
                style: Theme.of(context).brightness == Brightness.dark
                    ? fontStyle.titleDelivery
                    : fontStyle.field,
              ),
              SizedBox(
                height: 16.h,
              ),
              const Delivery(),
              SizedBox(
                height: 15.h,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class Delivery extends StatelessWidget {
  const Delivery({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const InstantDelivery(),
        SizedBox(
          width: 24.w,
        ),
        const ScheduledDelivery()
      ],
    );
  }
}

class InstantDelivery extends StatelessWidget {
  const InstantDelivery({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SendModel>();
    return GestureDetector(
      onTap: () => model.goToSendInfo(context),
      child: Container(
        width: 159.w,
        height: 75.h,
        decoration: BoxDecoration(
            color: colors.main,
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
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            SizedBox(
              height: 13.h,
            ),
            SvgPicture.asset(
              'assets/image/clock.svg',
            ),
            SizedBox(
              height: 10.h,
            ),
            Text('Instant delivery', style: fontStyle.titleDelivery),
          ],
        ),
      ),
    );
  }
}

class ScheduledDelivery extends StatelessWidget {
  const ScheduledDelivery({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 159.w,
      height: 75.h,
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
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          SizedBox(
            height: 13.h,
          ),
          SvgPicture.asset(
            'assets/image/calendar.svg',
            colorFilter: ColorFilter.mode(
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : colors.gray2,
                BlendMode.srcIn),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text('Scheduled delivery',
              style: Theme.of(context).brightness == Brightness.dark
                  ? TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700)
                  : fontStyle.labelGreyBoard),
        ],
      ),
    );
  }
}

class OriginDetails extends StatelessWidget {
  const OriginDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset('assets/image/details.svg'),
            SizedBox(
              width: 8.w,
            ),
            Text(
              'Origin Details',
              style: Theme.of(context).brightness == Brightness.dark
                  ? fontStyle.titleDelivery
                  : fontStyle.field,
            ),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        const OriginAddress(),
        SizedBox(
          height: 5.h,
        ),
        const OriginState(),
        SizedBox(
          height: 5.h,
        ),
        const OriginPhone(),
        SizedBox(
          height: 5.h,
        ),
        const OriginOthers(),
      ],
    );
  }
}

class Package extends StatelessWidget {
  const Package({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Package Details',
          style: Theme.of(context).brightness == Brightness.dark
              ? fontStyle.titleDelivery
              : fontStyle.field,
        ),
        SizedBox(
          height: 8.h,
        ),
        const PackageItems(),
        SizedBox(
          height: 8.h,
        ),
        const Weight(),
        SizedBox(
          height: 8.h,
        ),
        const Worth()
      ],
    );
  }
}

class PackageItems extends StatelessWidget {
  const PackageItems({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SendModel>();
    return Container(
      width: 342.w,
      height: 32.h,
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
        style: Theme.of(context).brightness == Brightness.dark
            ? fontStyle.countMsg
            : fontStyle.labelBlack,
        onChanged: (value) => model.packageInfo.package.items = value,
        cursorColor: colors.main,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: "package items",
          hintStyle: Theme.of(context).brightness == Brightness.dark
              ? fontStyle.countMsg
              : fontStyle.hintSend,
        ),
      ),
    );
  }
}

class Weight extends StatelessWidget {
  const Weight({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SendModel>();
    return Container(
      width: 342.w,
      height: 32.h,
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
        style: Theme.of(context).brightness == Brightness.dark
            ? fontStyle.countMsg
            : fontStyle.labelBlack,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          model.packageInfo.package.weight = value;
        },
        cursorColor: colors.main,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: "Weight of item(kg)",
          hintStyle: Theme.of(context).brightness == Brightness.dark
              ? fontStyle.countMsg
              : fontStyle.hintSend,
        ),
      ),
    );
  }
}

class Worth extends StatefulWidget {
  const Worth({super.key});

  @override
  State<Worth> createState() => _WorthState();
}

class _WorthState extends State<Worth> {
  bool val = false;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final model = context.watch<SendModel>();
    return Container(
      width: 342.w,
      height: 32.h,
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
        style: Theme.of(context).brightness == Brightness.dark
            ? fontStyle.countMsg
            : fontStyle.labelBlack,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          if (val == false) {
            setState(() {
              controller.text = 'N$value';
              val = true;
            });
          } else if (controller.text.isEmpty) {
            setState(() {
              val = false;
            });
          }
          model.packageInfo.package.worthItems = value;
        },
        cursorColor: colors.main,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: "Worth of Items",
          hintStyle: Theme.of(context).brightness == Brightness.dark
              ? fontStyle.countMsg
              : fontStyle.hintSend,
        ),
      ),
    );
  }
}

class AddDestination extends StatelessWidget {
  const AddDestination({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SendModel>();
    return GestureDetector(
      onTap: () => model.addDestination(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/image/add.svg'),
          SizedBox(
            width: 6.w,
          ),
          Text(
            'Add destination',
            style: Theme.of(context).brightness == Brightness.dark
                ? fontStyle.countMsg
                : fontStyle.termsLabel,
          ),
        ],
      ),
    );
  }
}

class Destination extends StatelessWidget {
  const Destination({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SendModel>();
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: model.packageInfo.destinationDetails.length,
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: index == model.packageInfo.destinationDetails.length - 1
            ? EdgeInsets.only(bottom: 0.h)
            : EdgeInsets.only(bottom: 24.h),
        child: DestinationItem(index: index),
      ),
    );
  }
}

class DestinationItem extends StatelessWidget {
  int index;
  DestinationItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset('assets/image/location.svg'),
            SizedBox(
              width: 8.w,
            ),
            Text(
              'Destination Details',
              style: Theme.of(context).brightness == Brightness.dark
                  ? fontStyle.titleDelivery
                  : fontStyle.field,
            ),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        DestinationAddress(
          index: index,
        ),
        SizedBox(
          height: 5.h,
        ),
        DestinationState(
          index: index,
        ),
        SizedBox(
          height: 5.h,
        ),
        DestinationPhone(
          index: index,
        ),
        SizedBox(
          height: 5.h,
        ),
        DestinationOthers(
          index: index,
        ),
      ],
    );
  }
}

class DestinationAddress extends StatelessWidget {
  int index;
  DestinationAddress({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SendModel>();
    return Container(
      width: 342.w,
      height: 32.h,
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
        onChanged: (value) =>
            model.packageInfo.destinationDetails[index].address = value,
        cursorColor: colors.main,
        style: Theme.of(context).brightness == Brightness.dark
            ? fontStyle.countMsg
            : fontStyle.labelBlack,
        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: "Address",
            hintStyle: Theme.of(context).brightness == Brightness.dark
                ? fontStyle.countMsg
                : fontStyle.hintSend),
      ),
    );
  }
}

class OriginAddress extends StatelessWidget {
  const OriginAddress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SendModel>();
    return Container(
      width: 342.w,
      height: 32.h,
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
        onChanged: (value) => model.packageInfo.originDetail.address = value,
        cursorColor: colors.main,
        style: Theme.of(context).brightness == Brightness.dark
            ? fontStyle.countMsg
            : fontStyle.labelBlack,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          labelText: model.packageInfo.originDetail.address.isNotEmpty
              ? model.packageInfo.originDetail.address
              : 'Address',
          labelStyle: Theme.of(context).brightness == Brightness.dark
              ? fontStyle.countMsg
              : fontStyle.labelBlack,
          hintText: "Address",
          hintStyle: Theme.of(context).brightness == Brightness.dark
              ? fontStyle.countMsg
              : fontStyle.hintSend,
        ),
      ),
    );
  }
}

class OriginState extends StatelessWidget {
  const OriginState({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SendModel>();
    return Container(
      width: 342.w,
      height: 32.h,
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
        onChanged: (value) => model.packageInfo.originDetail.state = value,
        cursorColor: colors.main,
        style: Theme.of(context).brightness == Brightness.dark
            ? fontStyle.countMsg
            : fontStyle.labelBlack,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          labelText: model.packageInfo.originDetail.state.isNotEmpty
              ? model.packageInfo.originDetail.state
              : 'State',
          labelStyle: Theme.of(context).brightness == Brightness.dark
              ? fontStyle.countMsg
              : fontStyle.labelBlack,
          hintText: "State,Country",
          hintStyle: Theme.of(context).brightness == Brightness.dark
              ? fontStyle.countMsg
              : fontStyle.hintSend,
        ),
      ),
    );
  }
}

class DestinationState extends StatelessWidget {
  int index;
  DestinationState({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SendModel>();
    return Container(
      width: 342.w,
      height: 32.h,
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
        onChanged: (value) =>
            model.packageInfo.destinationDetails[index].state = value,
        cursorColor: colors.main,
        style: Theme.of(context).brightness == Brightness.dark
            ? fontStyle.countMsg
            : fontStyle.labelBlack,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: "State,Country",
          hintStyle: Theme.of(context).brightness == Brightness.dark
              ? fontStyle.countMsg
              : fontStyle.hintSend,
        ),
      ),
    );
  }
}

class OriginPhone extends StatefulWidget {
  const OriginPhone({super.key});

  @override
  State<OriginPhone> createState() => _OriginPhoneState();
}

class _OriginPhoneState extends State<OriginPhone> {
  bool val = false;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final model = context.watch<SendModel>();
    return Container(
      width: 342.w,
      height: 32.h,
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
        keyboardType: TextInputType.number,
        onChanged: (value) {
          if (val == false) {
            setState(() {
              controller.text = '+$value';
              val = true;
            });
          } else if (controller.text.isEmpty) {
            setState(() {
              val = false;
            });
          }
          model.packageInfo.originDetail.number = value;
        },
        cursorColor: colors.main,
        style: Theme.of(context).brightness == Brightness.dark
            ? fontStyle.countMsg
            : fontStyle.labelBlack,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: "Phone number",
          hintStyle: Theme.of(context).brightness == Brightness.dark
              ? fontStyle.countMsg
              : fontStyle.hintSend,
        ),
      ),
    );
  }
}

class DestinationPhone extends StatefulWidget {
  int index;
  DestinationPhone({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<DestinationPhone> createState() => _DestinationPhoneState();
}

class _DestinationPhoneState extends State<DestinationPhone> {
  TextEditingController controller = TextEditingController();

  bool val = false;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SendModel>();
    return Container(
      width: 342.w,
      height: 32.h,
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
        keyboardType: TextInputType.number,
        onChanged: (value) {
          if (val == false) {
            setState(() {
              controller.text = '+$value';
              val = true;
            });
          } else if (controller.text.isEmpty) {
            setState(() {
              val = false;
            });
          }
          model.packageInfo.destinationDetails[widget.index].number = value;
        },
        cursorColor: colors.main,
        style: Theme.of(context).brightness == Brightness.dark
            ? fontStyle.countMsg
            : fontStyle.labelBlack,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: "Phone number",
          hintStyle: Theme.of(context).brightness == Brightness.dark
              ? fontStyle.countMsg
              : fontStyle.hintSend,
        ),
      ),
    );
  }
}

class OriginOthers extends StatelessWidget {
  const OriginOthers({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SendModel>();
    return Container(
      width: 342.w,
      height: 32.h,
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
        onChanged: (value) => model.packageInfo.originDetail.others = value,
        cursorColor: colors.main,
        style: Theme.of(context).brightness == Brightness.dark
            ? fontStyle.countMsg
            : fontStyle.labelBlack,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: "Others",
          hintStyle: Theme.of(context).brightness == Brightness.dark
              ? fontStyle.countMsg
              : fontStyle.hintSend,
        ),
      ),
    );
  }
}

class DestinationOthers extends StatelessWidget {
  int index;
  DestinationOthers({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SendModel>();
    return Container(
      width: 342.w,
      height: 32.h,
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
        onChanged: (value) =>
            model.packageInfo.destinationDetails[index].others = value,
        cursorColor: colors.main,
        style: Theme.of(context).brightness == Brightness.dark
            ? fontStyle.countMsg
            : fontStyle.labelBlack,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: "Others",
          hintStyle: Theme.of(context).brightness == Brightness.dark
              ? fontStyle.countMsg
              : fontStyle.hintSend,
        ),
      ),
    );
  }
}
