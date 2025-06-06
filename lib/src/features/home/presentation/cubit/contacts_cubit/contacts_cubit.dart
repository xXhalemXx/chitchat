import 'package:bloc/bloc.dart';
import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/networking/models/user_model.dart';
import 'package:chitchat/src/features/home/presentation/cubit/messages_cubit/messages_cubit.dart';
import 'package:equatable/equatable.dart';

part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  ContactsCubit() : super(ContactsState());

  void setContacts() {
    List<Map<String, dynamic>> allContactsWithChar = [];
    List<UserModel> allContacts = getIt<MessagesCubit>()
        .state
        .usersHaveChatWith
        .map((e) => e.user)
        .toList()
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    List<String> character = [];
    for (UserModel user in allContacts) {
      String firstLetter = user.name[0].toUpperCase();
      if (!character.contains(firstLetter)) {
        /// If the first letter is not already in the list, add it
        character.add(firstLetter);

        /// Add the first letter as a new entry in the map
        allContactsWithChar.add({'char': firstLetter, 'data': null});

        /// Add the user data under the new character entry
        allContactsWithChar.add({'char': '*', 'data': user});
      } else {
        /// If the first letter is already in the list, just add the user data
        allContactsWithChar.add({'char': '*', 'data': user});
      }
    }
    emit(state.copyWith(
      allContacts: allContactsWithChar,
    ));
  }
}
