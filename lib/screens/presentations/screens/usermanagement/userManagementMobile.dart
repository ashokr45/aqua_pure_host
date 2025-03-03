import 'package:aqua_pure/common/QAppBar.dart';
import 'package:aqua_pure/common/sideMenu.dart';
import 'package:aqua_pure/getx_controllers/userMangementController.dart';
import 'package:aqua_pure/models/user_model.dart';
import 'package:aqua_pure/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:google_fonts/google_fonts.dart';

class UserManagementMobileScreen extends StatefulWidget {
  const UserManagementMobileScreen({Key? key}) : super(key: key);

  @override
  _UserManagementMobileScreenState createState() => _UserManagementMobileScreenState();
}

class _UserManagementMobileScreenState extends State<UserManagementMobileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final UserController userController = Get.put(UserController());
  final TextEditingController _searchController = TextEditingController();

  String? _sortColumn;
  DataGridSortDirection _sortDirection = DataGridSortDirection.ascending;

  void _handleSort(String columnName) {
    setState(() {
      if (_sortColumn == columnName) {
        _sortDirection = _sortDirection == DataGridSortDirection.ascending
            ? DataGridSortDirection.descending
            : DataGridSortDirection.ascending;
      } else {
        _sortColumn = columnName;
        _sortDirection = DataGridSortDirection.ascending;
      }
    });
  }

  Widget _buildSortIcon(String columnName) {
    if (_sortColumn == columnName) {
      return Icon(
        _sortDirection == DataGridSortDirection.ascending ? Icons.arrow_upward : Icons.arrow_downward,
        color: Colors.white,
        size: 16,
      );
    }
    return Icon(Icons.sort, color: Colors.white, size: 16);
  }

  void _filterUsers(String query) {
    userController.updateSearchQuery(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: QAppBar(
        menuIcon: Iconsax.menu_1,
        onPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        notificationIcon: Iconsax.notification,
        userIcon: Iconsax.user,
        title: 'User Management',
      ),
      drawer: sideMenu(),
      body: SafeArea(
        child: Column(
          children: [
            // **Search and Add User Row**
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: _filterUsers,
                      decoration: InputDecoration(
                        hintText: 'Search by name, username, role or location...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AddUserDialog(),
                      );
                    },
                    icon: Icon(Icons.add, color: Colors.white),
                    label: Text('Add User', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ),
            // **Data Table Display**
            Expanded(
              child: Obx(() {
                if (userController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                final dataSource = UserDataSource(
                  users: userController.filteredUsers,
                  context: context,
                  sortColumn: _sortColumn,
                  sortDirection: _sortDirection,
                );
                return SfDataGrid(
                  source: dataSource,
                  columnWidthMode: ColumnWidthMode.none,
                  columns: <GridColumn>[
                    GridColumn(
                      columnName: 'id',
                      width: 0,
                      label: Container(
                        padding: EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        color: TColors.button,
                        child: Text('ID', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    GridColumn(
                      columnName: 'name',
                      width: 150,
                      label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        color: TColors.button,
                        child: InkWell(
                          onTap: () => _handleSort('name'),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Name', style: TextStyle(color: Colors.white)),
                              _buildSortIcon('name'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'username',
                      width: 150,
                      label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        color: TColors.button,
                        child: InkWell(
                          onTap: () => _handleSort('username'),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Username', style: TextStyle(color: Colors.white)),
                              _buildSortIcon('username'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'role',
                      width: 150,
                      label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        color: TColors.button,
                        child: InkWell(
                          onTap: () => _handleSort('role'),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Role', style: TextStyle(color: Colors.white)),
                              _buildSortIcon('role'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'numberOfSystems',
                      width: 150,
                      label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        color: TColors.button,
                        child: InkWell(
                          onTap: () => _handleSort('numberOfSystems'),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('No. of Systems', style: TextStyle(color: Colors.white)),
                              _buildSortIcon('numberOfSystems'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'location',
                      width: 150,
                      label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        color: TColors.button,
                        child: InkWell(
                          onTap: () => _handleSort('location'),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Location', style: TextStyle(color: Colors.white)),
                              _buildSortIcon('location'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'status',
                      width: 150,
                      label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        color: TColors.button,
                        child: InkWell(
                          onTap: () => _handleSort('status'),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Status', style: TextStyle(color: Colors.white)),
                              _buildSortIcon('status'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'action',
                      width: 130,
                      label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        color: TColors.button,
                        child: Text('Action', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

/// Data Source for SfDataGrid (reused from desktop)
class UserDataSource extends DataGridSource {
  List<DataGridRow> _userData = [];
  final BuildContext context;
  final String? sortColumn;
  final DataGridSortDirection sortDirection;

  UserDataSource({
    required List<UserModel> users,
    required this.context,
    this.sortColumn,
    this.sortDirection = DataGridSortDirection.ascending,
  }) {
    final sortedUsers = _sortUsers(users, sortColumn, sortDirection);
    _userData = sortedUsers
        .map<DataGridRow>((user) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: user.id),
              DataGridCell<String>(columnName: 'name', value: user.name),
              DataGridCell<String>(columnName: 'username', value: user.username),
              DataGridCell<String>(columnName: 'role', value: user.role),
              DataGridCell<int>(columnName: 'numberOfSystems', value: user.numberOfSystems),
              DataGridCell<String>(columnName: 'location', value: user.location),
              DataGridCell<String>(columnName: 'status', value: user.status),
              DataGridCell<Widget>(
                columnName: 'action',
                value: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.green),
                      onPressed: () {
                        // Implement edit functionality if needed.
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        // Implement delete functionality if needed.
                      },
                    ),
                  ],
                ),
              ),
            ]))
        .toList();
  }

  List<UserModel> _sortUsers(
      List<UserModel> users, String? sortColumn, DataGridSortDirection sortDirection) {
    if (sortColumn == null) return users;
    List<UserModel> sorted = List.from(users);
    sorted.sort((a, b) {
      dynamic aValue;
      dynamic bValue;
      switch (sortColumn) {
        case 'name':
          aValue = a.name;
          bValue = b.name;
          break;
        case 'username':
          aValue = a.username;
          bValue = b.username;
          break;
        case 'role':
          aValue = a.role;
          bValue = b.role;
          break;
        case 'numberOfSystems':
          aValue = a.numberOfSystems;
          bValue = b.numberOfSystems;
          break;
        case 'location':
          aValue = a.location;
          bValue = b.location;
          break;
        case 'status':
          aValue = a.status;
          bValue = b.status;
          break;
        default:
          return 0;
      }
      int compareResult;
      if (aValue is String && bValue is String) {
        compareResult = aValue.compareTo(bValue);
      } else if (aValue is int && bValue is int) {
        compareResult = aValue.compareTo(bValue);
      } else {
        compareResult = 0;
      }
      return sortDirection == DataGridSortDirection.ascending ? compareResult : -compareResult;
    });
    return sorted;
  }

  @override
  List<DataGridRow> get rows => _userData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          color: Colors.white,
          child: dataGridCell.value is Widget
              ? dataGridCell.value as Widget
              : Text(
                  dataGridCell.value.toString(),
                  style: TextStyle(color: TColors.textBlack),
                ),
        );
      }).toList(),
    );
  }
}

/// AddUserDialog: Displays a form for adding (or editing) a user.
/// Integrates with the API via UserController's addUser method.
class AddUserDialog extends StatefulWidget {
  // Allow pre-filling values for editing
  final String? username;
  final String? name;
  final String? email;
  final String? contactNumber;
  final int? numberOfSystems;
  final String? location;
  final String? role;
  final String? status;

  AddUserDialog({
    Key? key,
    this.username,
    this.name,
    this.email,
    this.contactNumber,
    this.numberOfSystems,
    this.location,
    this.role,
    this.status,
  }) : super(key: key);

  @override
  _AddUserDialogState createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  int selectedNumberOfSystems = 0;
  String selectedStatus = "active";
  String? selectedRole;
  final List<String> roleOptions = [
    "Pure aqua engineer",
    "dealer",
    "admin",
    "supervisor",
    "operator"
  ];

  final UserController userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    usernameController.text = widget.username ?? '';
    nameController.text = widget.name ?? '';
    emailController.text = widget.email ?? '';
    contactController.text = widget.contactNumber ?? '';
    locationController.text = widget.location ?? '';
    selectedNumberOfSystems = widget.numberOfSystems ?? 0;
    selectedRole = widget.role;
    selectedStatus = widget.status ?? "active";
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.username != null ? "Edit User" : "Add User",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.9, // Mobile friendly width
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Username
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
              // Name
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
              // Email
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
              // Contact Number
              TextField(
                controller: contactController,
                decoration: InputDecoration(
                  labelText: "Contact Number",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
              // Password
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 12),
              // Number of Systems Dropdown
              DropdownButtonFormField<int>(
                decoration: InputDecoration(
                  labelText: "Number of Systems",
                  border: OutlineInputBorder(),
                ),
                value: selectedNumberOfSystems,
                items: List.generate(10, (index) => index)
                    .map((number) => DropdownMenuItem<int>(
                          value: number,
                          child: Text(number.toString()),
                        ))
                    .toList(),
                onChanged: (int? newValue) {
                  setState(() {
                    selectedNumberOfSystems = newValue!;
                  });
                },
              ),
              SizedBox(height: 12),
              // Location
              TextField(
                controller: locationController,
                decoration: InputDecoration(
                  labelText: "Location",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
              // Role Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Role",
                  border: OutlineInputBorder(),
                ),
                value: selectedRole,
                items: roleOptions.map((String role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedRole = newValue;
                  });
                },
              ),
              SizedBox(height: 12),
              // Status Radio Buttons
              Row(
                children: [
                  Radio<String>(
                    value: "active",
                    groupValue: selectedStatus,
                    onChanged: (value) {
                      setState(() {
                        selectedStatus = value!;
                      });
                    },
                  ),
                  Text("Active"),
                  SizedBox(width: 20),
                  Radio<String>(
                    value: "inactive",
                    groupValue: selectedStatus,
                    onChanged: (value) {
                      setState(() {
                        selectedStatus = value!;
                      });
                    },
                  ),
                  Text("Inactive"),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel", style: TextStyle(color: Colors.black)),
        ),
        ElevatedButton(
          onPressed: () {
            final newUser = UserModel(
              id: 0, // Let the backend assign an ID
              username: usernameController.text,
              name: nameController.text,
              email: emailController.text,
              contactNumber: contactController.text,
              password: passwordController.text,
              numberOfSystems: selectedNumberOfSystems,
              location: locationController.text,
              role: selectedRole ?? "",
              status: selectedStatus,
            );
            userController.addUser(newUser);
          },
          child: Text("Add", style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        ),
      ],
    );
  }
}