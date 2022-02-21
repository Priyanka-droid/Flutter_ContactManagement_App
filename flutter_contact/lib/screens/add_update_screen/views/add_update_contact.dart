import 'package:flutter/material.dart';
import 'package:flutter_contact/constants.dart';
import 'package:flutter_contact/contact_app_strings.dart';
import 'package:flutter_contact/models/custom_model.dart';
import 'package:flutter_contact/screens/add_update_screen/views/add_update_provider.dart';
import 'package:flutter_contact/screens/add_update_screen/views/form.dart';
import 'package:provider/provider.dart';

// add screen which displays add form on giving index -1

class AddUpdateScreen extends StatelessWidget {
  final FormFlow flow;
  final CustomContactModel? contact;
  AddUpdateScreen({required this.flow, this.contact});
  ContactAppStrings messages = ContactAppStrings.instance;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddUpdateProvider>(
        create: (context) => AddUpdateProvider(),
        child: Scaffold(
          appBar: AppBar(
            title: flow == FormFlow.ADD
                ? Text(messages.addContact)
                : Text(messages.updateContact),
          ),
          body: CustomForm(flow: flow, contact: contact),
        ));
  }
}
