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
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        setState(() {
          username = userDoc['username']; // Retrieve username from Firestore
        });
      }
    }
  }

  Future<void> _getRoomTitle() async {
    try {
      DocumentSnapshot roomDoc =
          await firestore.collection('discussions').doc(widget.roomId).get();
      if (roomDoc.exists) {
        setState(() {
          roomTitle =
              roomDoc['title']; // Assuming title is a field in the document
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
        iconTheme: const IconThemeData(color: Colors.white), // Set back arrow icon to white
        title: Text(roomTitle ?? 'Loading...', style: const TextStyle(color: Colors.white),), // Display the room title
        backgroundColor: const Color(0xFF1A1F3B), // Display the roomId
      ),
      body: Container(
        decoration: const BoxDecoration(color: Color(0xFF1A1F3B)),
        child: Column(
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
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final messages = snapshot.data?.docs;

                  return ListView.builder(
                    itemCount: messages?.length ?? 0,
                    itemBuilder: (context, index) {
                      final message = messages![index];
                      final bool isSender = message['sender'] == username;

                      // Get the timestamp and format it
                      Timestamp? timestamp = message['timestamp'];
                      String formattedTime = timestamp != null
                          ? DateFormat('yyyy-MM-dd – kk:mm')
                              .format(timestamp.toDate())
                          : 'Unknown time';

                      return Align(
                        alignment: isSender
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                            color: isSender
                                ? const Color(0xFF117aca)
                                : Color.fromARGB(255, 33, 38, 46),
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(15),
                              topRight: const Radius.circular(15),
                              bottomLeft: isSender
                                  ? const Radius.circular(15)
                                  : const Radius.circular(0),
                              bottomRight: isSender
                                  ? const Radius.circular(0)
                                  : const Radius.circular(15),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: isSender
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Text(
                                message['sender'],
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: isSender
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      message['text'],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  if (!isSender) // Show report icon only for received messages
                                    IconButton(
                                      icon: const Icon(
                                        Icons.report_problem,
                                        color: Colors.redAccent,
                                      ),
                                      onPressed: () {
                                        reportMessage(message
                                            .id); // Pass the message ID to report
                                      },
                                    ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Align(
                                alignment: isSender
                                    ? Alignment.bottomLeft
                                    : Alignment.bottomRight,
                                child: Text(
                                  formattedTime,
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.white54),
                                ),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                          hintText: 'Enter your message',
                          hintStyle: TextStyle(color: Colors.white54)),
                    ),
                  ),
                  IconButton(
                    icon: isSending
                        ? const CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white))
                        : const Icon(Icons.send, color: Colors.white),
                    onPressed: isSending
                        ? null
                        : () {
                            sendMessage();
                          },
                  ),
                ],
              ),
            ),
          ],
        ),
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
            .collection('discussion_group')
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
        SnackBar(
            content:
                Text('Please enter a message and ensure you are logged in.')),
      );
    }
  }

  void reportMessage(String messageId) async {
    String? reason = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        TextEditingController reasonController = TextEditingController();
        return AlertDialog(
          backgroundColor:  Colors.black,
          title: const Text('Report Message', style: TextStyle(color: Colors.white)),
          content: TextField(
            controller: reasonController,
            decoration:
                const InputDecoration(hintText: 'Enter the reason for reporting', hintStyle: TextStyle(color: Colors.white54)),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Submit', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context)
                    .pop(reasonController.text); // Return the reason
              },
            ),
            TextButton(
              child: const Text('Cancel' , style: TextStyle(color: Colors.white)),
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
