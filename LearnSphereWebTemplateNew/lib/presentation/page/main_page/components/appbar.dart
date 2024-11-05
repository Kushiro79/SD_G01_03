part of '../page.dart';

class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    EditProfileController controller = Get.put(EditProfileController());
    var screenwidth = MediaQuery.of(context).size.width > 850;

    return SizedBox(
      height: 100,
      child: Row(
        children: <Widget>[
          Image(
            image: AssetImage(ProjectAssets.learnSphereLogo.path),
            width: screenwidth ? 80 : 60,
            height: screenwidth ? 80 : 60,
          ),
          const SizedBox(width: 10),
          screenwidth
              ? Row(
                  children: [
                    Text("Learn",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: screenwidth ? 30 : 20,
                            color: Colors.white)),
                    Text(
                      "Sphere",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF004ff9),
                        fontSize: screenwidth ? 30 : 20,
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
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
                            color: Colors.white)), // Optional: Add an icon
                  );
          }),
          const SizedBox(width: 40),
        ],
      ),
    );
  }
}
