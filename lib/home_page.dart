import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:youtalk/features_box.dart';
import 'package:youtalk/openai_service.dart';
import 'package:youtalk/pallete.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final speechToText = SpeechToText();
  SpeechToText speechToText = SpeechToText();
  bool isListening = false;
  final flutterTts = FlutterTts();
  String lastwords = "";
  final OpenAIService openAIService = OpenAIService();
  String? generatedContent;
  String? generatedUrl;
  bool textToSpeech = false;

  @override
  void initState() {
    super.initState();
  }

  // Future<void> initTextToSpeech() async {
  //   await flutterTts.setSharedInstance(true);
  //   setState(() {});
  // }

  // Future<void> initSpeechToText() async {
  //   await speechToText.initialize();
  //   setState(() {});
  // }

  /// Each time to start a speech recognition session
  // Future<void> startListening() async {
  //   await speechToText.listen(onResult: onSpeechResult,
  //   listenFor: const Duration(minutes: 2));
  //   setState(() {});
  // }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  // void onSpeechResult(SpeechRecognitionResult result) {
  //   setState(() {
  //     lastwords = result.recognizedWords;
  //     // print(lastwords);
  //   });
  // }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  // Future<void> stopListening() async {
  //   await speechToText.stop();
  //   setState(() {});
  // }
  //

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: BounceInDown(
                child: const Text(
              "YouChat",
              style: TextStyle(
                fontFamily: "Cera Pro",
              ),
            )),
            leading: const Icon(Icons.menu),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // image
                ZoomIn(
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          height: 120,
                          width: 120,
                          margin: const EdgeInsets.only(top: 4),
                          decoration: BoxDecoration(
                            color: Pallete.assistantCircleColor,
                            borderRadius: BorderRadius.circular(60),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          height: 123,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            // image: DecorationImage(image: AssetImage("assets/images/virtualAssistant.png"))
                          ),
                          child:
                              Image.asset("assets/images/virtualAssistant.png"),
                        ),
                      )
                    ],
                  ),
                ),
                // chat Bubble
                FadeInRight(
                  child: Visibility(
                    visible: generatedUrl == null,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Pallete.borderColor,
                        ),
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      margin: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20)
                          .copyWith(
                            top: 6,
                          )
                          .copyWith(
                            bottom: 0,
                          ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          generatedContent == null
                              ? "Good Morning, what task can I Do For You?"
                              : generatedContent!,
                          style: TextStyle(
                            fontSize: generatedContent == null ? 25 : 18,
                            color: Pallete.mainFontColor,
                            fontFamily: "Cera Pro",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (generatedUrl != null)
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(generatedUrl!),
                    ),
                  ),
                SlideInLeft(
                  child: Visibility(
                    visible: generatedContent == null && generatedUrl == null,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(10).copyWith(
                        bottom: 0,
                      ),
                      margin: const EdgeInsets.only(left: 22),
                      child: const Text(
                        "Here are a few features",
                        style: TextStyle(
                          fontFamily: "Cera Pro",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Pallete.mainFontColor,
                        ),
                      ),
                    ),
                  ),
                ),
                // features List
                Visibility(
                  visible: generatedContent == null && generatedUrl == null,
                  child: Column(
                    children: [
                      SlideInLeft(
                        delay: const Duration(milliseconds: 200),
                        child: const FeatureBox(
                          color: Pallete.firstSuggestionBoxColor,
                          headerText: "ChatGPT",
                          descriptionText:
                              "A smarter way to stay organized and informed with ChatGPT",
                        ),
                      ),
                      SlideInLeft(
                        delay: const Duration(milliseconds: 400),
                        child: const FeatureBox(
                          color: Pallete.secondSuggestionBoxColor,
                          headerText: "Dall-E",
                          descriptionText:
                              "Get inspired and stay creative with your personal assistant powered by Dall-E",
                        ),
                      ),
                      SlideInLeft(
                        delay: const Duration(milliseconds: 600),
                        child: const FeatureBox(
                          color: Pallete.thirdSuggestionBoxColor,
                          headerText: "Smart Voice Assistant",
                          descriptionText:
                              "Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT",
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: GestureDetector(
            onTapDown: (details) async {
              if (textToSpeech) {
                await flutterTts.stop();
                textToSpeech = false;
                return;
              }
              if (!isListening) {
                bool available = await speechToText.initialize();
                if (available) {
                  // setState(() {
                  // });
                  isListening = true;
                  speechToText.listen(onResult: (result) {
                    lastwords = result.recognizedWords;
                    setState(() {});
                  });
                }
              }
            },
            onTapUp: (details) async {
              if (lastwords == "") {
                return;
              }
              final speech = await openAIService.isArtPromptAPI(lastwords);
              // print(speech);
              if (speech.contains('https')) {
                generatedUrl = speech;
                generatedContent = null;
                setState(() {});
              } else {
                generatedContent = speech;
                generatedUrl = null;
                await systemSpeak(speech);
                textToSpeech = true;
                setState(() {});
              }
              setState(() {
                isListening = false;
                lastwords = "";
                speechToText.stop();
              });
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: isListening
                        ? Pallete.firstSuggestionBoxColor
                        : Pallete.secondSuggestionBoxColor,
                  ),
                  child: Icon(isListening ? Icons.stop : Icons.mic, size: 30),
                )),
          )),
    );
  }
}
