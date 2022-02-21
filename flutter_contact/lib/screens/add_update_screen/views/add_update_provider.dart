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
        validator: nameValidator,
      )
    ];
    return formValueList;
  }

  String? nameValidator(String? value) {
    print("name validator : ${value ?? "none"}");

    ContactAppStrings messages = ContactAppStrings.instance;
    if (value == null || value.isEmpty || value.trim().isEmpty) {
      print("inner validator");
      return messages.emptyName;
    }
    if (value.trim().split(" ").length > 1) return messages.multipleWord;
    return null;
  }

  phoneValidator(String? value) {
    return ValidationBuilder().phone().minLength(10).build();
  }
}
