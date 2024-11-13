import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../other_users/other_users_controller.dart';

@RoutePage()
class ViewOtherUsersPage extends GetView<ViewOtherUsersController> {
  ViewOtherUsersPage({super.key});

  @override
  final ViewOtherUsersController controller = Get.put(ViewOtherUsersController());

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Users'),
      ),
      body: Obx(() {
        if (controller.users.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: controller.users.length,
            itemBuilder: (context, index) {
              return const ListTile(
                /*leading: CircleAvatar(
                  backgroundImage: NetworkImage(controller.users[index].data()['profilePicture']),
                ),*/
                //title: Text(controller.users[index].data()['username']),
                //subtitle: Text(controller.users[index].data()['email']),
              );
            },
          );
        }
      }),
    );
  
  }

}


