import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';


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
          const SnackBar(content: Text('Staff added successfully')),
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
      backgroundColor: Colors.transparent,
  body: Stack(
    children: [
      Padding(
        padding: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'User List',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 16),
              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Search by username',
                  labelStyle: TextStyle(color: Colors.white),
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
                              fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
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
                          items: ['All', 'user', 'admin', 'staff']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: const TextStyle(color: Colors.white)),
                            );
                          }).toList(),
                          dropdownColor: Colors.transparent.withOpacity(0.5),
                        ),
                      ],
                    ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical, // Enable vertical scrolling
                      child: Container(
                        padding: const EdgeInsets.all(16.0), // Consistent padding
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.13),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('Username', style: TextStyle(color: Colors.white))),
                            DataColumn(label: Text('Role', style: TextStyle(color: Colors.white))),
                            DataColumn(label: Text('UID', style: TextStyle(color: Colors.white))),
                            DataColumn(label: Text('Email', style: TextStyle(color: Colors.white))),
                            DataColumn(label: Text('Actions', style: TextStyle(color: Colors.white))),
                          ],
                          rows: _filteredUsers.map((userDoc) {
                            final user = userDoc.data() as Map<String, dynamic>;
                            return DataRow(cells: [
                              DataCell(Text(user['username'] ?? 'Unknown', style: TextStyle(color: Colors.white))),
                              DataCell(Text(user['role'] ?? 'Unknown', style: TextStyle(color: Colors.white))),
                              DataCell(Text(user['uid'] ?? 'Unknown', style: TextStyle(color: Colors.white))),
                              DataCell(Text(user['email'] ?? 'Unknown', style: TextStyle(color: Colors.white))),
                              DataCell(_buildActionDropdown(context, userDoc)),
                            ]);
                          }).toList(),
                        ),
                      ),
                    ),
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
    backgroundColor: const Color(0xFF117aca),
    foregroundColor: Colors.white,
    onPressed: _addStaff,
    tooltip: 'Add Staff',
    child: const Icon(Icons.add),
  ),
);

  }

//DROPDDOWN
Widget _buildActionDropdown(BuildContext context, DocumentSnapshot userDoc) {
  final user = userDoc.data() as Map<String, dynamic>;
  bool canEdit = false;
  

  if (_currentUserRole == 'admin') {
  // Admins can always edit
  canEdit = true;
} else if (_currentUserRole == 'staff') {
  if (user['uid'] == _auth.currentUser?.uid) {
    // Staff can edit their own profile
    canEdit = true;
  } else if (user['role'] == 'user') {
    // Staff can edit other users, but only if the role is 'user'
    canEdit = true;
  }
}

  return PopupMenuButton<String>(
    iconColor: Colors.white,
    onSelected: (String value) {
      switch (value) {
        case 'View Details':
          _viewUserDetails(context, userDoc);
          break;
        case 'Edit Profile':
          if (canEdit) {
            _editUserProfile(context, userDoc);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('You can only edit your own profile.')),
            );
          }
          break;
        case 'Change Role':
          // Allow both admin and staff to change roles
          _changeUserRole(context, userDoc);
          break;
       
       
      }
    },
    itemBuilder: (BuildContext context) {
      return <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'View Details',
          child: Text('View Details'),
        ),
        if (canEdit) // Allow editing the profile if allowed
          const PopupMenuItem<String>(
            value: 'Edit Profile',
            child: Text('Edit Profile'),
          ),
        // Show Change Role for both admin and staff
        const PopupMenuItem<String>(
          value: 'Change Role',
          child: Text('Change Role'),
        ),
        
      ];
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

 

 //VIEW USER
  void _viewUserDetails(BuildContext context, DocumentSnapshot userDoc){
    final user = userDoc.data() as Map<String, dynamic>;

    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          backgroundColor: Colors.black.withOpacity(0.8),
          title: const Text('Details', style: TextStyle(color: Colors.white),),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Username: ${user['username']}', style: TextStyle(color: Colors.white),),
                Text('Email: ${user['email']}', style: TextStyle(color: Colors.white),),
                Text('Role: ${user['role']}', style: TextStyle(color: Colors.white),),
                Text('UID: ${user['uid']}', style: TextStyle(color: Colors.white),),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed:() => Navigator.pop(context), 
              child: const Text('Close', style: TextStyle(color: Color(0xFF117aca)),),
            ),
          ],
        );
      },
    );
  }

  //EDIT
  void _editUserProfile(BuildContext context, DocumentSnapshot userDoc) {
  final user = userDoc.data() as Map<String, dynamic>;
  String updatedEmail = user['email'];
  String updatedUsername = user['username'];

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.black.withOpacity(0.8),
        title: const Text('Edit Profile', style: TextStyle(color: Colors.white),),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              style: const TextStyle(color: Colors.white),
              controller: TextEditingController(text: user['username']),
              decoration: const InputDecoration(labelText: 'Username',),
              onChanged: (value) {
                updatedUsername = value;
              },
            ),
            TextField(
              style: const TextStyle(color: Colors.white),
              controller: TextEditingController(text: user['email']),
              decoration: const InputDecoration(labelText: 'Email'),
              onChanged: (value) {
                updatedEmail = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Color(0xFF117aca)),),
          ),
          TextButton(
            onPressed: () async {
              try {
                await userDoc.reference.update({
                  'email': updatedEmail,
                  'username': updatedUsername,
                });
                Navigator.pop(context);
                _fetchUsers(); // Refresh the list after editing profile
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile updated successfully')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to update profile: $e')),
                );
              }
            },
            child: const Text('Save', style: TextStyle(color: Color(0xFF117aca)),),
          ),
        ],
      );
    },
  );
}



}