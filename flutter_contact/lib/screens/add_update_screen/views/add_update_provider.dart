import 'package:flutter/material.dart';
import 'package:flutter_contact/contact_app_strings.dart';
import 'package:flutter_contact/models/custom_model.dart';
import 'package:form_validator/form_validator.dart';

class AddUpdateProvider extends ChangeNotifier {
  String? controller;
  String? label;
  Function? validator;
  AddUpdateProvider({this.controller, this.label, this.validator});

  List<AddUpdateProvider> createFormList(CustomContactModel? contact) {
    List<AddUpdateProvider> formValueList = [
      AddUpdateProvider(
        controller: contact?.firstName,
        label: ContactAppStrings.instance.firstNameLabel,
        validator: nameValidator,
      ),
      AddUpdateProvider(
        controller: contact?.lastName,
        label: ContactAppStrings.instance.lastNameLabel,
        validator: nameValidator,
      ),
      AddUpdateProvider(
        controller: contact?.phone.value,
        label: ContactAppStrings.instance.contactLabel,
        validator: phoneValidator,
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

  String? phoneValidator(String? value) {
    ContactAppStrings messages = ContactAppStrings.instance;
    if (value == null || value.isEmpty || value.trim().isEmpty) {
      return messages.emptyPhone;
    }
    if (value.trim().split(" ").length > 1) return messages.multipleWord;
    if (!isNumber(value)) return messages.invalidNumber;
    return null;
  }

  bool isNumber(String? value) {
    List<String> numList = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    if (value == null) return false;
    if (value.length < 10 || value.length > 15) return false;
    // for (int i = 0; i < value.length; i++) {
    //   if (value[i] != '-' || !numList.contains(value[i])) return false;
    // }
    return true;
  }
}
