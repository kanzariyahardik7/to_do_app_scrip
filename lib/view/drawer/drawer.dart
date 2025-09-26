import 'package:app_scrip/utils/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app_scrip/utils/colors.dart';
import 'package:app_scrip/utils/utils.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: blue),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: white,
                  child: Icon(Icons.person, size: 30, color: blue),
                ),
                SizedBox(height: 10),
                Text(
                  "Welcome 👋",
                  style: TextStyle(
                    color: white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text("Your Dashboard", style: TextStyle(color: white70)),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.group, color: blue),
            title: const Text("Get All Users"),
            onTap: () {
              context.pop(); // close drawer
              context.push('/userlist'); // navigate to user list page
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: red),
            title: const Text("Logout", style: TextStyle(color: red)),
            onTap: () {
              // Clear session here if using local storage
              UserPreferences.removeToken();
              Utils.toastMessage("Logged out successfully", success);
              context.go('/register'); // go to login screen
            },
          ),
        ],
      ),
    );
  }
}
