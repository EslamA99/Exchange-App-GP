import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gp_version_01/Controller/animalsProvider.dart';
import 'package:gp_version_01/models/Categories/animals.dart';
import 'package:gp_version_01/models/items.dart';
import 'package:gp_version_01/widgets/dropListCategories.dart';
import 'package:gp_version_01/widgets/image_input.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:path/path.dart';

class AddItemScreen extends StatelessWidget {
  static const String route = '/addItemScreen';
  Widget funs;
  String title;
  String description;
  File imageFile;

  List<File> imagesFiles = List<File>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            labelText: 'اسم المنتج',
            labelStyle: TextStyle(color: Colors.black54),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue[400]),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue[400]),
            ),
          ),
          maxLength: 30,
          validator: (String value) {
            if (value.isEmpty) {
              return 'اسم المنتج مطلوب';
            }
            return null;
          },
          onSaved: (String value) {
            title = value;
          },
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          maxLines: 3,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            labelText: 'الوصف',
            labelStyle: TextStyle(color: Colors.black54),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue[400]),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue[400]),
            ),
          ),
          validator: (String value) {
            if (value.isEmpty) {
              return 'وصف المنتج مطلوب';
            }
            return null;
          },
          onSaved: (String value) {
            description = value;
          },
        ),
      ),
    );
  }

  Widget _buildImage() {
    return ImageMultiple(imagesFiles);
  }

  Widget _buildCondition(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "المزيد",
              style: TextStyle(color: Colors.black54),
            ),
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: RadioButtonGroup(
                    labels: <String>[
                      "جديد",
                      "مستعمل",
                    ],
                    onSelected: (String selected) => print(selected),
                    labelStyle: TextStyle(color: Colors.black54),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: VerticalDivider(
                    thickness: 1,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: RadioButtonGroup(
                    labels: <String>[
                      "بمقابل",
                      "دون مقابل",
                    ],
                    onSelected: (String selected) => print(selected),
                    labelStyle: TextStyle(color: Colors.black54),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "اضف منتج",
        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
      )),
      body: Container(
        margin: EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildImage(),
                _buildTitle(),
                _buildDescription(),
                DropListCategories(),
                _buildCondition(context),
                SizedBox(height: 50),
                SizedBox(
                  height: 40,
                  width: 150,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'قدم',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onPressed: () {
                      Items item = new Animals(
                        age: 9,
                        animalType: "horse",
                        descreption: "cdsfdhgfd",
                        itemOwner: "lol",
                        title: "cat lol",
                        date: DateTime.now(),
                        imageFiles: imagesFiles,
                      );
                      AnimalsProvider().createRecord(item);
                      if (!_formKey.currentState.validate()) {
                        return;
                      }
                      _formKey.currentState.save();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}