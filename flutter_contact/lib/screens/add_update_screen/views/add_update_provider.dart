import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_contact/contact_app_strings.dart';
import 'package:image_picker/image_picker.dart';

class AddUpdateProvider extends ChangeNotifier {
  ContactAppStrings messages = ContactAppStrings.instance;

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty || value.trim().isEmpty)
      return messages.emptyName;
    if (value.trim().split(" ").length > 1) return messages.multipleWord;
    return null;
  }
}
