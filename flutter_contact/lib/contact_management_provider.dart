import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_contact/constants.dart';
import 'package:flutter_contact/models/custom_model.dart';
import 'package:flutter_contact/models/item_model.dart' as model;
import 'package:hive_flutter/adapters.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';

// Provider class containing methods which invoke notifyListeners on call

class ContactListController extends GetxController {
  var hiveBox = Hive.box(HiveConstants.BOX_NAME);
  RxList<CustomContactModel> hiveList = <CustomContactModel>[].obs;

  ContactListController() {
    _loadContacts();
  }

  void _loadContacts() async {
    bool _permissionGranted = await Permission.contacts.request().isGranted;

    if (_permissionGranted) {
      int len = Hive.box(HiveConstants.BOX_NAME).keys.length;
      for (int i = 0; i < len; i++) {
        hiveList.add(Hive.box(HiveConstants.BOX_NAME).getAt(i));
      }

      if (hiveBox.keys.isEmpty) {
        List<Contact> contacts = await ContactsService.getContacts();
        contacts.forEach((contact) {
          String _firstName = contact.givenName ?? "none";
          String _lastName = contact.familyName ?? "none";
          model.ItemModel _phone = contact.phones == null
              ? model.ItemModel(label: "work", value: "none")
              : (contact.phones!.isEmpty
                  ? model.ItemModel(label: "work", value: "none")
                  : model.ItemModel(
                      label: ((contact.phones)!)[0].label,
                      value: ((contact.phones)!)[0].value));
          Uint8List? _avatar = contact.avatar;
          CustomContactModel contactVal = CustomContactModel(
              firstName: _firstName,
              lastName: _lastName,
              phone: _phone,
              avatar: _avatar);
          hiveBox.add(contactVal);
        });
      }

      // print(contacts.length);
    }
    // notifyListeners();
  }

  void deleteContact(int index) {
    // await ContactsService.deleteContact(contact);
    hiveBox.deleteAt(index);
    hiveList.removeAt(index);
    // notifyListeners();
  }

  void addContact(CustomContactModel contact) {
    // await ContactsService.addContact(contact);
    hiveBox.add(contact);
    hiveList.add(contact);
    // notifyListeners();
  }

  void updateContact(int index, CustomContactModel contact) async {
    hiveBox.putAt(index, contact);
    hiveList[index] = contact;
    // notifyListeners();
  }

  get getContactList => hiveBox;
}
