// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_button/flutter_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:dio/dio.dart';

class MyDesktopBody extends StatefulWidget {
  const MyDesktopBody({Key? key}) : super(key: key);

  _MyDesktopBody createState() => _MyDesktopBody();
}

class _MyDesktopBody extends State<MyDesktopBody> {
  final textInput = TextEditingController();
  String result = '';

  getText() async {
    final url = Uri.http(
      'www.meatbagwrites.com:24080',
      'translate',
      {
        'source_lang': 'en',
        'target_lang': 'bem',
        'text': textInput.text.toString()
      },
    );
    var response;
    print(url.toString());
    try {
      response = await Dio().get(url.toString());
      print(response);
    } catch (e) {
      print(e);
    }
    //final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.toString());
      List<String> list = List<String>.from(jsonResponse['translated'] as List);
      result = list.join();
    } else {
      result = 'Request failed with status: ${response.statusCode}.';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF001845),
      appBar: AppBar(
        backgroundColor: Color(0xFF001845),
        title: Text(
          'BembaBox',
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 40),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
              color: Color(0xFF001845),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            flex: 3,
                            child: Container(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                    height: 200,
                                    color: Color(0xFF001845),
                                    child: TextField(
                                      style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                      textAlign: TextAlign.center,
                                      cursorColor: Colors.white,
                                      controller: textInput,
                                      minLines: null,
                                      maxLines: null,
                                      expands: true,
                                      autocorrect: true,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: InputDecoration(
                                        focusColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          borderSide: BorderSide(
                                            width: 10,
                                            color: Colors.white,
                                          ),
                                        ),
                                        hintText: 'Type something...',
                                        hintStyle:
                                            TextStyle(color: Colors.white70),
                                        alignLabelWithHint: true,
                                      ),
                                    )),
                              ),
                            )),
                        SizedBox(width: 20),
                        Expanded(
                            flex: 3,
                            child: Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.all(1),
                                  child: Padding(
                                    padding: const EdgeInsets.all(1),
                                    child: Container(
                                        height: 200,
                                        alignment: Alignment.center,
                                        color: Color(0xFF001845),
                                        child: Text(
                                          result,
                                          style: GoogleFonts.roboto(
                                              color: Colors.white,
                                              fontSize: 20),
                                          textAlign: TextAlign.center,
                                        )),
                                  ),
                                ))),
                      ],
                    ),
                  ),
                  Button3D(
                    style: StyleOf3dButton(
                      backColor: Color(0xFFABC4FF),
                      topColor: Color(0xFFD7E3FC),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    height: 50,
                    width: 200,
                    onPressed: getText,
                    child: const Text("3d Button"),
                  ),
                ],
              ))),
    );
  }
}
