import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactListProvider extends ChangeNotifier {
  List<Contact> contactList = [];
  ContactListProvider() {
    loadContacts();
  }
  void loadContacts() async {
    bool permissionGranted = await Permission.contacts.request().isGranted;
    if (permissionGranted) {
      List<Contact> contacts = await ContactsService.getContacts();
      contactList = contacts;
      print(contacts.length);
    } else {
      contactList = [];
    }
    notifyListeners();
  }

  void deleteContact(int index) async {
    // await ContactsService.deleteContact(contact);
    contactList.removeAt(index);
    notifyListeners();
  }

  void addContact(Contact contact) async {
    // await ContactsService.addContact(contact);
    contactList.add(contact);
    notifyListeners();
  }

  void updateContact(int index, Contact contact) async {
    // await ContactsService.updateContact(contact);
    contactList[index] = contact;
    notifyListeners();
  }

  List<Contact> get getContactList => contactList;
}
