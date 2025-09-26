import 'package:app_scrip/models/task_model.dart';
import 'package:app_scrip/view/login/login_page.dart';
import 'package:app_scrip/view/register/register_page.dart';
import 'package:app_scrip/view/splash/splash.dart';
import 'package:app_scrip/view/task_list/create_task.dart';
import 'package:app_scrip/view/task_list/update_task.dart';
import 'package:app_scrip/view/task_list/task_list.dart';
import 'package:app_scrip/view/user_list/single_user_page.dart';
import 'package:app_scrip/view/user_list/user_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage<void> buildPage(Widget child, GoRouterState state) {
  return CustomTransitionPage<void>(
    transitionDuration: const Duration(milliseconds: 300), // smoother
    key: state.pageKey,
    child: child,

    // Smooth left-to-right slide (iOS style)
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(-1.0, 0.0); // <- left off-screen
      const end = Offset.zero;
      const curve = Curves.easeInOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      // Optional: fade in along with slide
      return SlideTransition(
        position: offsetAnimation,
        child: FadeTransition(opacity: animation, child: child),
      );
    },
  );
}

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) {
          return buildPage(SplashScreen(), state);
        },
      ),
      GoRoute(
        path: '/register',
        pageBuilder: (context, state) {
          return buildPage(RegisterPage(), state);
        },
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) {
          return buildPage(LoginPage(), state);
        },
      ),
      GoRoute(
        path: '/tasklist',
        pageBuilder: (context, state) {
          return buildPage(TaskList(), state);
        },
      ),
      GoRoute(
        path: '/createtask',
        pageBuilder: (context, state) {
          return buildPage(CreateTask(), state);
        },
      ),
      GoRoute(
        path: '/edittask',
        pageBuilder: (context, state) {
          final args = state.extra as Map<String, dynamic>;
          final task = args['task'] as TaskModel;
          final index = args['index'] as int;
          return buildPage(UpdateTask(task: task, index: index), state);
        },
      ),
      GoRoute(
        path: '/singluserpage/:userid',
        pageBuilder: (context, state) {
          final id = int.parse(state.pathParameters['userid']!);
          return buildPage(SingleUserPage(userId: id), state);
        },
      ),
      GoRoute(
        path: '/userlist',
        pageBuilder: (context, state) {
          return buildPage(UserList(), state);
        },
      ),
    ],
  );
}
