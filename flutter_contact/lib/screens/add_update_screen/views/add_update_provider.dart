import 'package:flutter/material.dart';
import 'package:flutter_contact/contact_app_strings.dart';
import 'package:flutter_contact/models/custom_model.dart';

class AddUpdateProvider extends ChangeNotifier {
  String? controller;
  String? label;
  AddUpdateProvider({this.controller, this.label});

  List<AddUpdateProvider> createFormList(CustomContactModel? contact) {
    List<AddUpdateProvider> formValueList = [
      AddUpdateProvider(
        controller: contact?.firstName,
        label: ContactAppStrings.instance.firstNameLabel,
      ),
      AddUpdateProvider(
        controller: contact?.lastName,
        label: ContactAppStrings.instance.lastNameLabel,
      ),
      AddUpdateProvider(
        controller: contact?.phone.value,
        label: ContactAppStrings.instance.contactLabel,
      )
    ];
    return formValueList;
  }

  String? nameValidator(String? value) {
    ContactAppStrings messages = ContactAppStrings.instance;
    if (value == null || value.isEmpty || value.trim().isEmpty) {
      return messages.emptyName;
    }
    if (value.trim().split(" ").length > 1) return messages.multipleWord;
    return null;
  }
}
