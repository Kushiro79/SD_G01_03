import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'discover_page_controller.dart';

@RoutePage()
class DiscoverPage extends GetView<DiscoverController> {
  DiscoverPage({super.key});

  final DiscoverController controller = Get.put(DiscoverController());



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(
                tabs: [
                  Tab(
                    text: 'Discover',
                  ),
                  Tab(text: 'Following'),
                ],
              ),
              title: const Text('Discover'),
            ),
            body: TabBarView(children: [
              discoverTab(),
              Container(),
            ])));
  }

  discoverTab() {
    return Obx(() {
      controller.discoverList();
      if (controller.users.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return ListView.separated(
          itemCount: controller.users.length,
          separatorBuilder: (context, index) => const Divider(
            color: Colors.black,
          ),
          itemBuilder: (context, index) => ListTile(
            leading: controller.users[index]['profileImageUrl'] != null
              ? Image.network(controller.users[index]['profileImageUrl'])
              : const Icon(Icons.person),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                controller.users[index]['username'] != null
                  ? Text(controller.users[index]['username'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                  : const Text('Unknown User'),
                controller.users[index]['bannerImageUrl'] != null
                  ? Image.network(controller.users[index]['bannerImageUrl'])
                  : const Icon(Icons.image),
            ]),
          ),
          
        );
      }
    });
  }
}
