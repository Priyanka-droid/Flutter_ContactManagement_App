import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contact/contact_management_provider.dart';
import 'package:provider/provider.dart';

class UpdateContact extends StatelessWidget {
  final int index;
  UpdateContact(this.index);
  @override
  Widget build(BuildContext context) {
    return Consumer<ContactListProvider>(
        builder: (context, contactList, child) {
      Contact contact = Contact(givenName: 'Priyanka');
      return Scaffold(
        appBar: AppBar(
          title: Text('Update Contact'),
        ),
        body: UpdateForm(index),
        // floatingActionButton: FloatingActionButton(
        //     onPressed: () {
        //       contactList.updateContact(contact);
        //       Navigator.pop(context);
        //     },
        //     child: Text('update contact')),
      );
    });
  }
}

class UpdateForm extends StatefulWidget {
  // const UpdateForm({Key? key}) : super(key: key);
  final int index;
  UpdateForm(this.index);

  @override
  UpdateFormState createState() {
    return UpdateFormState(index);
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class UpdateFormState extends State<UpdateForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<AddFormState>.
  final int index;
  UpdateFormState(this.index);
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
                  contactList.updateContact(
                      index, Contact(givenName: myController1.text));
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
