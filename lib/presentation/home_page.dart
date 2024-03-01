// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vs1/domain/home_model.dart';
import 'package:vs1/presentation/navigation/navigate.dart';
import 'package:vs1/presentation/style/colors.dart';
import 'package:vs1/presentation/style/fontStyle.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeModel(),
      child: const SubHomePage(),
    );
  }
}

class SubHomePage extends StatefulWidget {
  const SubHomePage({super.key});

  @override
  State<SubHomePage> createState() => _SubHomePageState();
}

class _SubHomePageState extends State<SubHomePage> {
  @override
  void initState() {
    super.initState();
    Supabase.instance.client.auth.onAuthStateChange.listen((event) async {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken != null) {
        await Supabase.instance.client.from('pushProfile').upsert({
          'user_id': Supabase.instance.client.auth.currentSession!.user.id,
          'fcm_token': fcmToken,
        });
      }
    });

    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
      await Supabase.instance.client.from('pushProfile').upsert({
        'user_id': Supabase.instance.client.auth.currentSession!.user.id,
        'fcm_token': fcmToken,
      });
    });

    FirebaseMessaging.onMessage.listen((payload) {
      final notification = payload.notification;
      if (notification != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? colors.secondaryDark
                : Colors.white,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${notification.title}',
                  style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : colors.secondaryDark),
                ),
                Text(
                  '${notification.body}',
                  style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : colors.secondaryDark),
                )
              ],
            )));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<HomeModel>();
    if (model.Error != null && !model.alertError) {
      model.alertError = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('${model.Error}'),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        model.alertError = false;
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
    if (model.connective == 'none' && !model.connectiveAlert) {
      model.connectiveAlert = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('No internet'),
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 24.h,
              ),
              const SearchField(),
              SizedBox(
                height: 24.h,
              ),
              const ProfileInfo(),
              SizedBox(
                height: 39.h,
              ),
              const Specials(),
              SizedBox(
                height: 7.h,
              ),
              const Adds(),
              SizedBox(
                height: 29.h,
              ),
              Text(
                'What would you like to do',
                style: fontStyle.titleServices,
              ),
              SizedBox(
                height: 9.h,
              ),
              const Cards(),
            ],
          ),
        ),
      ),
    ));
  }
}

class Adds extends StatelessWidget {
  const Adds({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<HomeModel>();
    return SizedBox(
      height: 64.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: model.bytes.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) => Padding(
          padding:
              EdgeInsets.only(right: index == model.bytes.length ? 0.w : 12.w),
          child: Image.memory(model.bytes[index]),
        ),
      ),
    );
  }
}

class TechAdd extends StatelessWidget {
  const TechAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 166.w,
      height: 64.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colors.secondary),
          image: const DecorationImage(
              image: AssetImage('assets/image/first_add.png'),
              fit: BoxFit.cover)),
    );
  }
}

class BoxedAdd extends StatelessWidget {
  const BoxedAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 166.w,
      height: 64.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colors.secondary),
          image: const DecorationImage(
              image: AssetImage(
                'assets/image/second_add.png',
              ),
              fit: BoxFit.cover)),
    );
  }
}

class Specials extends StatelessWidget {
  const Specials({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Special for you',
          style: fontStyle.specialSecondary,
        ),
        const Spacer(),
        SvgPicture.asset('assets/image/arrow_start.svg'),
      ],
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 341.w,
        height: 34.h,
        child: TextField(
          showCursor: false,
          cursorColor: colors.main,
          decoration: InputDecoration(
            filled: true,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
            hintText: 'Search services',
            hintStyle: Theme.of(context).brightness == Brightness.dark
                ? fontStyle.countMsg
                : fontStyle.termsLabel,
            suffixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 11.h),
              child: SvgPicture.asset('assets/image/search.svg'),
            ),
            border: Theme.of(context).inputDecorationTheme.enabledBorder,
            errorBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
            enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
            focusedBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
            disabledBorder:
                Theme.of(context).inputDecorationTheme.enabledBorder,
          ),
        ));
  }
}

class Cards extends StatelessWidget {
  const Cards({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<HomeModel>();
    return Wrap(
      children: List.generate(
          model.cards.length,
          (index) => CardsItem(
                index: index,
              )),
    );
  }
}

class CardsItem extends StatelessWidget {
  int index;
  CardsItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<HomeModel>();
    return GestureDetector(
      onTap: () => model.goToScreen(context, model.routes[index]),
      child: Padding(
        padding: EdgeInsets.only(
            bottom: 23.h, right: index == 0 || index == 2 ? 23.w : 0.w),
        child: Container(
          width: 159.w,
          height: 159.h,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? colors.secondaryDark
                : colors.gray6,
            borderRadius: BorderRadius.circular(8),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 32.5.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: SvgPicture.asset(
                  'assets/image/${model.cards[index].picture}.svg',
                  colorFilter:
                      const ColorFilter.mode(colors.main, BlendMode.srcIn),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.cards[index].title,
                      style: fontStyle.trackId,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    SizedBox(
                        width: 127.w,
                        child: Text(
                          model.cards[index].label,
                          style: Theme.of(context).textTheme.labelSmall,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<HomeModel>();
    return Container(
      width: 341.w,
      height: 91.h,
      decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? colors.secondaryDark
              : colors.main,
          borderRadius: BorderRadius.circular(8)),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Theme.of(context).brightness == Brightness.dark
                        ? SvgPicture.asset('assets/image/ellipse_left_dark.svg')
                        : SvgPicture.asset('assets/image/ellipse_left.svg'),
                  )),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(3),
                child: Theme.of(context).brightness == Brightness.dark
                    ? SvgPicture.asset('assets/image/ellipse_right_dark.svg')
                    : SvgPicture.asset('assets/image/ellipse_right.svg'),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 10.w,
              ),
              GestureDetector(
                onTap: () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Choose method'),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                model.uploadImage(ImageSource.camera);
                              },
                              child: Text(
                                'Camera',
                                style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : colors.secondaryDark),
                              )),
                          ElevatedButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                                final error = await model
                                    .uploadImage(ImageSource.gallery);
                              },
                              child: Text(
                                'Gallery',
                                style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : colors.secondaryDark),
                              )),
                        ],
                      );
                    }),
                child: Container(
                  width: 60.14.w,
                  height: 60.14.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: model.image == null
                        ? const DecorationImage(
                            image: AssetImage('assets/image/avatar.png'),
                            fit: BoxFit.cover)
                        : DecorationImage(
                            image: MemoryImage(model.image as Uint8List),
                            fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(
                width: 6.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    style: fontStyle.titleProfile,
                  ),
                  Text(
                    'We trust you are having a great time',
                    style: fontStyle.hintSend,
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                  onTap: () => Navigator.of(context)
                      .pushNamed(NavigateRoute.notification),
                  child: SvgPicture.asset('assets/image/bell.svg')),
              SizedBox(
                width: 10.w,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
