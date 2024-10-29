
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'create_discussion_page.dart'; // Import the CreateDiscussionPage
import 'package:firebase_auth/firebase_auth.dart';

class DiscussionPage extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87, // Match header color to page color
        iconTheme: IconThemeData(color: Colors.white), // Set back arrow icon to white
        title: Text(
          'Discussion Rooms',
          style: TextStyle(color: Colors.white), // Set title font to white
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white), // Set icon color to white
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateDiscussionPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0), // Add padding between header and content
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection('discussions').orderBy('createdAt', descending: true).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.white)));
            }

            final discussions = snapshot.data?.docs;

            return ListView.builder(
              itemCount: discussions?.length ?? 0,
              itemBuilder: (context, index) {
                final discussion = discussions![index];
                return Card(
                  color: Colors.grey[800], // Optional: Darken card background
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      discussion['title'],
                      style: TextStyle(color: Colors.white), // White title font
                    ),
                    subtitle: Text(
                      discussion['content'],
                      style: TextStyle(color: Colors.white70), // White subtitle font with slight opacity
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan, // Set button color to cyan
                            foregroundColor: Colors.white, // Keep text color white
                          ),
                          onPressed: () {
                            joinDiscussionRoom(discussion['title']);
                          },
                          child: Text('Join'),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            showDeleteConfirmationDialog(context, discussion.id);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void joinDiscussionRoom(String roomName) {
    print('Joined $roomName');
  }

  void showDeleteConfirmationDialog(BuildContext context, String discussionId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black87,
          title: Text('Delete Discussion', style: TextStyle(color: Colors.white)),
          content: Text('Are you sure you want to delete this discussion?', style: TextStyle(color: Colors.white70)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                deleteDiscussionRoom(discussionId, context);
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }


Future<void> deleteDiscussionRoom(String discussionId, BuildContext context) async {
    try {
      await firestore.collection('discussions').doc(discussionId).delete();
      print('Deleted discussion room with ID: $discussionId');
      showAlertDialog(context, 'Success', 'Discussion room deleted successfully!');
    } catch (e) {
      print('Error deleting discussion room: $e');
      showAlertDialog(context, 'Error', 'Failed to delete discussion room.');
    }
  }
//---------------REPORT ENTIRE ROOM------------------------------------------------------
  void showReportConfirmationDialog(BuildContext context, String discussionId) {
    TextEditingController reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Report Discussion'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Please provide a reason for reporting this discussion:'),
              TextField(
                controller: reasonController,
                decoration: InputDecoration(hintText: 'Enter reason here'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                reportDiscussion(discussionId, reasonController.text.trim(), context);
              },
              child: Text('Report', style: TextStyle(color: Colors.orange)),
            ),
          ],
        );
      },
    );
  }

Future<void> reportDiscussion(String discussionId, String reason, BuildContext context) async {
  // Check if the reason is empty and show an error dialog if it is
  if (reason.isEmpty) {
    showAlertDialog(context, 'Error', 'Please enter a reason for reporting the discussion.');
    return;
  }

  // Get the current user's UID
  final User? currentUser = auth.currentUser;

  if (currentUser == null) {
    showAlertDialog(context, 'Error', 'You must be logged in to report a discussion.');
    return;
  }

  String username = 'Unknown User';

  try {
    // Fetch the user's document from the Firestore collection
    DocumentSnapshot userDoc = await firestore.collection('users').doc(currentUser.uid).get();
    Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?; 
    username = userData?['username'] ?? 'Unknown User'; 
  } catch (e) {
    // Show error dialog if fetching user data fails
    if (context.mounted) {  // Check if the widget is still mounted
      showAlertDialog(context, 'Error', 'Failed to retrieve user data.');
    }
    return;
  }

  // Check if the username is not empty
  if (username.isNotEmpty) {
    try {
      await firestore.collection('report_discussion').add({
        'discussionId': discussionId,
        'reportedAt': DateTime.now(),
        'reason': reason,
        'reportedBy': username,
      });

      // Show success message using showAlertDialog
      if (context.mounted) {  // Check if the widget is still mounted
        showAlertDialog(context, 'Success', 'Discussion room reported successfully!');
      }
    } catch (e) {
      // Show error dialog in case of failure
      if (context.mounted) {  // Check if the widget is still mounted
        showAlertDialog(context, 'Error', 'Failed to report discussion room.');
      }
    }
  } else {
    // Show error dialog if username is empty
    if (context.mounted) {  // Check if the widget is still mounted
      showAlertDialog(context, 'Error', 'Failed to retrieve username for reporting.');
    }
  }
}

void showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black87,
          title: Text(title, style: TextStyle(color: Colors.white)),
          content: Text(message, style: TextStyle(color: Colors.white70)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }


}