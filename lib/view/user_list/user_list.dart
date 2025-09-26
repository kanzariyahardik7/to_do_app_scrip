import 'package:app_scrip/app_dependency/get_it_depencency.dart';
import 'package:app_scrip/services/response/api_status.dart';
import 'package:app_scrip/utils/colors.dart';
import 'package:app_scrip/view/user_list/widgets/single_user_widget.dart';
import 'package:app_scrip/view_models/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final ScrollController scrollController = ScrollController();
  late final UserViewModel userViewModel;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    userViewModel = getIt<UserViewModel>();
    userViewModel.resetUserData();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      fetchUserList();
    });
  }

  fetchUserList() {
    Map<String, dynamic> query = {
      "page": userViewModel.currentPage + 1,
      "per_page": userViewModel.perPage,
    };
    userViewModel.fetchUsers(query);
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (userViewModel.currentPage < userViewModel.totalPages) {
        fetchUserList();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: const Text("User List"),
        scrolledUnderElevation: 0,
        backgroundColor: white,
      ),
      body: Consumer<UserViewModel>(
        builder: (context, value, child) {
          if (value.currentPage == 0 &&
              value.getUsersApiResponse.status == Status.loading) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (value.getUsersApiResponse.status == Status.completed &&
                value.getUsersApiResponse.data!.data!.isEmpty) {
              return Text("No data");
            } else {
              return ListView(
                controller: scrollController,
                padding: const EdgeInsets.all(12),
                children: [
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 30);
                    },
                    shrinkWrap: true,
                    itemCount: value.userList.length,
                    itemBuilder: (context, index) {
                      final user = value.userList[index];
                      return SingleUserWidget(userModel: user);
                    },
                  ),

                  const SizedBox(height: 15),
                  value.currentPage == value.totalPages
                      ? const SizedBox.shrink()
                      : SizedBox(
                          height: 50,
                          width: 50,
                          child: Center(
                            child: const CircularProgressIndicator(),
                          ),
                        ),

                  const SizedBox(height: 50),
                ],
              );
            }
          }
        },
      ),
    );
  }
}
