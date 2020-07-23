import 'package:chat_app/widgets/flat_widgets/flat_action_btn.dart';
import 'package:chat_app/widgets/flat_widgets/flat_chat_item.dart';
import 'package:chat_app/widgets/flat_widgets/flat_page_header.dart';
import 'package:chat_app/widgets/flat_widgets/flat_page_wrapper.dart';
import 'package:chat_app/widgets/flat_widgets/flat_profile_image.dart';
import 'package:chat_app/widgets/flat_widgets/flat_section_header.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  static final String id = "Homepage";

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlatPageWrapper(
        scrollType: ScrollType.floatingHeader,
        header: FlatPageHeader(
          prefixWidget: FlatActionButton(
            iconData: Icons.menu,
          ),
          title: "Chatty",
          suffixWidget: FlatActionButton(
            iconData: Icons.search,
          ),
        ),
        children: [
          FlatSectionHeader(
            title: "Chats",
          ),
          FlatChatItem(
            profileImage: FlatProfileImage(
              onlineIndicator: true,
              imageUrl:
                  "https://images.unsplash.com/photo-1573488693582-260a6f1a51c5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1356&q=80",
            ),
            name: "Alix Cage",
          ),
        ],
      ),
    );
  }
}
