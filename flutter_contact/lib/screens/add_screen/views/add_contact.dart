import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../contact_management_provider.dart';

class AddContact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ContactListProvider>(
        builder: (context, contactList, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Add Contact'),
        ),
        body: AddForm(),
        // floatingActionButton: FloatingActionButton(
        //     onPressed: () {
        //       contactList.addContact(contact);
        //       Navigator.pop(context);
        //     },
        //     child: Text('Add contact')),
      );
    });
  }
}

class AddForm extends StatefulWidget {
  const AddForm({Key? key}) : super(key: key);

  @override
  AddFormState createState() {
    return AddFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class AddFormState extends State<AddForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<AddFormState>.
  final _formKey = GlobalKey<FormState>();
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Consumer<ContactListProvider>(
        builder: (context, contactList, child) {
      Contact contact = Contact(givenName: 'Adarsh');
      return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            // Add TextFormFields and ElevatedButton here.
            TextFormField(
              controller: myController1,
              decoration: InputDecoration(
                label: Text("Enter Name"),
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  contactList
                      .addContact(Contact(givenName: myController1.text));
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
}
