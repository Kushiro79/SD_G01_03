import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ViewAcademicQualificationController extends GetxController {
  RxList<Map<String, dynamic>> qualifications = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    viewAcademicQualifications();
    FirebaseAuth.instance.currentUser!.uid;
  }

  Future<void> viewAcademicQualifications() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await firestore
        .collection('qualificationRequests')
        .doc('requested')
        .collection('uniqueRequests')
        .get();

    qualifications.clear();

    for (var doc in querySnapshot.docs) {
      qualifications.add({
        'qualificationId': doc.id,
        ...doc.data() as Map<String, dynamic>,
      });
    }

    print(qualifications);
  }

  Future<bool> approveQualification(String qualificationId, String userId) async {
    FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    await firestore
        .collection('qualificationRequests')
        .doc('requested')
        .collection('uniqueRequests')
        .doc(qualificationId)
        .update({
      'status': 'approved',
    });

    DocumentSnapshot qualificationRequestDoc = await firestore
        .collection('qualificationRequests')
        .doc('requested')
        .collection('uniqueRequests')
        .doc(qualificationId)
        .get();
    Map<String, dynamic> qualificationData =
        qualificationRequestDoc.data() as Map<String, dynamic>;

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

      return true;
    } catch (e) {
      print('Error creating certificate document: $e');
      return false;
    }
  }

  Future<bool> rejectQualification(String qualificationId, String userId) async {
    FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    await firestore
        .collection('qualificationRequests')
        .doc('requested')
        .collection('uniqueRequests')
        .doc(qualificationId)
        .update({
      'status': 'rejected',
    });

    DocumentSnapshot qualificationRequestDoc = await firestore
        .collection('qualificationRequests')
        .doc('requested')
        .collection('uniqueRequests')
        .doc(qualificationId)
        .get();
    Map<String, dynamic> qualificationData =
        qualificationRequestDoc.data() as Map<String, dynamic>;

    try {
      await firestore
          .collection('qualificationRequests')
          .doc('rejectedCertificates')
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
      
      return true;

    }catch (e){
      print('Error creating certificate document: $e');
      return false;
    }
  }

  @override
  void onClose() {
    qualifications.clear();
  }
}

