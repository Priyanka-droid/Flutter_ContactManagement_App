import 'package:flutter/material.dart';
import 'package:flutter_contact/screens/add_screen/views/add_contact.dart';
import 'package:flutter_contact/screens/update_screen/views/update_contact.dart';
import 'package:provider/provider.dart';

import '../../../contact_management_provider.dart';

class ContactManagement extends StatelessWidget {
  // const ContactManagement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddContact()),
              );
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      // body: Text('demo'),
      body: displayContactList(),
    );
  }

  Widget displayContactList() {
    return Consumer<ContactListProvider>(
        builder: (context, contactListProvider, child) {
      final contactList = contactListProvider.getContactList;

      print(contactList.length);
      return ListView.builder(
          itemCount: contactList.length,
          itemBuilder: (context, index) {
            final contact = contactList.getAt(index);
            bool isAvatar = contact.avatar == null ? false : true;
            // List<String> nameIconList =
            //     contact.givenName.split(new RegExp("\\s+"));
            // print(nameIconList);
            // print(nameIconList.length);
            // String nameIcon = nameIconList.length == 1
            //     ? nameIconList[0][0]
            //     : "${nameIconList[0][0]}${nameIconList[1][0]}";
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpdateContact(index)),
                );
              },
              leading: isAvatar
                  ? CircleAvatar(
                      backgroundImage: MemoryImage(contact.avatar),
                    )
                  : CircleAvatar(child: Text(contact.givenName[0][0])),
              title: Text(
                contact.givenName,
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(contact.phone.value),
              trailing: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text("Delete contact confirmation"),
                        content: Text("Do you want to delete this contact"),
                        actions: <Widget>[
                          FloatingActionButton(
                            onPressed: () {
                              contactListProvider.deleteContact(index);
                              Navigator.of(ctx).pop();
                            },
                            child: Text("Yes"),
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
