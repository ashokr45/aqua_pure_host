import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';






class AddUserDialog extends StatefulWidget {
  final String? userName;
  final String? CustomerName;
  final String? email;
  final String? name;
  final String? role;
  final String? Status;
  final String? System;
  final String? Location;

  AddUserDialog({
    this.userName,
    this.email,
    this.name,
    this.role,
    this.Status, this.System, this.Location, this.CustomerName
  });

  @override
  _AddUserDialogState createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _nameController;
  late TextEditingController _passwordController;

  String? _selectedRole;
  String? _selectedStatus;
  String? _selectedSystem;
  String? _selectedLocation;

  final List<String> _roles = ['Pure Aqua User', 'Customer', 'Manager', 'Operator'];
  final List<String> _statuses = ['Active', 'Inactive'];
  final List<String> _system = ['1', '2', '3', '4'];
  final List<String> _location = ['CityName_1', 'CityName_2', 'CityName_3', 'CityName_4'];

  @override
  void initState() {
    super.initState();

    _usernameController = TextEditingController(text: widget.CustomerName);
    _emailController = TextEditingController(text: widget.email);
    _nameController = TextEditingController(text: widget.userName);
    _passwordController = TextEditingController(); // Leave blank for now
    _selectedRole = widget.role;
    _selectedStatus = widget.Status;
    _selectedSystem = widget.System;
    _selectedLocation = widget.Location;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.CustomerName != null ? "Edit User" : "Add User"),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            // User Name Field
            Container(
              width: 400,
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Customer name'),
              ),
            ),
            SizedBox(height: 20),
            // Name Field
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 20),
            // Email Field
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Contact number'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedLocation,
              hint: Text("Select Location"),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLocation = newValue;
                });
              },
              items: _location.map((String location) {
                return DropdownMenuItem<String>(
                  value: location,
                  child: Text(location),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Location', border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedSystem,
              hint: Text("Select System"),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedSystem = newValue;
                });
              },
              items: _system.map((String system) {
                return DropdownMenuItem<String>(
                  value: system,
                  child: Text(system),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'No. of system', border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            // Role Dropdown
            DropdownButtonFormField<String>(
              value: _selectedRole,
              hint: Text("Select Role"),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedRole = newValue;
                });
              },
              items: _roles.map((String role) {
                return DropdownMenuItem<String>(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Role', border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            // Status Dropdown
            // DropdownButtonFormField<String>(
            //   value: _selectedStatus,
            //   hint: Text("Select Status"),
            //   onChanged: (String? newValue) {
            //     setState(() {
            //       _selectedStatus = newValue;
            //     });
            //   },
            //   items: _statuses.map((String status) {
            //     return DropdownMenuItem<String>(
            //       value: status,
            //       child: Text(status),
            //     );
            //   }).toList(),
            //   decoration: InputDecoration(labelText: 'Status', border: OutlineInputBorder()),
            // ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Status", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Row(
                  children: _statuses.map((String status) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Radio<String>(
                          value: status,
                          groupValue: _selectedStatus,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedStatus = newValue;
                            });
                          },
                          activeColor: Colors.green, // Change the color as per your design
                        ),
                        Text(status),
                        SizedBox(width: 10),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),

            SizedBox(height: 10),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            String userName = _usernameController.text;
            String email = _emailController.text;
            String name = _nameController.text;
            String role = _selectedRole ?? 'Customer'; // Default role
            String status = _selectedStatus ?? 'Active'; // Default status
            String System = _selectedSystem ?? '1'; // Default status
            String Location = _selectedLocation ?? 'CityName_1'; // Default status

            print("Updated Details: $userName, $email, $name, $role, $status, $Location, $System");

            // Perform API call or local update logic here
            Navigator.of(context).pop();
          },
          child: Text('Save', style: TextStyle(color: TColors.textWhite),),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }
}


