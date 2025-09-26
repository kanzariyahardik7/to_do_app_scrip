import 'package:app_scrip/models/user_list_model.dart';
import 'package:app_scrip/universal_widgets/my_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SingleUserWidget extends StatefulWidget {
  final UserModel userModel;
  const SingleUserWidget({super.key, required this.userModel});

  @override
  State<SingleUserWidget> createState() => _SingleUserWidgetState();
}

class _SingleUserWidgetState extends State<SingleUserWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push("/singluserpage/${widget.userModel.id}");
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(150),
            child: Hero(
              tag: "user_image_${widget.userModel.id}",
              child: MyNetworkImage(
                imageUrl: widget.userModel.avatar ?? '',
                fit: BoxFit.contain,
                imgHeight: 200,
                imgWidth: 200,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            "${widget.userModel.firstName} ${widget.userModel.lastName}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            widget.userModel.email ?? '',
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
