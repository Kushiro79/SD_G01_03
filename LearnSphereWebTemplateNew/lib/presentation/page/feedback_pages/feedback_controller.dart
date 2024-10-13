import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewFeedbackController extends GetxController {
  // Observable variable to store the feedback documents
  var feedbackDocs = <QueryDocumentSnapshot>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Listen to the feedback collection stream and update the observable list
    FirebaseFirestore.instance
        .collection('feedbacks')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      feedbackDocs.value = snapshot.docs;
    });
  }
}
