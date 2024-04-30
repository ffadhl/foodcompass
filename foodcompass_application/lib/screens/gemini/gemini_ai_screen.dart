import 'dart:io';
import 'dart:typed_data';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';

class GeminiAiScreen extends StatefulWidget {
  const GeminiAiScreen({super.key});

  @override
  State<GeminiAiScreen> createState() => _GeminiAiScreenState();
}

class _GeminiAiScreenState extends State<GeminiAiScreen> {
  final Gemini gemini = Gemini.instance;
  List<ChatMessage> messages = [];

  ChatUser currentUser = ChatUser(
    id: "0",
    firstName: "User",
  );

  ChatUser geminiUser = ChatUser(
    id: "1",
    firstName: "CompassBot",
    profileImage:
        "https://static.promediateknologi.id/crop/0x0:0x0/0x0/webp/photo/p2/106/2024/03/28/202403271806-maincropped_1711537586-457414092.jpg",
  );

  void onSend(ChatMessage chatMessage) {
    setState(() {
      messages.insert(0, chatMessage);
    });

    try {
      String question = chatMessage.text;
      List<Uint8List>? images;
      if (chatMessage.medias?.isNotEmpty == true) {
        images = [
          File(chatMessage.medias!.first.url).readAsBytesSync(),
        ];
      }
      gemini
          .streamGenerateContent(
        question,
        images: images,
      )
          .listen((event) {
        ChatMessage? lastMessage = messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == geminiUser) {
          lastMessage = messages.removeAt(0);
          String response = event.content?.parts?.fold(
                  "",
                  (previousValue, element) =>
                      "$previousValue${element.text}") ??
              "";

          lastMessage.text += response;
          setState(() {
            messages.insert(0, lastMessage!);
          });
        } else {
          String response = event.content?.parts?.fold(
                  "",
                  (previousValue, element) =>
                      "$previousValue${element.text}") ??
              "";
          ChatMessage message = ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: response,
          );

          setState(() {
            messages.insert(0, message);
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void _sendMediaMessage() async {
    ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      ChatMessage chatMessage = ChatMessage(
        user: currentUser,
        createdAt: DateTime.now(),
        text:
            "Hi CompassBot!, dari gambar ini, merupakan makanan apa? dan carikan Resepnya!",
        medias: [
          ChatMedia(
            url: image.path,
            fileName: "",
            type: MediaType.image,
          )
        ],
      );

      onSend(chatMessage);
    }
  }

  void _initialMessage() {
    ChatMessage message = ChatMessage(
      user: geminiUser,
      createdAt: DateTime.now(),
      text:
          "Hai! Saya CompassBot, siap membantu Anda menemukan resep makanan yang Anda inginkan. Anda bisa memulai dengan memasukkan nama makanan yang ingin Anda ketahui resepnya atau langsung mengirimkan gambar makanan.\n\nBerlaku aturan berikut:\n\n1. Masukkan nama makanan.\n2. Masukkan gambar makanan.\n\nTunggu sebentar, saya akan mencarikan resepnya untuk Anda.\n\nSelamat mencoba!",
    );

    setState(() {
      messages.insert(0, message);
    });
  }

  @override
  void initState() {
    _initialMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Compass',
                style: TextStyleConstant.poppinsMedium.copyWith(
                  color: ColorConstant.colorOrange,
                  fontSize: 20.0,
                ),
              ),
              TextSpan(
                text: 'Bot',
                style: TextStyleConstant.poppinsMedium.copyWith(
                  color: ColorConstant.colorBlack,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: DashChat(
        currentUser: currentUser,
        onSend: onSend,

        messages: messages,
        inputOptions: InputOptions(
          trailing: [
            IconButton(
              onPressed: () {
                _sendMediaMessage();
              },
              icon: const Icon(
                LineIcons.image,
                color: ColorConstant.colorOrange,
                size: 20.0,
              ),
            )
          ],
          alwaysShowSend: true,
          sendButtonBuilder: (onSend) {
            return IconButton(
              onPressed: onSend,
              icon: const Icon(
                LineIcons.paperPlane,
                color: ColorConstant.colorOrange,
                size: 24.0,
              ),
            );
          },
        ),
        messageOptions: const MessageOptions(
          currentUserContainerColor: ColorConstant.colorOrange,
        ),
        
      ),
    );
  }
}
