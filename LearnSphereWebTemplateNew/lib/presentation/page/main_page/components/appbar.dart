part of '../page.dart';

class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    EditProfileController controller = Get.put(EditProfileController());
    return  SizedBox(
      height: 60,
      child: Row(
        children: <Widget>[
          
          const Spacer(),
          const SizedBox(width: 34),
          Obx(() {
                            return controller.profileImageUrl.isNotEmpty
                                ? ClipOval(
                                    child: Image.network(
                                      controller.profileImageUrl.value,
                                      height: 40,
                                      width: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Container(
                                    height: 40,
                                    width: 40,
                                    alignment: Alignment.topLeft,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors
                                          .grey, // Use a default color or your AppColor.Secondary
                                    ),
                                    child: const Center(
                                        child: Icon(Icons.person,
                                            color: Colors
                                                .white)), // Optional: Add an icon
                                  );
                          }),
          const SizedBox(width: 40),
        ],
      ),
    );
  }
}