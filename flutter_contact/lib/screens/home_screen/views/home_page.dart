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
      body: displayContactList(),
    );
  }

  Widget displayContactList() {
    return Consumer<ContactListProvider>(
        builder: (context, contactList, child) {
      return ListView.builder(
          key: UniqueKey(),
          itemCount: contactList.getContactList.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpdateContact(index)),
                );
              },
              title: Text(
                contactList.getContactList[index].givenName!,
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text('subtitle'),
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
                              contactList.deleteContact(index);
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
