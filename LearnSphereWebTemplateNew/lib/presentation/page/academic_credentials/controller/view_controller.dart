import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ViewAcademicQualificationController extends GetxController {
  RxList<Map<String, dynamic>> qualifications = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    viewAcademicQualifications();
  }

  Future<void> viewAcademicQualifications() async {
    // Get the academic qualifications from the database
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    QuerySnapshot querySnapshot = await firestore
        .collection('qualificationRequests')
        .doc('requested')
        .collection('uniqueRequests')
        .get();

    qualifications.clear();

    querySnapshot.docs.forEach((doc) {
      // Get the name, education, and field of study from the document
      qualifications.add({
        'qualificationId': doc.id,
        ...doc.data() as Map<String, dynamic>,
      });
    });

    print(qualifications);
    // and assign them to the name, education, and fieldOfStudy variables
  }

  Future<void> approveQualification(
      String qualificationId, String userId) async {
    // Get the Firestore instance and the current user's UID
    FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Update the qualification request document to set the status to approved
    await firestore
        .collection('qualificationRequests')
        .doc('requested')
        .collection('uniqueRequests')
        .doc(qualificationId)
        .update({
      'status': 'approved',
    });

    // Get the qualification request document data
    DocumentSnapshot qualificationRequestDoc = await firestore
        .collection('qualificationRequests')
        .doc('requested')
        .collection('uniqueRequests')
        .doc(qualificationId)
        .get();
    Map<String, dynamic> qualificationData =
        qualificationRequestDoc.data() as Map<String, dynamic>;

    // Create a new certificate document in the user's certificate collection
    try {
      await firestore
          .collection('qualificationRequests')
          .doc('approvedCertificates')
          .collection('users')
          .doc(userId)
          .collection('certificates')
          .doc(qualificationId)
          .set(qualificationData);

      print('Certificate document created successfully');

      await firestore
          .collection('qualificationRequests')
          .doc('requested')
          .collection('uniqueRequests')
          .doc(qualificationId)
          .delete();
    } catch (e) {
      print('Error creating certificate document: $e');
    }

    //Delete qualification Request document
  }

  @override
  void onClose() {
    qualifications.clear();
  }
}
