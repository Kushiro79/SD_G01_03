import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

@RoutePage()
class ViewAndManageUsersPage extends StatefulWidget {
  const ViewAndManageUsersPage({super.key});
  @override
  _ViewAndUserManagementState createState() => _ViewAndUserManagementState();
}

class _ViewAndUserManagementState extends State<ViewAndManageUsersPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Map<String, dynamic> _usersMap = {}; // Maps userId to username and roles

  List<DocumentSnapshot> _users = [];
  List<DocumentSnapshot> _filteredUsers = [];

  String searchQuery = '';
  String selectedRole = 'All';

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }
 String _currentUserRole = '';
  Future<void> _fetchUsers() async {
   
    final userId = _auth.currentUser?.uid;
    if (userId != null) {
      final userDoc = await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        _currentUserRole = userDoc.data()?['role'];
      }
    }

    // Fetch users from Firestore, filtered by the current user's role
    final snapshot = await _firestore
        .collection('users')
        .where('role',
            whereIn: _currentUserRole == 'admin'
                ? ['user', 'staff', 'admin']
                : _currentUserRole == 'staff'
                    ? ['user']
                    : ['user'])
        .get();
    setState(() {
      _users = snapshot.docs;
      _filteredUsers = _users;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User List',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // Search Bar
            TextField(
              decoration: InputDecoration(
                labelText: 'Search by username',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                  _filterUsers();
                });
              },
            ),
            SizedBox(height: 16),
            // Filter by Role
            _currentUserRole == 'staff'
                ? Container()
                : Row(
                    children: [
                      Text(
                        'Filter by role:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 16),
                      DropdownButton<String>(
                        value: selectedRole,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedRole = newValue!;
                            _filterUsers();
                          });
                        },
                        items: ['All', 'user', 'admin', 'staff']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
            SizedBox(height: 16),
            // User List
            Expanded(
              child: ListView.builder(
                itemCount: _filteredUsers.length,
                itemBuilder: (context, index) {
                  final userDoc = _filteredUsers[index];
                  final user = userDoc.data() as Map<String, dynamic>;
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(user['username'] ?? 'Unknown'),
                      subtitle: Text('${user['role']}\n' +
                          'UID: ${user['uid']}\n'),
                      trailing: _buildActionDropdown(context, userDoc),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
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
          
        }
      },
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: 'Edit',
            child: Text('Edit'),
          ),
          PopupMenuItem<String>(
            value: 'Change Role',
            child: Text('Change Role'),
          ),
         
          
        ];
      },
    );
  }

  void _editUser(BuildContext context, DocumentSnapshot userDoc) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Edit ${userDoc['username']}')),
    );
  }

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
        _fetchUsers();
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(' ${userDoc['username']} is now a $newRole')),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }


  
    
  
}

