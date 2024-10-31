import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // Import this package for date formatting
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth

class JoinDiscussionScreen extends StatefulWidget {
  final String roomName;

  JoinDiscussionScreen({Key? key, required this.roomName}) : super(key: key);

  @override
  _JoinDiscussionScreenState createState() => _JoinDiscussionScreenState();
}

class _JoinDiscussionScreenState extends State<JoinDiscussionScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance; // Initialize Firebase Auth
  final TextEditingController _messageController = TextEditingController();
  String? username; // Variable to store the username
  bool isSending = false; // Track sending state

  @override
  void initState() {
    super.initState();
    _getCurrentUserName(); // Call to retrieve the current user's username
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roomName),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firestore
                  .collection('discussions')
                  .doc(widget.roomName)
                  .collection('messages')
                  .orderBy('timestamp')
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
                    
                    // Get the timestamp and check if it's null
                    Timestamp? timestamp = message['timestamp'];
                    String formattedTime = '';

                    if (timestamp != null) {
                      // Format the timestamp only if it is not null
                      formattedTime = DateFormat('yyyy-MM-dd – kk:mm').format(timestamp.toDate());
                    } else {
                      formattedTime = 'Unknown time'; // Handle the null case
                    }

                    return ListTile(
                      title: Text(message['sender']),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute space between elements
                        children: [
                          Expanded(
                            child: Text(
                              message['text'],
                              maxLines: 2, // Limit to 2 lines for better display
                              overflow: TextOverflow.ellipsis, // Ellipsis for overflow
                            ),
                          ),
                          SizedBox(width: 8), // Add some space between message and time
                          Text(
                            formattedTime,
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
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
        await firestore
            .collection('discussions')
            .doc(widget.roomName)
            .collection('messages')
            .add({
          'text': _messageController.text,
          'sender': username, // Use the retrieved username
          'timestamp': FieldValue.serverTimestamp(),
        });

        _messageController.clear();
      } catch (e) {
        // Handle the error appropriately, e.g. show a message to the user
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
}
