// ignore_for_file: curly_braces_in_flow_control_structures
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_contact/contact_management_provider.dart';
import 'package:flutter_contact/models/custom_model.dart';
import 'package:flutter_contact/models/item_model.dart' as model;
import 'package:provider/provider.dart';
import 'package:form_validator/form_validator.dart';

class CustomForm extends StatefulWidget {
  final int index;
  CustomForm({required this.index});
  @override
  CustomFormState createState() {
    return CustomFormState(index: index);
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class CustomFormState extends State<CustomForm> {
  final int index;
  File? imageFile;
  Uint8List? avatarLink;
  CustomFormState({required this.index});
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<CustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    return Consumer<ContactListProvider>(
        builder: (context, contactListProvider, child) {
      final ImagePicker _picker = ImagePicker();
      CustomContactModel? contact;
      if (index != -1)
        contact = (contactListProvider.getContactList).getAt(index);
      return ListView(
        children: [
          Container(
              child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                // Add TextFormFields and ElevatedButton here.
                TextFormField(
                  controller: index == -1
                      ? myController1
                      : (myController1..text = contact!.firstName),
                  decoration: InputDecoration(
                    label: Text("Enter First Name"),
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    return nameValidator(value);
                  },
                ),
                TextFormField(
                  controller: index == -1
                      ? myController2
                      : (myController2..text = contact!.lastName),
                  decoration: InputDecoration(
                    label: Text("Enter Last Name"),
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    return nameValidator(value);
                  },
                ),
                TextFormField(
                  controller: index == -1
                      ? myController3
                      : (myController3..text = contact!.phone.value.toString()),
                  decoration: InputDecoration(
                    label: Text("Enter Contact Number"),
                  ),
                  // The validator receives the text that the user has entered.
                  validator: ValidationBuilder().phone().minLength(10).build(),
                ),
                ElevatedButton(
                    onPressed: () {
                      print("print image");
                      _getFromGallery();
                      // print("print image" + imageFile.toString());
                      // avatarLink = imageFile == null ? null : _getAvatar();
                    },
                    child: Text("pick image")),

                ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      // print("avatar link" + avatarLink.toString());

                      if (index == -1) {
                        contactListProvider.addContact(CustomContactModel(
                            firstName: myController1.text.trim(),
                            lastName: myController2.text.trim(),
                            phone: model.ItemModel(
                                label: "work", value: myController3.text),
                            avatar: avatarLink == null ? null : avatarLink));
                      } else {
                        contactListProvider.updateContact(
                            index,
                            CustomContactModel(
                                firstName: myController1.text.trim(),
                                lastName: myController2.text.trim(),
                                phone: model.ItemModel(
                                    label: "work", value: myController3.text),
                                avatar:
                                    avatarLink == null ? null : avatarLink));
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ))
        ],
      );
    });
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
    }
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty || value.trim().isEmpty)
      return "Invalid name";
    if (value.trim().split(" ").length > 1) return "Name should be single word";
    return null;
  }
}
