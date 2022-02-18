// ignore_for_file: curly_braces_in_flow_control_structures, must_be_immutable
import 'dart:io';
import 'package:flutter_contact/constants.dart';
import 'package:flutter_contact/contact_app_strings.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_contact/models/custom_model.dart';
import 'package:flutter_contact/models/item_model.dart' as model;
import 'package:form_validator/form_validator.dart';

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
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    return ListView(
      children: [
        Container(
            child: Form(
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
                      'https://www.bastiaanmulder.nl/wp-content/uploads/2013/11/dummy-image-square.jpg',
                      width: 50,
                      height: 50,
                    ),
                    Text(messages.pickImage)
                  ],
                )),
              ),

              TextFormField(
                controller: flow == FormFlow.ADD
                    ? _firstNameController
                    : (_firstNameController..text = contact!.firstName),
                decoration: InputDecoration(
                  label: Text(messages.firstNameLabel),
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  return nameValidator(value);
                },
              ),
              TextFormField(
                controller: flow == FormFlow.ADD
                    ? _lastNameController
                    : (_lastNameController..text = contact!.lastName),
                decoration: InputDecoration(
                  label: Text(messages.lastNameLabel),
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  return nameValidator(value);
                },
              ),
              TextFormField(
                controller: flow == FormFlow.ADD
                    ? _phoneController
                    : (_phoneController
                      ..text = contact!.phone.value.toString()),
                decoration: InputDecoration(
                  label: Text(messages.contactLabel),
                ),
                // The validator receives the text that the user has entered.
                validator: ValidationBuilder().phone().minLength(10).build(),
              ),

              ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    if (flow == FormFlow.ADD) {
                      newContact = (CustomContactModel(
                          firstName: _firstNameController.text.trim(),
                          lastName: _lastNameController.text.trim(),
                          phone: model.ItemModel(
                              label: "work", value: _phoneController.text),
                          avatar: avatarLink));
                    } else {
                      newContact = (CustomContactModel(
                          firstName: _firstNameController.text.trim(),
                          lastName: _lastNameController.text.trim(),
                          phone: model.ItemModel(
                              label: "work", value: _phoneController.text),
                          avatar: avatarLink));
                    }
                    Navigator.pop(context, newContact);
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ))
      ],
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

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty || value.trim().isEmpty)
      return messages.emptyName;
    if (value.trim().split(" ").length > 1) return messages.multipleWord;
    return null;
  }
}
