import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'controller/view_controller.dart';

// Page where admin and staff can view requested academic qualifications by users to approve or reject them. And also assigned them to category their in according to their qualifications .e.g 1. Certificate 2. Diploma 3. Degree 4. Masters 5. PHD,
//and according to their field. e.g 1. Computer Science 2. Medicine 3. Engineering 4. Business 5. Law
@RoutePage()
class ViewAcademicQualificationsPage
    extends GetView<ViewAcademicQualificationController> {
  const ViewAcademicQualificationsPage({super.key});
  @override
  ViewAcademicQualificationController get controller =>
      Get.put(ViewAcademicQualificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Academic Qualifications Requests',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Obx((){
            return Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.13),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: controller.qualifications.isEmpty
                  ? const Center(
                      child: Text(
                        'No Request Submitted',
                        style: TextStyle(fontSize: 18,
                        color: Colors.white),
                      ),
                    )
                  : ListView.separated(
                  itemCount: controller.qualifications.length,
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.grey,
                    thickness: 1.0,
                  ),
                  itemBuilder: (context, index) {
                    final qualification = controller.qualifications[index];
                    return ListTile(
                      title: Text(qualification['name'] ?? 'Unknown Name', style: const TextStyle(color: Colors.white) ,),
                      subtitle: Text(
                          'Education: ${qualification['levelOfEducation']}\nField of Study: ${qualification['fieldOfStudy']}', style: const TextStyle(color: Colors.white) ,),
                      trailing: IconButton(
                        icon: const Icon(Icons.menu_rounded, color: Colors.white),
                        onPressed: () {
                          _showQualificationDetails(context, qualification);
                        },
                      ),
                    );
                  },
                ),
              ),
            );
            }),
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
        return  SizedBox(
          width: MediaQuery.of(context).size.width > 850 ?MediaQuery.of(context).size.width * 0.3 : MediaQuery.of(context).size.width * 0.9,
          child: AlertDialog(
              title: const Text('Qualification Details'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text('Name: ${qualification['name']}'),
                    Text('Education: ${qualification['levelOfEducation']}'),
                    Text('Field of Study: ${qualification['fieldOfStudy']}'),
                    Text('Institution: ${qualification['institutionName']}'),
                    Wrap(children: [SelectableText('Certificate URL: ${qualification['certificateUrl']}')],),
                    
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    bool isSuccess = await controller.approveQualification(
                        qualification['qualificationId'],
                        qualification['userId']);
                    Navigator.pop(context); // Close the previous dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          icon: Icon(
                            isSuccess ? Icons.check_rounded : Icons.close_rounded,
                            color:
                                isSuccess ? Colors.greenAccent : Colors.redAccent,
                          ),
                          title: Text(isSuccess ? 'Success' : 'Error'),
                          content: Text(isSuccess
                              ? 'Qualification approved successfully.'
                              : 'Failed to approve qualification.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Approve'),
                ),
                TextButton(
                  onPressed: () async {
                    bool isSuccess = await controller.rejectQualification(
                        qualification['qualificationId'],
                        qualification['userId']);
                    Navigator.pop(context); // Close the previous dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          icon: Icon(
                            isSuccess ? Icons.check_rounded : Icons.close_rounded,
                            color:
                                isSuccess ? Colors.greenAccent : Colors.redAccent,
                          ),
                          title: Text(isSuccess ? 'Success' : 'Error'),
                          content: Text(isSuccess
                              ? 'Qualification rejected successfully.'
                              : 'Failed to reject qualification.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Reject'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ]),
        );
      },
    );
  }
}
