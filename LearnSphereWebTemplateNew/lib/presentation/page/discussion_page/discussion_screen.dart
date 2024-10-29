import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'create_discussion_page.dart'; // Import the CreateDiscussionPage

class DiscussionPage extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

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
      showAlertDialog(context, 'Success', 'Discussion room deleted successfully!');
    } catch (e) {
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
