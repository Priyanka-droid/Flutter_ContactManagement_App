import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_contact/constants.dart';
import 'package:flutter_contact/contact_app_strings.dart';
import 'package:flutter_contact/models/custom_model.dart';
import 'package:flutter_contact/screens/add_update_screen/views/add_update_contact.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';

import '../../../contact_management_provider.dart';

class ContactManagement extends StatelessWidget {
  // const ContactManagement({Key? key}) : super(key: key);

  ContactAppStrings messages = ContactAppStrings.instance;
  final controller = Get.put(ContactListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              CustomContactModel? newContact =
                  await Get.to(() => AddUpdateScreen(flow: FormFlow.ADD));

              newContact == null ? null : controller.addContact(newContact);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: displayContactList(),
    );
  }

  Widget displayContactList() {
    return Obx(() {
      return ListView.builder(
          itemCount: controller.hiveList.value.length,
          itemBuilder: (context, index) {
            final contact = (controller.hiveList.value)[index];
            bool isAvatar = contact.avatar == null ? false : true;
            return ListTile(
              onTap: () async {
                CustomContactModel? newContact = await Get.to(() =>
                    AddUpdateScreen(flow: FormFlow.UPDATE, contact: contact));
                //   MaterialPageRoute(
                //       builder: (context) => AddUpdateScreen(
                //           flow: FormFlow.UPDATE, contact: contact)),
                // );
                newContact == null
                    ? null
                    : controller.updateContact(index, newContact);
              },
              leading: isAvatar
                  ? CircleAvatar(backgroundImage: MemoryImage(contact.avatar!))
                  : CircleAvatar(child: Text(contact.firstName[0])),
              title: Text(
                contact.firstName + " " + contact.lastName,
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(contact.phone.value!),
              trailing: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text(messages.deleteDialog),
                        content: Text(messages.confirmDelete),
                        actions: <Widget>[
                          TextButton(
                            child: Text("Cancel"),
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                          ),
                          TextButton(
                            child: Text("Yes"),
                            onPressed: () {
                              controller.deleteContact(index);
                              Navigator.of(ctx).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  icon: Icon(Icons.delete)),
            );
          });
    });
  }
}
