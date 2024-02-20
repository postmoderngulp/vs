// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vs1/domain/session%205/chats_model.dart';
import 'package:vs1/presentation/navigation/navigate.dart';
import 'package:vs1/presentation/style/colors.dart';
import 'package:vs1/presentation/style/fontStyle.dart';

class Chats extends StatelessWidget {
  const Chats({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatsModel(),
      child: const SubChats(),
    );
  }
}

class SubChats extends StatelessWidget {
  const SubChats({super.key});

  @override
  Widget build(BuildContext context) {
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
                      'Chats',
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
          padding: EdgeInsets.symmetric(horizontal: 23.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 21.h,
              ),
              const SearchField(),
              SizedBox(
                height: 27.h,
              ),
              const ListChat()
            ],
          ),
        ),
      ),
    ));
  }
}

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ChatsModel>();
    return Center(
      child: SizedBox(
          width: 341.w,
          height: 34.h,
          child: TextField(
            onChanged: (value) => model.searchChat(value),
            cursorColor: colors.main,
            decoration: InputDecoration(
              filled: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
              hintText: 'Search for a driver',
              hintStyle: Theme.of(context).brightness == Brightness.dark
                  ? fontStyle.countMsg
                  : fontStyle.termsLabel,
              suffixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 11.h),
                child: SvgPicture.asset('assets/image/search.svg'),
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

class ListChat extends StatelessWidget {
  const ListChat({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ChatsModel>();
    return ListView.builder(
      shrinkWrap: true,
      itemCount: model.users.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: EdgeInsets.only(bottom: 16.h),
        child: ChatItem(
          index: index,
        ),
      ),
    );
  }
}

class ChatItem extends StatelessWidget {
  int index;
  ChatItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ChatsModel>();
    return GestureDetector(
      onTap: () => model.goToChatRider(context, model.users[index]),
      child: Container(
        width: 342.w,
        height: 84.2.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).brightness == Brightness.dark
                ? colors.secondaryDark
                : Colors.white,
            border: Border.all(
                color: Theme.of(context).brightness == Brightness.dark
                    ? colors.secondaryDark
                    : colors.gray2)),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            width: 10.w,
          ),
          Container(
            width: 60.14.w,
            height: 60.14.h,
            decoration: BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage('assets/image/avatar.png'),
                    fit: BoxFit.cover),
                border: Border.all(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : colors.gray1),
                shape: BoxShape.circle),
          ),
          SizedBox(
            width: 6.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.users[index].name,
                style: Theme.of(context).brightness == Brightness.dark
                    ? fontStyle.titleLabelWhite
                    : fontStyle.titleLabel,
              ),
              Text(
                'Thanks for your service',
                style: Theme.of(context).brightness == Brightness.dark
                    ? fontStyle.countMsg
                    : fontStyle.labelBlack,
              ),
            ],
          ),
          const Spacer(),
          Container(
            width: 26.w,
            height: 26.h,
            decoration:
                const BoxDecoration(color: colors.main, shape: BoxShape.circle),
            child: Center(
              child: Text(
                '1',
                textAlign: TextAlign.center,
                style: fontStyle.countMsg,
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
        ]),
      ),
    );
  }
}
