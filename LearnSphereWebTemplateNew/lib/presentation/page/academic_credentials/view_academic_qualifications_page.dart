import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'controller/view_controller.dart';


// Page where admin and staff can view requested academic qualifications by users to approve or reject them. And also assigned them to category their in according to their qualifications .e.g 1. Certificate 2. Diploma 3. Degree 4. Masters 5. PHD,
//and according to their field. e.g 1. Computer Science 2. Medicine 3. Engineering 4. Business 5. Law
@RoutePage()
class ViewAcademicQualificationsPage extends GetView<ViewAcademicQualificationController> {
  const ViewAcademicQualificationsPage({super.key});
  ViewAcademicQualificationController get controller => Get.put(ViewAcademicQualificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'List of Qualifications',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ListView.separated(
                  itemCount: controller.qualifications.length,
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.grey,
                    thickness: 1.0,
                  ),
                  itemBuilder: (context, index) {
                    final qualification = controller.qualifications[index];
                    return ListTile(
                      title: Text(qualification['name'] ?? 'Unknown Name'),
                      subtitle: Text(
                          'Education: ${qualification['levelOfEducation']}\nField of Study: ${qualification['fieldOfStudy']}'),
                      trailing: IconButton(
                        icon: Icon(Icons.info_outline),
                        onPressed: () {
                          _showQualificationDetails(context, qualification);
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showQualificationDetails(
      BuildContext context, Map<String, dynamic> qualification) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Qualification Details'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Name: ${qualification['name']}'),
                Text('Education: ${qualification['levelOfEducation']}'),
                Text('Field of Study: ${qualification['fieldOfStudy']}'),
                Text('Institution: ${qualification['institutionName']}'),
                ElevatedButton(
                  onPressed : () async {
                    final urlString = qualification['certificateUrl'];
                    Uri url = Uri.parse(urlString);
                    if (url != null) {
                      await launchUrl(url);
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Could not launch certificate')),
                      );
                    }
                  },
                  child: const Text('View Certificate'),
                )


              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                controller.approveQualification(qualification['qualificationId'],qualification['userId']);
                Navigator.pop(context);
              },
              child: const Text('Approve'),
            ),
            TextButton(
              onPressed: () {
                //controller.rejectQualification(qualification);
                Navigator.pop(context);
              },
              child: const Text('Reject'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}