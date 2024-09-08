import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/palette.dart';
import '../../theme/gen/assets.gen.dart';
import '../../routes/app_router.dart';
import '../../utils/color_extension.dart';
import 'home_controller.dart';
@RoutePage()
class MyHomePage extends GetView<HomeController> {
  MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Row(
          children: <Widget>[
            const Text('LearnSphere'), // Add a title to the AppBar
            const Spacer(),
            const _BellIcon(
              hasNotifications: true
              ),
            const SizedBox(
              width: 34
              ),
            CircleAvatar(
              backgroundImage: AssetImage('assets/01.png'),
              child: PopupMenuButton<String>(
                offset: const Offset( 0, 50),
                child: Container(),
                 onSelected: (String value) {
                  switch (value) {
                    case 'View Profile':
                      context.router.push( ProfileRouteRoute());
                      break;
                    case 'Edit Profile':
                      context.router.push( const EditProfileRoute());
                      break;
                  }
                },
                itemBuilder: (BuildContext context){
                  return <PopupMenuEntry<String>>[     
                    const PopupMenuItem<String>(
                      value: 'View Profile',
                      child: Row(
                        children : [
                          Icon(Icons.person),
                          Text('   View Profile'),
                        ]
                      ),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Edit Profile',
                      child: Row(
                        children : [
                          Icon(Icons.settings),
                          Text('   Edit Profile'),
                        ]
                      ),
                    ),
                  ];
                },                
              ),
            ),
            SizedBox(width: 16),
          ],
        ),

      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage('https://via.placeholder.com/50'),
              ),
              title: Text('Username $index'),
              subtitle: Text('This is a sample Post'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create tweet page
          //Navigator.push(
          //context,
          //MaterialPageRoute(builder: (context) => CreateTweetPage()),
          //);
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}

class _BellIcon extends StatelessWidget {
  const _BellIcon({required this.hasNotifications});

  final bool hasNotifications;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: <Widget>[
        ProjectAssets.icons.bell.svg(
          width: 24,
          height: 27.79,
          colorFilter: Palette.black.toColorFilter,
        ),
        if (hasNotifications)
          Container(
            margin: const EdgeInsets.all(1),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Palette.blue,
              shape: BoxShape.circle,
              border: Border.all(color: Palette.dirtyWhite),
            ),
          ),
      ],
    );
  }
}
