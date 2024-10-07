import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_router.dart';
import '../controllers/edit_profile_controller.dart';
import '../controllers/profile_screen_controller.dart';

@RoutePage()
class ProfileScreenPage extends StatelessWidget {
  final ProfileScreenController profileController =
      Get.put(ProfileScreenController());
  final EditProfileController editController = Get.put(EditProfileController());

  ProfileScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    String username = profileController.username.value;
    String email = profileController.email.value;
    String profileImageUrl = editController.profileImageUrl.value;
    //String bannerImageUrl = editController.bannerImageUrl.value;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Profile',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.black),
              onPressed: () {
                // Navigate to the Edit Profile screen
                AutoRouter.of(context).push(EditProfileRoute());
              },
            ),
          ],
        ),
        body: Column(children: [
          Stack(
            children: [
              SizedBox(
                //profile banner
                height: 300,
                width: double.infinity,
                child: Obx(() {
                  return editController.bannerImageUrl.isNotEmpty
                      ? Opacity(
                          opacity: 0.9,
                          child: Image.network(
                            editController.bannerImageUrl.value,
                            fit: BoxFit.cover,
                          ))
                      : Image.asset(
                          'assets/background.jpg',
                          fit: BoxFit.cover,
                        );
                }),
              ),
              Positioned(
                top: 80, // adjust the value to control the overlap
                left: 0,
                right: 0,
                child: Center(
                  child: Obx(() {
                    return profileController.profileImageUrl.isNotEmpty
                        ? ClipOval(
                            child: Image.network(
                              profileController.profileImageUrl.value,
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.only(top: 16),
                            height: 150,
                            width: 150,
                            alignment: Alignment.topLeft,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors
                                  .grey, // Use a default color or your AppColor.Secondary
                            ),
                            child: const Center(
                                child: Icon(Icons.person,
                                    color:
                                        Colors.white)), // Optional: Add an icon
                          );
                  }),
                ),
              ),

              // Profile content
            ],
          ),
          
        ]));

    /* List post = [
      'assets/Post01.png',
      'assets/Post02.png',
    ];

    List reel = [
      'assets/reel1.png',
      'assets/reel3.png',
    ];

    List tag = [
      'assets/tag1.png',
      'assets/tag2.png',
    ];
    List content = [
      '1.8K',
      '1.3K',
    ];
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  )),
              centerTitle: true,
              title: const Text('Profile',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Urbanist-semibold',
                      fontWeight: FontWeight.w600,
                      fontSize: 18)),
              actions: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Image.asset('assets/peoshare.png'),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  height: 24,
                  width: 24,
                  child: InkWell(
                      /*onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ActivityScreenView(),
                            ));
                      },*/
                      child: Image.asset('assets/setting.png')),
                ),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                height: Get.size.height * 1.2,
                width: Get.size.width,
                child: Column(
                  children: [
                    // Profile Banner, Pic and Name
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 173,
                          width: Get.size.width,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  'assets/Banner.png',
                                ),
                                fit: BoxFit.fill),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                          ),
                        ),
                        Positioned(
                          bottom: -50,
                          left: 0,
                          right: 0,
                          child: Stack(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.indigo.shade300,
                                          border: Border.all(color: Colors.white, width: 5),
                                          shape: BoxShape.circle,
                                          image: const DecorationImage(
                                            image: AssetImage('assets/InstaStory.png'),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        bottom: 0,
                                        child: Container(
                                          height: 32,
                                          width: 32,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                              color: AppColor.Secondary,
                                              border: Border.all(
                                                  color: Colors.white, width: 3)),
                                          child: Center(
                                            child: Image.asset(
                                              'assets/camera.png',
                                              height: 16,
                                              width: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 40,
                      ),
                      child: ListTile(
                        title: Center(
                            child: Text(
                          'Williamson',
                          style: TextStyle(
                              fontSize: 18, fontFamily: 'Urbanist-semibold'),
                          overflow: TextOverflow.ellipsis,
                        )),
                        subtitle: Center(
                            child: Text(
                          'Traveller/Tripper',
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff64748B),
                              fontFamily: 'Urbanist-regular'),
                          overflow: TextOverflow.ellipsis,
                        )),
                      ),
                    ),
                    // Followers and Following
                    GestureDetector(
                      /*onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FollowScreenView()));
                      },*/
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          height: 77,
                          width: 370,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            border: Border.all(
                                width: 1, color: const Color(0xffE2E8F0)),
                          ),
                          child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '89',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Urbanist-semibold'),
                                      ),
                                SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Posts',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff64748B),
                                            fontFamily: 'Urbanist-medium'),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('1.3K',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'Urbanist-semibold')),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text('Followers',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff64748B),
                                              fontFamily: 'Urbanist-medium')),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('435',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'Urbanist-semibold')),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text('Following',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff64748B),
                                              fontFamily: 'Urbanist-medium')),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ),
                    // Edit Profile and floating button
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /*elevated1(
                            text: 'Edit Profile',
                            onPress: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditprofileScreenView()));
                            },
                          ),*/
                          const SizedBox(width: 20),
                          FloatingActionButton(
                            onPressed: () {},
                            backgroundColor: const Color(0xff021F31),
                            child: SizedBox(
                              height: 24,
                              width: 24,
                              child: Image.asset('assets/add-square.png'),
                            ),
                          ),
                        ],      
                        ),
                    ),
                    const SizedBox(height: 20),
                    // Tabbar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: TabBar(
                          indicatorColor: AppColor.purple,
                          tabs: [
                            Tab(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Image.asset('assets/grid-1.png'),
                                ),
                                const Text(
                                  '   Post',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontFamily: 'Urbanist-semibold'),
                                ),
                              ],
                            )),
                            Tab(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Image.asset(
                                    'assets/reel.png',
                                    color: Colors.black,
                                  ),
                                ),
                                const Text(
                                  '  Reels',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontFamily: 'Urbanist-semibold'),
                                ),
                              ],
                            )),
                            Tab(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Image.asset(
                                    'assets/tag-user.png',
                                    color: Colors.black,
                                  ),
                                ),
                                const Text(
                                  '  Mark',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontFamily: 'Urbanist-semibold'),
                                ),
                              ],
                            )),
                          ],
                        ),
                      ),
                    ),
                    // TabbarView
                    Expanded(
                      child: TabBarView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, mainAxisExtent: 229),
                              itemCount: post.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: 229,
                                    width: 157,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.asset(
                                          post[index],
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.zero,
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, mainAxisExtent: 250),
                              itemCount: reel.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Stack(
                                      children: [
                                        SizedBox(
                                          height: 250,
                                          width: 157,
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.circular(15),
                                              child: Image.asset(reel[index], fit: BoxFit.cover,)),
                                        ),
                                        Positioned(
                                          top: 10,
                                          left: 10,
                                          child: SizedBox(
                                              height: 24,
                                              child: Image.asset(Appcontent.videoplay)),
                                        ),
                                        Positioned(
                                          bottom: 10,
                                            right: 10,
                                            child: Container(
                                              height: 21,
                                              width: 49,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(100),
                                                color: Colors.black.withOpacity(0.24),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Image.asset('assets/heart1.png', height: 12, width: 12,),
                                                  const SizedBox(width: 5,),
                                                  Text(content[index], style: const TextStyle(fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600, fontSize: 10, color: Color(0xffF0FEFE)),),
                                                ],
                                              ),
                                            ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                                },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisExtent: 200),
                              itemCount: tag.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  height: 200,
                                  width: 157,
                                  child: Stack(
                                    children: [
                                      Image.asset(tag[index]),
                                      Positioned(
                                        left: 10,
                                        bottom: 45,
                                        child: SizedBox(
                                          height: 24,
                                          child: Image.asset(Appcontent.tag),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),


                  ],
                ),
              ),
            ),
          );
        },
      ),
    );*/
  }
}
