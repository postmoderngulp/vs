// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vs1/domain/chat_rider_model.dart';
import 'package:vs1/entity/message.dart';
import 'package:vs1/entity/profile.dart';
import 'package:vs1/presentation/style/colors.dart';
import 'package:vs1/presentation/style/fontStyle.dart';

class ChatRider extends StatelessWidget {
  const ChatRider({super.key});

  @override
  Widget build(BuildContext context) {
    Profile profile = ModalRoute.of(context)!.settings.arguments as Profile;
    return ChangeNotifierProvider(
      create: (context) => ChatRiderModel(profile),
      child: const SubChatRider(),
    );
  }
}

class SubChatRider extends StatefulWidget {
  const SubChatRider({super.key});

  @override
  State<SubChatRider> createState() => _SubChatRiderState();
}

class _SubChatRiderState extends State<SubChatRider> {
  @override
  void initState() {
    super.initState();
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
    final model = context.watch<ChatRiderModel>();
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 43.08.w,
                            height: 43.08.h,
                            decoration: BoxDecoration(
                                image: model.avatar != null
                                    ? DecorationImage(
                                        image: MemoryImage(
                                            model.avatar as Uint8List),
                                        fit: BoxFit.cover)
                                    : const DecorationImage(
                                        image: AssetImage(
                                            'assets/image/avatar.png'),
                                        fit: BoxFit.cover),
                                border: Border.all(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? colors.secondaryDark
                                        : colors.gray1),
                                shape: BoxShape.circle),
                          ),
                          SizedBox(
                            width: 8.62.w,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4.11.h),
                            child: Text(
                              model.profile.name,
                              style: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? fontStyle.labelWhite
                                  : fontStyle.bigLabelBlack,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                          onTap: () => model.goToCall(context),
                          child: SvgPicture.asset('assets/image/phone.svg')),
                      SizedBox(
                        width: 25.26.w,
                      ),
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
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    const ChatWidget(),
                    SizedBox(
                      height: 45.h,
                    ),
                  ],
                ),
              ),
              const Positioned(bottom: 0, child: ChatTab()),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ChatRiderModel>();
    return model.stream == null
        ? const CircularProgressIndicator()
        : StreamBuilder<List<Message>>(
            stream: model.getMessage(model.profile.user_id),
            builder: (context, snapshot) {
              List<Message> list = [];
              snapshot.hasData ? list = model.filterChat(snapshot.data) : null;
              return ListView.builder(
                controller: model.scrollController,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) => Padding(
                  padding: EdgeInsets.only(
                      bottom: 12.h,
                      left: list[index].userFrom !=
                              Supabase
                                  .instance.client.auth.currentSession!.user.id
                          ? 26.w
                          : 146.w,
                      right: list[index].userFrom !=
                              Supabase
                                  .instance.client.auth.currentSession!.user.id
                          ? 144.w
                          : 24.w),
                  child: ChatWidgetItem(
                    list: list,
                    index: index,
                  ),
                ),
              );
            });
  }
}

class ChatWidgetItem extends StatelessWidget {
  int index;
  List<Message> list;
  ChatWidgetItem({
    Key? key,
    required this.index,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ChatRiderModel>();
    if (list[index].isRead == false) {
      model.setRead(list[index].id);
    }
    return Container(
      width: 220.w,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: list[index].userFrom ==
                  Supabase.instance.client.auth.currentSession!.user.id
              ? colors.main
              : Theme.of(context).brightness == Brightness.dark
                  ? colors.secondaryDark
                  : colors.gray1),
      child: Text(
        list[index].content,
        style: list[index].userFrom ==
                Supabase.instance.client.auth.currentSession!.user.id
            ? fontStyle.myMsg
            : Theme.of(context).brightness == Brightness.dark
                ? fontStyle.myMsg
                : fontStyle.labelTransaction,
      ),
    );
  }
}

class ChatTab extends StatelessWidget {
  const ChatTab({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ChatRiderModel>();
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).colorScheme.primary,
      child: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 13.63.w),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/image/emoji.svg',
              colorFilter: ColorFilter.mode(
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : colors.gray2,
                  BlendMode.srcIn),
            ),
            SizedBox(
              width: 7.w,
            ),
            const ChatField(),
            SizedBox(
              width: 1.w,
            ),
            GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  model.controller.text = '';
                  model.sendMessage(model.msg);
                },
                child: SvgPicture.asset(
                    Theme.of(context).brightness == Brightness.dark
                        ? 'assets/image/triangle_dark.svg'
                        : 'assets/image/triangle.svg')),
          ],
        ),
      ),
    );
  }
}

class ChatField extends StatelessWidget {
  const ChatField({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ChatRiderModel>();
    return Center(
      child: SizedBox(
          width: 267.w,
          height: 40.h,
          child: TextField(
            onEditingComplete: () {
              FocusScope.of(context).unfocus();
              model.controller.text = '';
              model.sendMessage(model.msg);
            },
            controller: model.controller,
            onChanged: (value) {
              model.checkText();
              model.msg = value;
            },
            cursorColor: colors.main,
            decoration: InputDecoration(
              filled: true,
              fillColor: model.hasText
                  ? Theme.of(context).brightness == Brightness.dark
                      ? colors.secondaryDark
                      : Colors.white
                  : Theme.of(context).brightness == Brightness.dark
                      ? colors.secondaryDark
                      : colors.gray1,
              contentPadding:
                  EdgeInsets.only(left: 32.w, top: 12.h, bottom: 30.h),
              hintText: 'Enter message',
              hintStyle: Theme.of(context).brightness == Brightness.dark
                  ? fontStyle.countMsg
                  : fontStyle.termsLabel,
              suffixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 11.h),
                child: SvgPicture.asset(
                  'assets/image/mike.svg',
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : colors.gray2,
                      BlendMode.srcIn),
                ),
              ),
              border: Theme.of(context).inputDecorationTheme.enabledBorder,
              errorBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
              enabledBorder:
                  Theme.of(context).inputDecorationTheme.enabledBorder,
              focusedBorder:
                  Theme.of(context).inputDecorationTheme.enabledBorder,
              disabledBorder:
                  Theme.of(context).inputDecorationTheme.enabledBorder,
            ),
          )),
    );
  }
}
