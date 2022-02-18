class ContactAppStrings {
  ContactAppStrings._();
  static ContactAppStrings? _instance;

  static ContactAppStrings get instance => _instance ??= ContactAppStrings._();
  final String addContact = 'Add Contact';
  final String updateContact = 'Update Contact';
  final String firstNameLabel = ' First Name';
  final String lastNameLabel = 'Last Name';
  final String contactLabel = 'Contact number';
  final String pickImage = 'Pick an Image';
  final String deleteDialog = 'Delete contact confirmation';
  final String confirmDelete = 'Do you want to delete this contact';
  final String emptyName = 'Name should not be empty';
  final String multipleWord = 'Name should be single word';
}
