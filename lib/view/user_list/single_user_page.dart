import 'package:app_scrip/view/user_list/widgets/single_user_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_scrip/services/response/api_status.dart';
import 'package:app_scrip/view_models/user_view_model.dart';

class SingleUserPage extends StatefulWidget {
  final int userId;
  const SingleUserPage({super.key, required this.userId});

  @override
  State<SingleUserPage> createState() => _SingleUserPageState();
}

class _SingleUserPageState extends State<SingleUserPage> {
  late UserViewModel userViewModel;

  @override
  void initState() {
    super.initState();
    userViewModel = context.read<UserViewModel>();

    // fetch single user API
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userViewModel.fetchSingleUser(widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Details"),
        scrolledUnderElevation: 0,
      ),
      body: Consumer<UserViewModel>(
        builder: (context, value, child) {
          if (value.getSingleUserApiResponse.status == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (value.getSingleUserApiResponse.status == Status.error) {
            return Center(
              child: Text(value.getSingleUserApiResponse.message ?? "Error"),
            );
          }

          if (value.getSingleUserApiResponse.status == Status.completed &&
              value.getSingleUserApiResponse.data != null) {
            final user = value.getSingleUserApiResponse.data!;
            return Column(
              children: [
                SizedBox(height: 100),
                Center(child: SingleUserWidget(userModel: user.data!)),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
