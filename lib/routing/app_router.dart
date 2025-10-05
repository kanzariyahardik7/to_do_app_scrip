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
import 'package:flutter/widgets.dart';

CustomTransitionPage<void> buildPage(Widget child, GoRouterState state) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    transitionDuration: const Duration(milliseconds: 700),
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return AnimatedBuilder(
        animation: animation,
        builder: (context, _) {
          // Radius grows from 0 to full screen diagonal
          final size = MediaQuery.of(context).size;
          final maxRadius =
              (size.height * size.height + size.width * size.width);
          final radius = animation.value * maxRadius;

          return ClipPath(clipper: _CircleRevealClipper(radius), child: child);
        },
      );
    },
  );
}

class _CircleRevealClipper extends CustomClipper<Path> {
  final double radius;
  _CircleRevealClipper(this.radius);

  @override
  Path getClip(Size size) {
    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    path.addOval(Rect.fromCircle(center: center, radius: radius));
    return path;
  }

  @override
  bool shouldReclip(_CircleRevealClipper oldClipper) =>
      radius != oldClipper.radius;
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
