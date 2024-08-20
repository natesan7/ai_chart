import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:matcher/matcher.dart';

import 'model.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  TextEditingController a = TextEditingController();
  static const apikey = "AIzaSyCTOMCdSBhao6KzaC-iXWgm_hTlLrWqsdY";
  final model = GenerativeModel(
    model: "gemini-pro",
    apiKey: apikey,
  );
  final List<ModelMessage> prompt = [];
  //final bool ispromt = true;
  Future <void> sendMessage()async{
    final message =a.text;
    setState(() {
      a.clear();
      prompt.add(ModelMessage(ispromp:true, message: message, time: DateTime.now()));
    });
    final content=[Content.text(message)];
    final response=await model.generateContent(content);
    setState(() {
      prompt.add(ModelMessage(ispromp:false, message: response.text ?? "", time: DateTime.now()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.grey[100],
        title: Center(child: Text("AI ChatBot")),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: prompt.length,
                  itemBuilder: (context, index) {
                    final message = prompt[index];
                    return UserPrompt(
                        isprompt:message.ispromp,
                        message: message.message,
                        date: DateFormat('hh:mm:a').format(message.time,));
                  })),

          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                Expanded(
                    flex: 20,
                    child: TextField(
                      controller: a,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          hintText: "Enter a prompt here"),
                    )),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    sendMessage();
                  },
                  child: CircleAvatar(
                    radius: 29,
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

Container UserPrompt({required final bool isprompt, required String message, required String date}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(15),
    margin: EdgeInsets.symmetric(vertical: 15,).copyWith(left: isprompt ?80:15,right: isprompt ? 15:80),
    decoration: BoxDecoration(color: isprompt ? Colors.green : Colors.grey,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          bottomLeft:isprompt?Radius.circular(20):Radius.zero,
          bottomRight: isprompt?Radius.zero:Radius.circular(20),
        )
    ),

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          message,
          style: TextStyle(
              fontWeight: isprompt
                  ? FontWeight.bold
                  : FontWeight.normal,
              fontSize: 18,
              color: isprompt
                  ? Colors.white
                  : Colors.black),
        ),
        Text(
          date,
          style: TextStyle(

              fontSize: 18,
              color: isprompt
                  ? Colors.white
                  : Colors.black),
        ),


      ],
    ),
  );
}
