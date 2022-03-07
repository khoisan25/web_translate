// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_button/flutter_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:io';

class MyMobileBody extends StatefulWidget {
  const MyMobileBody({Key? key}) : super(key: key);

  _MyMobileBody createState() => _MyMobileBody();
}

class _MyMobileBody extends State<MyMobileBody> {
  final textInput = TextEditingController();
  String result = '';

  getText() async {
    final url = Uri.http(
      '185.141.61.143:24080',
      'translate',
      {
        'source_lang': 'en',
        'target_lang': 'bem',
        'text': textInput.text.toString()
      },
    );
    print(url);
    final response = await http.get(url);

    // var request = await HttpClient().getUrl(Uri.parse(
    //     'http://www.martinnn.com:24080/translate?source_lang=en&target_lang=bem&text=trying'));
    // // sends the request
    // var responses = await request.close();

    // await for (var contents in responses.transform(convert.Utf8Decoder())) {
    //   print(contents);
    // }

    String output = '';

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      print('after parsing');
      List<String> list = List<String>.from(jsonResponse['translated'] as List);
      print(jsonResponse['translated']);
      result = list.join();
    } else {
      result = 'Request failed with status: ${response.statusCode}.';
    }
    print(result);
    setState(() {
      //result = output;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF001845),
      appBar: AppBar(
        backgroundColor: Color(0xFF001845),
        title: Text(
          'BembaBox',
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 50),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // youtube video
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
                              color: Colors.white, fontSize: 20),
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
    );
  }
}
