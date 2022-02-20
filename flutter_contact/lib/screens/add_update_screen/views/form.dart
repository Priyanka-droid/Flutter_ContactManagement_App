// ignore_for_file: curly_braces_in_flow_control_structures, must_be_immutable

import 'dart:io';
import 'package:flutter_contact/constants.dart';
import 'package:flutter_contact/contact_app_strings.dart';
import 'package:flutter_contact/screens/add_update_screen/views/add_update_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_contact/models/custom_model.dart';
import 'package:flutter_contact/models/item_model.dart' as model;
import 'package:form_validator/form_validator.dart';
import 'package:provider/provider.dart';

class CustomForm extends StatelessWidget {
  CustomForm({Key? key, required this.flow, this.contact}) : super(key: key);
  final FormFlow flow;
  final CustomContactModel? contact;
  File? imageFile;
  Uint8List? avatarLink;

  ContactAppStrings messages = ContactAppStrings.instance;
  CustomContactModel? newContact;
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<CustomFormState>.
  final _formKey = GlobalKey<FormState>();

  List<TextEditingController> controllerList = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          // Add TextFormFields and ElevatedButton here.
          GestureDetector(
            onTap: () {
              _getFromGallery();
            },
            child: Container(
                child: Column(
              children: [
                Image.network(
                  Constants.IMAGE_URL,
                  width: 50,
                  height: 50,
                ),
                Text(messages.pickImage)
              ],
            )),
          ),
          Expanded(
            child: TextFormFieldList(
                contact: contact, flow: flow, controllerList: controllerList),
          ),

          ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                if (flow == FormFlow.ADD) {
                  newContact = (CustomContactModel(
                      firstName: controllerList[0].text.trim(),
                      lastName: controllerList[1].text.trim(),
                      phone: model.ItemModel(
                          label: "work", value: controllerList[2].text),
                      avatar: avatarLink));
                } else {
                  newContact = (CustomContactModel(
                      firstName: controllerList[0].text.trim(),
                      lastName: controllerList[1].text.trim(),
                      phone: model.ItemModel(
                          label: "work", value: controllerList[2].text),
                      avatar: avatarLink));
                }
                Navigator.pop(context, newContact);
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      Uint8List imageRaw = await imageFile!.readAsBytes();
      avatarLink = imageRaw;
    } else
      avatarLink = null;
  }
}

class TextFormFieldList extends StatelessWidget {
  // const TextFormFieldList({ Key? key }) : super(key: key);
  CustomContactModel? contact;
  FormFlow flow;
  List<TextEditingController> controllerList;
  TextFormFieldList(
      {Key? key,
      this.contact,
      required this.flow,
      required this.controllerList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddUpdateProvider>(
        builder: (context, addUpdateProvider, child) {
      var formList = addUpdateProvider.createFormList(contact);
      return ListView.builder(
          itemCount: formList.length,
          itemBuilder: (context, index) {
            return TextFormField(
              controller: flow == FormFlow.ADD
                  ? controllerList[index]
                  : (controllerList[index]
                    ..text = (formList[index].controller!)),
              decoration: InputDecoration(
                label: Text(formList[index].label!),
              ),
              // The validator receives the text that the user has entered.
              validator: index == 2
                  ? ValidationBuilder().phone().minLength(10).build()
                  : (value) {
                      return formList[index].nameValidator(value);
                    },
            );
          });
    });
  }
}
