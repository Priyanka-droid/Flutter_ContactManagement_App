import 'package:flutter/material.dart';
import 'package:flutter_contact/contact_app_strings.dart';
import 'package:flutter_contact/models/custom_model.dart';
import 'package:get/get.dart';

class AddUpdateController extends GetxController {
  String? controller;
  String? label;
  AddUpdateController({this.controller, this.label});

  List<AddUpdateController> createFormList(CustomContactModel? contact) {
    List<AddUpdateController> formValueList = [
      AddUpdateController(
        controller: contact?.firstName,
        label: ContactAppStrings.instance.firstNameLabel,
      ),
      AddUpdateController(
        controller: contact?.lastName,
        label: ContactAppStrings.instance.lastNameLabel,
      ),
      AddUpdateController(
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
