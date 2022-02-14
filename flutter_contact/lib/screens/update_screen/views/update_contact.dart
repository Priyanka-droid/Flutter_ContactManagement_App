import 'package:flutter/material.dart';
import 'package:flutter_contact/contact_management_provider.dart';
import 'package:flutter_contact/screens/form.dart';
import 'package:provider/provider.dart';

// Update screen which displays update form on giving index as 1

class UpdateContact extends StatelessWidget {
  final int index;
  UpdateContact(this.index);
  @override
  Widget build(BuildContext context) {
    return Consumer<ContactListProvider>(
        builder: (context, contactListProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Update Contact'),
        ),
        body: CustomForm(index: this.index),
      );
    });
  }
}
