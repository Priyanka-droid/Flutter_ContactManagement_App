// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:typed_data';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contact/contact_management_provider.dart';
import 'package:flutter_contact/models/custom_model.dart';
import 'package:flutter_contact/models/item_model.dart' as model;
// import 'package:flutter_contact/models/custom_model.dart';
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
      return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            // Add TextFormFields and ElevatedButton here.
            TextFormField(
              controller: myController1,
              decoration: InputDecoration(
                label: Text("Enter Display Name"),
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              controller: myController2,
              decoration: InputDecoration(
                label: Text("Enter Contact Number"),
              ),
              // The validator receives the text that the user has entered.
              validator: ValidationBuilder().phone().minLength(10).build(),
            ),
            TextFormField(
              controller: myController3,
              decoration: InputDecoration(
                label: Text("Enter picture URL"),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  if (index == -1) {
                    print("add operation");
                    contactListProvider.addContact(CustomContactModel(
                        givenName: myController1.text,
                        phone: model.ItemModel(
                            label: "work", value: myController2.text),
                        avatar: convertStringToUint8List("")));
                  } else {
                    contactListProvider.updateContact(
                        index,
                        CustomContactModel(
                            givenName: myController1.text,
                            phone: model.ItemModel(
                                label: "work", value: myController2.text),
                            avatar: convertStringToUint8List("")));
                  }
                  Navigator.pop(context);
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      );
    });
  }

  Uint8List convertStringToUint8List(String str) {
    final List<int> codeUnits = str.codeUnits;
    final Uint8List unit8List = Uint8List.fromList(codeUnits);

    return unit8List;
  }
}
