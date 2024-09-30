import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/custom_toast.dart';

@RoutePage()
class ViewAndManageUsersPage extends StatefulWidget {
  const ViewAndManageUsersPage({super.key});
  @override
  ViewAndUserManagementState createState() => ViewAndUserManagementState();
}

class ViewAndUserManagementState extends State<ViewAndManageUsersPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<DocumentSnapshot> _users = [];
  List<DocumentSnapshot> _filteredUsers = [];
  String searchQuery = '';
  String selectedRole = 'All';
  String _currentUserRole = '';

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    final userId = _auth.currentUser?.uid;
    if (userId != null) {
      final userDoc = await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        _currentUserRole = userDoc.data()?['role'];
      }
    }

    final snapshot = await _firestore
        .collection('users')
        .where('role', whereIn: ['user', 'staff', 'admin']).get();

    setState(() {
      _users = snapshot.docs;
      _filterUsers(); // Apply filtering after fetching users
    });
  }

  void _filterUsers() {
    setState(() {
      _filteredUsers = _users.where((userDoc) {
        final user = userDoc.data() as Map<String, dynamic>;
        final matchesSearchQuery = user['username']
                ?.toLowerCase()
                .contains(searchQuery.toLowerCase()) ??
            false;
        final matchesRole =
            selectedRole == 'All' || user['role'] == selectedRole;
        return matchesSearchQuery && matchesRole;
      }).toList();
    });
  }

//ADD staff - only for admin, if staff alert message will pop out
  Future<void> _addStaff() async {
    // Check if the current user is an admin
    if (_currentUserRole != 'admin') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('You do not have permission to add staff.')),
      );
      return; // Exit the method if not an admin
    }

    String email = '';
    String username = '';
    String password = '';

    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Staff'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: (value) {
                  email = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Username'),
                onChanged: (value) {
                  username = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Add'),
            ),
          ],
        );
      },
    );

    if (result == true &&
        email.isNotEmpty &&
        username.isNotEmpty &&
        password.isNotEmpty) {
      try {
        final UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        await _firestore.collection('users').doc(userCredential.user?.uid).set({
          'email': email,
          'username': username,
          'role': 'staff',
          'uid': userCredential.user?.uid,
        });

        _fetchUsers(); // Refresh the list after adding staff
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Staff added successfully')),
        );
      } catch (e) {
        print(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add staff: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(50),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'User List',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Search by username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                        _filterUsers();
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  // Filter by Role
                  _currentUserRole == 'staff'
                      ? Container()
                      : Row(
                          children: [
                            const Text(
                              'Filter by role:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 16),
                            DropdownButton<String>(
                              value: selectedRole,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedRole = newValue!;
                                  _filterUsers(); // Reapply filter on dropdown change
                                });
                              },
                              items: [
                                'All',
                                'user',
                                'admin',
                                'staff'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListView.separated(
                        itemCount: _filteredUsers.length,
                        separatorBuilder: (context, index) =>
                            Divider(color: Colors.grey, thickness: 1.0),
                        itemBuilder: (context, index) {
                          final userDoc = _filteredUsers[index];
                          final user = userDoc.data() as Map<String, dynamic>;
                          return ListTile(
                            title: Text(user['username'] ?? 'Unknown'),
                            subtitle: Text(
                                '${user['role']}\nUID: ${user['uid']}\nEmail: ${user['email']}'),
                            trailing: _buildActionDropdown(context, userDoc),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addStaff,
        tooltip: 'Add Staff',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildActionDropdown(BuildContext context, DocumentSnapshot userDoc) {
    final user = userDoc.data() as Map<String, dynamic>;
    return PopupMenuButton<String>(
      onSelected: (String value) {
        switch (value) {
          case 'Edit':
            _editUser(context, userDoc);
            break;
          case 'Change Role':
            _changeUserRole(context, userDoc);
            break;
          case 'Delete':
            _deleteUser(context, userDoc);
            break;
        }
      },
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'Edit',
            child: Text('Edit'),
          ),
          const PopupMenuItem<String>(
            value: 'Change Role',
            child: Text('Change Role'),
          ),
          const PopupMenuItem<String>(
            value: 'Delete',
            child: Text('Delete'),
          )
        ];
      },
    );
  }

//EDIT -
  void _editUser(BuildContext context, DocumentSnapshot userDoc) {
    String email = userDoc['email'] ?? '';
    String username = userDoc['username'] ?? '';
    final userRole = userDoc['role'];

    // Check if the current user is staff and trying to edit another staff/admin
    if (_currentUserRole == 'staff' &&
        (userRole == 'admin' || userRole == 'staff')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('You do not have permission to edit this user.')),
      );
      return; // Exit the method if staff tries to edit admin or another staff
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Email'),
                controller: TextEditingController(text: email),
                onChanged: (value) {
                  email = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Username'),
                controller: TextEditingController(text: username),
                onChanged: (value) {
                  username = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (email.isNotEmpty && username.isNotEmpty) {
                  try {
                    await userDoc.reference.update({
                      'email': email,
                      'username': username,
                    });
                    Navigator.pop(context); // Close dialog
                    _fetchUsers(); // Refresh user list

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Updated successfully')),
                    );
                  } catch (e) {
                    print(e.toString());
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to update: $e')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Email and username cannot be empty')),
                  );
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

//CHANGE ROLE
  void _changeUserRole(BuildContext context, DocumentSnapshot userDoc) async {
    final userRole = userDoc['role'];

    final newRole = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change Role'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Current Role: $userRole'),
              DropdownButton<String>(
                value: userRole,
                onChanged: (String? newValue) {
                  Navigator.of(context).pop(newValue);
                },
                items: ['user', 'admin', 'staff']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );

    try {
      if (newRole != null && newRole != userRole) {
        await userDoc.reference.update({'role': newRole});
        _fetchUsers(); // Refresh the list after changing role
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${userDoc['username']} is now a $newRole')),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //DELETE -  only admin can delete staff/admin if sign in as staff only can delete regular users.
  void _deleteUser(BuildContext context, DocumentSnapshot userDoc) async {
    final user = userDoc.data() as Map<String, dynamic>;

    // Check if the current user is an admin
    if (_currentUserRole == 'admin' || user['role'] == 'user') {
      final confirmation = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete Role'),
            content: Text(
                'Are you sure you want to delete ${user['username']}? This action cannot be undone.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text('Delete'),
              ),
            ],
          );
        },
      );

      if (confirmation == true) {
        try {
          await userDoc.reference
              .delete(); // Delete the user document from Firestore
          _fetchUsers(); // Refresh the user list after deletion
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Deleted successfully')),
          );
        } catch (e) {
          print(e.toString());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to delete: $e')),
          );
        }
      }
    } else {
      // If the current user is staff and trying to delete an admin or another staff
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('You do not have permission to delete this account.')),
      );
    }
  }
}
