import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/constants/constants.dart';
import 'package:chitchat/src/core/models/user_model.dart';
import 'package:chitchat/src/features/home/presentation/cubit/cubit/home_cubit.dart';
import 'package:chitchat/src/features/home/presentation/widgets/general_widgets/contact_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // When pressed here the query will be cleared from the search bar.
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // Exit from the search screen.
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        getIt<HomeCubit>().loadData();
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _searchBody();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    getIt<HomeCubit>().searchForUser(searchText: query);

    return _searchBody();
  }

  Widget _searchBody() {
    return BlocProvider.value(
      value: getIt<HomeCubit>(),
      child: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        if (state is HomeLoadedMassagesSearchPage) {
          return state.filteredUsers.isEmpty
              ? _noResults()
              : _searchResults(results: state.filteredUsers);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }

  Widget _noResults() {
    return Center(
      child: Text(
        'No user with this name',
        style: AppTextStyles.poppinsFont16Black100Regular1,
      ),
    );
  }

  Widget _searchResults({required List<UserModel> results}) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h, left: 10.w),
      child: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: ContactInfo(
              bio: results[index].bio,
              name: results[index].name,
              userPhoto: results[index].photo,
              onTap: () {
                getIt<HomeCubit>().navigateToChatScreen(
                    receiver: results[index], context: context);
              },
            ),
          );
        },
      ),
    );
  }
}
