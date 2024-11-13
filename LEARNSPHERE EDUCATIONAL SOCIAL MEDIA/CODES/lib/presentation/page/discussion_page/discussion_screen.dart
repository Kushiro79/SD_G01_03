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
    var screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF1A1F3B),
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor:
            const Color(0xFF1A1F3B), // Match header color to page color
        iconTheme: const IconThemeData(
            color: Colors.white), // Set back arrow icon to white
        title: const Text(
          'Discussion Rooms',
          style: TextStyle(color: Colors.white), // Set title font to white
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: const Icon(
                Icons.add_rounded,
                color: Colors.white,
                size: 30,
              ), // Set icon color to white
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      insetPadding: MediaQuery.of(context).size.width > 850
                          ? EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.3,
                              vertical: MediaQuery.of(context).size.height * 0.1)
                          :  EdgeInsets.symmetric(
                              horizontal: 15, vertical: MediaQuery.of(context).size.height * 0.1 ),
                      backgroundColor: Colors.transparent,
                      child: CreateDiscussionPage(),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: screenwidth > 850 ? screenwidth * 0.6 : screenwidth * 1,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 16.0), // Add padding between header and content
            child: StreamBuilder<QuerySnapshot>(
              stream: firestore
                  .collection('discussions')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                      child: Text('Error: ${snapshot.error}',
                          style: TextStyle(color: Colors.white)));
                }

                final discussions = snapshot.data?.docs;

                return ListView.builder(
                  itemCount: discussions?.length ?? 0,
                  itemBuilder: (context, index) {
                    final discussion = discussions![index];
                    final discussionId = discussion.id;
                    return Card(
                      color: Colors.transparent.withOpacity(
                          0.13), // Optional: Darken card background
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(
                          discussion['title'],
                          style: const TextStyle(
                              color: Colors.white), // White title font
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              discussion['content'],
                              style: const TextStyle(
                                  color: Colors
                                      .white70), // White subtitle font with slight opacity
                            ),
                            Text(
                              'Created by: ${discussion['createdBy']}',
                              style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize:
                                      10), // White subtitle font with slight opacity
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FutureBuilder<bool>(
                              future: canDeleteDiscussion(discussionId),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SizedBox
                                      .shrink(); // Optionally, a loading indicator
                                }
                                if (snapshot.hasData && snapshot.data == true) {
                                  return IconButton(
                                    icon: Icon(Icons.delete,
                                        color: Colors.redAccent),
                                    onPressed: () {
                                      deleteDiscussionRoom(
                                          discussionId, context);
                                    },
                                  );
                                }
                                return SizedBox
                                    .shrink(); // Hide if user cannot delete
                              },
                            ),
                            // Join button
                            ElevatedButton(
                              onPressed: () {
                                joinDiscussionRoom(context,
                                    discussionId); // Your join function here
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent),
                              child: const Text(
                                'Join',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),

                            // Conditionally display the Trash icon
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void joinDiscussionRoom(BuildContext context, String roomId) {
    print('Joined $roomId');

    // Check if the room has already been joined
    if (!joinedRooms.contains(roomId)) {
      // Show success dialog since it's the first time joining
      showAlertDialog(context, 'Success',
          'You have successfully joined the discussion room.');

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
          title:
              Text('Delete Discussion', style: TextStyle(color: Colors.white)),
          content: Text('Are you sure you want to delete this discussion?',
              style: TextStyle(color: Colors.white70)),
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

  Future<bool> canDeleteDiscussion(String discussionId) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String currentUserId = auth.currentUser!.uid;

    // Fetch the current user's role and username
    DocumentSnapshot userSnapshot =
        await firestore.collection('users').doc(currentUserId).get();
    String userRole = userSnapshot['role'];
    String username = userSnapshot['username'];

    // Fetch the discussion details to check ownership
    DocumentSnapshot discussionSnapshot =
        await firestore.collection('discussions').doc(discussionId).get();
    String createdBy = discussionSnapshot['createdBy'];

    // Allow deletion if user is admin, staff, or creator of the discussion
    return userRole == 'admin' || userRole == 'staff' || createdBy == username;
  }

  Future<void> deleteDiscussionRoom(
      String discussionId, BuildContext context) async {
    final parentContext = context; // Store the parent context

    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      String currentUserId = auth.currentUser!.uid;

      // Fetch the current user's details
      DocumentSnapshot userSnapshot =
          await firestore.collection('users').doc(currentUserId).get();
      String userRole = userSnapshot['role'];
      String username = userSnapshot['username'];

      // Fetch the discussion details to check ownership
      DocumentSnapshot discussionSnapshot =
          await firestore.collection('discussions').doc(discussionId).get();
      String createdBy = discussionSnapshot['createdBy'];
      // Check if the user is allowed to delete (admin, staff, or creator of the discussion)
      if (userRole == 'admin' || userRole == 'staff' || createdBy == username) {
        await firestore.collection('discussions').doc(discussionId).delete();
        print('Deleted discussion room with ID: $discussionId');
        if (parentContext.mounted) {
          showAlertDialog(parentContext, 'Success',
              'Discussion room deleted successfully!');
        }
      } else {
        // Show error if user lacks permission
        if (parentContext.mounted) {
          showAlertDialog(parentContext, 'Error',
              'You do not have permission to delete this discussion.');
        }
      }
    } catch (e) {
      print('Error deleting discussion room: $e');
      showAlertDialog(
          parentContext, 'Error', 'Failed to delete discussion room.');
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
