import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../contact_management_provider.dart';
import '../../form.dart';

// add screen which displays add form on giving index -1

class AddContact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ContactListProvider>(
        builder: (context, ContactListProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Add Contact'),
        ),
        body: CustomForm(index: -1),
      );
    });
  }
}
