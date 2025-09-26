import 'package:app_scrip/app_dependency/get_it_depencency.dart';
import 'package:app_scrip/utils/colors.dart';
import 'package:app_scrip/view/drawer/drawer.dart';
import 'package:app_scrip/view/task_list/widget/task_item_widget.dart';
import 'package:app_scrip/view_models/task_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  late final TaskViewModel taskViewModel;
  @override
  void initState() {
    super.initState();
    taskViewModel = getIt<TaskViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      taskViewModel.fetchTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: const Text('Tasks List'),
        scrolledUnderElevation: 0,
        backgroundColor: white,
      ),
      drawer: const AppDrawer(),
      body: Consumer<TaskViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (viewModel.tasks.isEmpty) {
              return Center(child: Text("No Data"));
            } else {
              return ListView.builder(
                itemCount: viewModel.tasks.length,
                itemBuilder: (context, index) {
                  final task = viewModel.tasks[index];
                  return TaskItemWidget(
                    task: task,
                    onTap: (t) {
                      context.push(
                        '/edittask',
                        extra: {"task": t, "index": index},
                      ); // Pass task for editing
                    },
                    onDelete: (t) {
                      viewModel.deleteTask(t.id!);
                    },
                  );
                },
              );
            }
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: green,
        onPressed: () async {
          context.push("/createtask");
        },
        child: const Icon(Icons.add, color: white),
      ),
    );
  }
}
