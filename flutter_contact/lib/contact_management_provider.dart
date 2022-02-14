import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_contact/models/custom_model.dart';
import 'package:flutter_contact/models/item_model.dart' as model;
import 'package:hive_flutter/adapters.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

// Provider class containing methods which invoke notifyListeners on call

class ContactListProvider extends ChangeNotifier {
  ContactListProvider() {
    loadContacts();
  }
  void loadContacts() async {
    bool permissionGranted = await Permission.contacts.request().isGranted;

    if (permissionGranted) {
      if (Hive.box('contactBox').keys.isEmpty) {
        List<Contact> contacts = await ContactsService.getContacts();
        contacts.forEach((contact) {
          String _givenName =
              contact.givenName == null ? "None" : contact.givenName!;
          model.ItemModel _phone = contact.phones == null
              ? model.ItemModel(label: "work", value: "none")
              : (contact.phones!.isEmpty
                  ? model.ItemModel(label: "work", value: "none")
                  : model.ItemModel(
                      label: ((contact.phones)!)[0].label,
                      value: ((contact.phones)!)[0].value));
          Uint8List? _avatar = contact.avatar;
          CustomContactModel contactVal = CustomContactModel(
              givenName: _givenName, phone: _phone, avatar: _avatar);
          Hive.box('contactBox').add(contactVal);
        });
      }

      // print(contacts.length);
    } else {
      Hive.box('contactBox').add("");
    }
    notifyListeners();
  }

  void deleteContact(int index) {
    // await ContactsService.deleteContact(contact);
    Hive.box('contactBox').deleteAt(index);
    notifyListeners();
  }

  void addContact(CustomContactModel contact) {
    // await ContactsService.addContact(contact);
    Hive.box('contactBox').add(contact);
    notifyListeners();
  }

  void updateContact(int index, CustomContactModel contact) async {
    Hive.box('contactBox').putAt(index, contact);
    notifyListeners();
  }

  get getContactList => Hive.box('contactBox');
}
