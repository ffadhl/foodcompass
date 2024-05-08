import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';
import 'package:foodcompass_application/providers/gemini_ai_provider.dart';
import 'package:foodcompass_application/screens/gemini/widget/background_gemini_ai_widget.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class GeminiAiScreen extends StatefulWidget {
  const GeminiAiScreen({super.key});

  @override
  State<GeminiAiScreen> createState() => _GeminiAiScreenState();
}

class _GeminiAiScreenState extends State<GeminiAiScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GeminiAiProvider>(context, listen: false).initialMessage();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.colorWhite,
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
      body: Stack(
        children: [
          const BackgorundGeminiAi(),
          Consumer<GeminiAiProvider>(
            builder: (context, geminiAiProvider, _) {
              return DashChat(
                currentUser: geminiAiProvider.currentUser,
                onSend: geminiAiProvider.onSend,
                messages: geminiAiProvider.message,
                inputOptions: InputOptions(
                  trailing: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: ColorConstant.colorWhite,
                      ),
                      child: IconButton(
                        onPressed: () {
                          geminiAiProvider.sendMediaMessage();
                        },
                        icon: const Icon(
                          LineIcons.image,
                          color: ColorConstant.colorOrange,
                          size: 20.0,
                        ),
                      ),
                    )
                  ],
                  alwaysShowSend: true,
                  sendButtonBuilder: (onSend) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: ColorConstant.colorWhite,
                        ),
                        child: IconButton(
                          onPressed: onSend,
                          icon: const Icon(
                            LineIcons.paperPlane,
                            color: ColorConstant.colorOrange,
                            size: 24.0,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                messageOptions: const MessageOptions(
                  currentUserContainerColor: ColorConstant.colorOrange,
                ),
                scrollToBottomOptions: ScrollToBottomOptions(
                  disabled: false,
                  scrollToBottomBuilder: (scrollController) {
                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: IconButton(
                        onPressed: () {
                          scrollController.animateTo(
                            0.0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        },
                        icon: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            color: ColorConstant.colorOrange,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.arrow_downward,
                              color: ColorConstant.colorWhite,
                              size: 18.0,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
