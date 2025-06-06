part of 'contacts_cubit.dart';

class ContactsState extends Equatable {
  const ContactsState({this.allContacts = const []});
  final List<Map<String, dynamic>> allContacts;
  ContactsState copyWith({
    List<Map<String, dynamic>>? allContacts,
  }) {
    return ContactsState(
      allContacts: allContacts ?? this.allContacts,
    );
  }

  @override
  List<Object> get props => [
        allContacts,
      ];
}
