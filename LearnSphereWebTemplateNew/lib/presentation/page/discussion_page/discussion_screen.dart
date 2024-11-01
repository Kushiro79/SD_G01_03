
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'create_discussion_page.dart'; // Import the CreateDiscussionPage
import 'package:firebase_auth/firebase_auth.dart';
import 'join_discussion_screen.dart';

class DiscussionPage extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  final Set<String> joinedRooms = {}; // Track joined rooms

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xFF1A1F3B),
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor:const Color(0xFF1A1F3B), // Match header color to page color
        iconTheme: const IconThemeData(color: Colors.white), // Set back arrow icon to white
        title: const Text(
          'Discussion Rooms',
          style: TextStyle(color: Colors.white), // Set title font to white
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: const Icon(Icons.add_rounded, color: Colors.white, size: 30,), // Set icon color to white
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateDiscussionPage()),
                );
              },
            ),
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
                  color: Colors.transparent.withOpacity(0.13), // Optional: Darken card background
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
                            joinDiscussionRoom(context,discussion.id);
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

void joinDiscussionRoom(BuildContext context, String roomId) {
  print('Joined $roomId');

   // Check if the room has already been joined
  if (!joinedRooms.contains(roomId)) {
    // Show success dialog since it's the first time joining
    showAlertDialog(context, 'Success', 'You have successfully joined the discussion room.');

    // Add to the set of joined rooms
    joinedRooms.add(roomId);

    // Delay navigation to allow the user to see the dialog
    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => JoinDiscussionScreen(roomId: roomId),
        ),
      );
    });
  } else {
    // Directly navigate to JoinDiscussionScreen without showing the dialog
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JoinDiscussionScreen(roomId: roomId),
      ),
    );
  }
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