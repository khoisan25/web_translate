// ignore_for_file: prefer_const_constructors

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_button/flutter_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:dio/dio.dart';
import 'package:dcache/dcache.dart';

class MyMobileBody extends StatefulWidget {
  const MyMobileBody({Key? key}) : super(key: key);

  _MyMobileBody createState() => _MyMobileBody();
}

class _MyMobileBody extends State<MyMobileBody> {
  final bool enableListening = true;
  Cache cache = SimpleCache(storage: InMemoryStorage(3000));
  final textInput = TextEditingController();

  final RegExp _regex = RegExp(r'[a-zA-Z]');

  void checkText() {
    if (textInput.text.isNotEmpty) {
      final lastChar = textInput.text.substring(textInput.text.length - 1);
      bool isMatch = _regex.hasMatch(lastChar);
      if (!isMatch) {
        if (cache.get(textInput.text.trim()) != null) {
          result = cache.get(textInput.text.trim());
          setState(() {});
        } else {
          getText();
        }
      }
    }
  }

  String result = '';
  bool awaitingResponse = false;

  getText() async {
    result = result + '...';
    awaitingResponse = true;
    final url = Uri.http(
      'martinnn.com:25080',
      'translate',
      {
        'source_lang': 'en',
        'target_lang': 'bem',
        'text': textInput.text.toString()
      },
    );
    var response;
    try {
      response = await Dio().get(url.toString());
    } catch (e) {
      print(e);
    }

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.toString());
      List<String> list = List<String>.from(jsonResponse['translated'] as List);
      result = list.join();
    } else {
      result = 'Request failed with status: ${response.statusCode}.';
    }
    cache.set(textInput.text.trim(), result);
    awaitingResponse = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Color(0xFF001845),
        appBar: AppBar(
          backgroundColor: Color(0xFF001845),
          title: Text(
            'BembaBox',
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 40),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(1),
                    child: Padding(
                      padding: const EdgeInsets.all(1),
                      child: Container(
                          height: 100,
                          color: Color(0xFF001845),
                          child: TextField(
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                            cursorColor: Colors.white,
                            controller: textInput,
                            onChanged: (text) {
                              checkText();
                            },
                            minLines: null,
                            maxLines: null,
                            expands: true,
                            autocorrect: true,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              focusColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                  width: 10,
                                  color: Colors.white,
                                ),
                              ),
                              hintText: 'Type something...',
                              hintStyle: TextStyle(color: Colors.white70),
                              alignLabelWithHint: true,
                            ),
                          )),
                    ),
                  )),
              SizedBox(height: 20),
              Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(1),
                    child: Padding(
                      padding: const EdgeInsets.all(1),
                      child: Container(
                          height: 100,
                          alignment: Alignment.center,
                          color: Color(0xFF001845),
                          child: Text(
                            result,
                            style: GoogleFonts.roboto(
                                color: awaitingResponse
                                    ? Color.fromARGB(255, 206, 212, 218)
                                    : Colors.white,
                                fontSize: 20,
                                fontStyle: awaitingResponse
                                    ? FontStyle.italic
                                    : FontStyle.normal),
                            textAlign: TextAlign.center,
                          )),
                    ),
                  )),
              SizedBox(height: 20),
              Button3D(
                style: StyleOf3dButton(
                  backColor: Color(0xFFABC4FF),
                  topColor: Color(0xFFD7E3FC),
                  borderRadius: BorderRadius.circular(30),
                ),
                height: 50,
                width: 200,
                onPressed: getText,
                child: const Text("Translate"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
