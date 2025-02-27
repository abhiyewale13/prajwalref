import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double padding = size.width * 0.03;
    // double iconSize = size.width * 0.05;
    double fontSize = size.width * 0.05;

    return Scaffold(
      backgroundColor: const Color(0xff090D14),
      appBar: AppBar(
        backgroundColor: const Color(0xff090D14),
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: SvgPicture.asset(
                "assets/sign_up_assets/back.svg",
                height: size.height * 0.05,
                width: size.width * 0.05,
              ),
            ),
            SizedBox(width: size.width * 0.05),
            Image.asset(
              "assets/messages_assets/pfp.png",
              height: size.height * 0.07,
              width: size.width * 0.07,
            ),
            SizedBox(width: size.width * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "AKS Night",
                  style: GoogleFonts.inter(
                    fontSize: fontSize * 0.8,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "(+44) 23 2443 42424",
                  style: GoogleFonts.inter(
                    fontSize: fontSize * 0.6,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.all(padding),
              child: SvgPicture.asset(
                'assets/messages_assets/phone.svg',
                fit: BoxFit.scaleDown,
              ),
            ),
          ],
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(padding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              chatBubble("I'm just around the corner from your palce", false),
              chatBubble("Hi!", true),
              chatBubble("Thanks for letting me knw!", true),
              chatBubble("No problem at all", false),
              chatBubble("I will text you when I arrive", false),
              chatBubble("Great", true),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(padding),
        child: Container(
          color: const Color(0xff090D14),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Type a message...",
                    hintStyle: GoogleFonts.inter(color: Colors.white60),
                    filled: true,
                    fillColor: Colors.grey.shade800,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                ),
              ),
              SizedBox(width: 10),
              Container(
                padding: EdgeInsets.all(padding),
                decoration: BoxDecoration(
                  color: Color(0xff3579DD),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.send, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget chatBubble(String message, bool isSender) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: 250),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: isSender ? Color(0xff3579DD) : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: isSender ? Radius.circular(12) : Radius.zero,
            bottomRight: isSender ? Radius.zero : Radius.circular(12),
          ),
        ),
        child: Text(
          message,
          softWrap: true,
          overflow: TextOverflow.visible,
          style: TextStyle(
            color: isSender ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
