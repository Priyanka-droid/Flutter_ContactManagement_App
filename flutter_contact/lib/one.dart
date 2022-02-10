// import 'package:flutter/material.dart';
// import 'package:contacts_service/contacts_service.dart';
// import 'package:permission_handler/permission_handler.dart';

// void main() {
//   runApp(HomePage());
// }

// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Contact Management App',
//       home: ContactManagement(),
//     );
//   }
// }

// class ContactManagement extends StatefulWidget {
//   const ContactManagement({Key? key}) : super(key: key);

//   @override
//   _ContactManagementState createState() => _ContactManagementState();
// }

// class _ContactManagementState extends State<ContactManagement> {
//   List<Contact> contactList = [];
//   @override
//   void initState() {
//     super.initState();
//     print("application started");
//     getAllContacts();
//     print("contacts fetched");
//   }

//   getAllContacts() async {
//     PermissionStatus permission = await Permission.contacts.request();
//     List<Contact> contacts = await ContactsService.getContacts();
//     print(contacts.elementAt(0).displayName);
//     setState(() {
//       contactList = contacts;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Contact Management App'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.add),
//             onPressed: addContact,
//             tooltip: 'Saved Suggestions',
//           ),
//         ],
//       ),
//       body: contactList.isEmpty ? null : displayContacts(),
//     );
//   }

//   Widget displayContacts() {
//     return ListView.builder(
//       itemCount: contactList.length,
//       itemBuilder: (context, index) {
//         return buildRow(contactList[index]);
//       },
//     );
//   }

//   Widget buildRow(Contact contact) {
//     return ListTile(
//       title: contact.displayName == null
//           ? Text('No Name')
//           : Text(contact.displayName!),
//       // subtitle: contact.phones == null
//       //     ? Text('No contact')
//       //     : (contact.phones!.elementAt(0).value == null
//       //         ? Text('No Contact')
//       //         : Text(contact.phones!.elementAt(0).value!)),
//     );
//   }

//   void addContact() {
//     Navigator.of(context).push(
//       MaterialPageRoute<void>(
//         builder: (context) {
//           return Scaffold(
//               appBar: AppBar(title: Text('Add contacts')),
//               body: Text('Add contactss here'));
//         },
//       ),
//     );
//   }
// }
