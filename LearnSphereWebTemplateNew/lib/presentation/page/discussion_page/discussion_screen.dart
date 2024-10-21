import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'create_discussion_page.dart'; // Import the CreateDiscussionPage

class DiscussionPage extends StatelessWidget {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discussion Rooms'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to the CreateDiscussionPage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateDiscussionPage()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('discussions').orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final discussions = snapshot.data?.docs;

          return ListView.builder(
            itemCount: discussions?.length ?? 0,
            itemBuilder: (context, index) {
              final discussion = discussions![index];
              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(discussion['title']),
                  subtitle: Text(discussion['content']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Implement joining the discussion room logic here
                          joinDiscussionRoom(discussion['title']);
                        },
                        child: Text('Join'),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // Show a confirmation dialog before deletion
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
    );
  }

  void joinDiscussionRoom(String roomName) {
    // Implement the logic to join the discussion room
    print('Joined $roomName');
  }

  // Function to display the confirmation dialog before deleting
  void showDeleteConfirmationDialog(BuildContext context, String discussionId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Discussion'),
          content: Text('Are you sure you want to delete this discussion?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                deleteDiscussionRoom(discussionId, context); // Call delete function
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  // Function to delete the discussion room and show AlertDialog for success or error
  Future<void> deleteDiscussionRoom(String discussionId, BuildContext context) async {
    try {
      await firestore.collection('discussions').doc(discussionId).delete();
      print('Deleted discussion room with ID: $discussionId');
      
      // Show success dialog
      showAlertDialog(context, 'Success', 'Discussion room deleted successfully!');
    } catch (e) {
      print('Error deleting discussion room: $e');
      
      // Show error dialog
      showAlertDialog(context, 'Error', 'Failed to delete discussion room.');
    }
  }

  // Function to display AlertDialog for success or error messages
  void showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the alert dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
