import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:firebase_auth/firebase_auth.dart'; // For Firebase Auth

class JoinDiscussionScreen extends StatefulWidget {
  final String roomId; // Changed from roomName to roomId

  JoinDiscussionScreen({Key? key, required this.roomId}) : super(key: key);

  @override
  _JoinDiscussionScreenState createState() => _JoinDiscussionScreenState();
}

class _JoinDiscussionScreenState extends State<JoinDiscussionScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance; // Initialize Firebase Auth
  final TextEditingController _messageController = TextEditingController();
  String? username; // Variable to store the username
  bool isSending = false; // Track sending state

  String? roomTitle; // Variable to store the room title

  @override
  void initState() {
    super.initState();
    _getCurrentUserName(); // Call to retrieve the current user's username

    _getRoomTitle(); // Call to retrieve the room title
    
  }

  Future<void> _getCurrentUserName() async {
    User? user = auth.currentUser; // Get the current user
    if (user != null) {
      // Fetch user data from Firestore
      DocumentSnapshot userDoc = await firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        setState(() {
          username = userDoc['username']; // Retrieve username from Firestore
        });
      }
    }
  }

 Future<void> _getRoomTitle() async {
    try {
      DocumentSnapshot roomDoc = await firestore.collection('discussions').doc(widget.roomId).get();
      if (roomDoc.exists) {
        setState(() {
          roomTitle = roomDoc['title']; // Assuming title is a field in the document
        });
        print('Room title fetched: $roomTitle'); // Debug print
      } else {
        print('Room document does not exist for ID: ${widget.roomId}');
      }
    } catch (e) {
      print('Error fetching room title: $e'); // Print any error that occurs
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(roomTitle ?? 'Loading...'), // Display the roomId
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firestore
                  .collection('discussion_group')
                  .doc(widget.roomId)
                  .collection('messages') // Access the messages subcollection
                  .orderBy('timestamp') // Order messages by timestamp
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final messages = snapshot.data?.docs;

                return ListView.builder(
                  itemCount: messages?.length ?? 0,
                  itemBuilder: (context, index) {
                    final message = messages![index];

                    // Get the timestamp and format it
                    Timestamp? timestamp = message['timestamp'];
                    String formattedTime = timestamp != null
                        ? DateFormat('yyyy-MM-dd – kk:mm').format(timestamp.toDate())
                        : 'Unknown time'; // Handle the null case

                    return ListTile(
                      title: Text(message['sender']),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              message['text'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            formattedTime,
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),

                       trailing: IconButton(
                        icon: Icon(Icons.report_problem),
                        onPressed: () {
                          reportMessage(message.id); // Pass the message ID to report
                        },
                      ),


                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(hintText: 'Enter your message'),
                  ),
                ),
                IconButton(
                  icon: isSending 
                      ? CircularProgressIndicator(strokeWidth: 2) 
                      : Icon(Icons.send),
                  onPressed: isSending ? null : () {
                    sendMessage();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void sendMessage() async {
    if (_messageController.text.isNotEmpty && username != null) {
      setState(() {
        isSending = true; // Set sending state to true
      });

      try {
        await firestore.collection('discussion_group')
            .doc(widget.roomId) // Specify the room document
            .collection('messages') // Access the messages subcollection
            .add({
          'sender': username, // Use the retrieved username
          'text': _messageController.text,
          'timestamp': FieldValue.serverTimestamp(),
        });

        _messageController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error sending message: $e')),
        );
      } finally {
        setState(() {
          isSending = false; // Reset sending state
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a message and ensure you are logged in.')),
      );
    }
  }





  void reportMessage(String messageId) async {
    String? reason = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        TextEditingController reasonController = TextEditingController();
        return AlertDialog(
          title: Text('Report Message'),
          content: TextField(
            controller: reasonController,
            decoration: InputDecoration(hintText: 'Enter the reason for reporting'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                Navigator.of(context).pop(reasonController.text); // Return the reason
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog without action
              },
            ),
          ],
        );
      },
    );

    if (reason != null && reason.isNotEmpty) {
      // Add the report to the report_discussion collection
      await firestore.collection('report_discussion').add({
        'messageId': messageId,
        'reason': reason,
        'reportedAt': FieldValue.serverTimestamp(),
        'username': username, // Capture the user ID of the reporter
        'roomId': widget.roomId, // Optionally store the room ID for context
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Report submitted successfully!')),
      );
    }
  }

}
