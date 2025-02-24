import 'package:aqua_pure/common/sideMenu.dart';
import 'package:aqua_pure/getx_controllers/userMangementController.dart';
import 'package:aqua_pure/models/user_model.dart';
import 'package:aqua_pure/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class UserManagementDesktop extends StatefulWidget {
  const UserManagementDesktop({Key? key}) : super(key: key);

  @override
  _UserManagementDesktopState createState() => _UserManagementDesktopState();
}

class _UserManagementDesktopState extends State<UserManagementDesktop> {
  final UserController userController = Get.put(UserController());
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
        _sortDirection == DataGridSortDirection.ascending
            ? Icons.arrow_upward
            : Icons.arrow_downward,
        color: Colors.white,
        size: 16,
      );
    }
    return Icon(Icons.sort, color: Colors.white, size: 16);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.withOpacity(0.3),
      body: Row(
        children: [
          Container(
            width: 250,
            child: sideMenu(),
          ),
          Expanded(
            child: Column(
              children: [
                AppBar(
                  backgroundColor: TColors.textWhite,
                  title: Text(
                    "USER MANAGEMENT",
                    style: GoogleFonts.inknutAntiqua().copyWith(
                      color: TColors.textBlack,
                      fontSize: 25,
                    ),
                  ),
                  centerTitle: false,
                  toolbarHeight: 90,
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.notifications),
                      onPressed: () {},
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 300,
                        height: 50,
                        child: TextField(
                          onChanged: (value) {
                            userController.updateSearchQuery(value);
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Search by name, username or role...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 150,
                        height: 45,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => AddUserDialog(),
                            );
                          },
                          icon: Icon(Icons.add, color: Colors.white),
                          label: Text('Add User', style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SfDataGrid(
                        source: dataSource,
                        columnWidthMode: ColumnWidthMode.fill,
                        columns: <GridColumn>[
                          GridColumn(
                            columnName: 'id',
                            label: Container(
                              padding: EdgeInsets.all(16.0),
                              alignment: Alignment.center,
                              color: TColors.button,
                              child: Text('ID', style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          GridColumn(
                            columnName: 'name',
                            label: Container(
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              color: TColors.button,
                              child: InkWell(
                                onTap: () {
                                  _handleSort('name');
                                },
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
                            label: Container(
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              color: TColors.button,
                              child: InkWell(
                                onTap: () {
                                  _handleSort('username');
                                },
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
                            label: Container(
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              color: TColors.button,
                              child: InkWell(
                                onTap: () {
                                  _handleSort('role');
                                },
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
                            label: Container(
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              color: TColors.button,
                              child: InkWell(
                                onTap: () {
                                  _handleSort('numberOfSystems');
                                },
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
                            label: Container(
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              color: TColors.button,
                              child: InkWell(
                                onTap: () {
                                  _handleSort('location');
                                },
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
                            label: Container(
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              color: TColors.button,
                              child: InkWell(
                                onTap: () {
                                  _handleSort('status');
                                },
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
                            label: Container(
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              color: TColors.button,
                              child: Text('Action', style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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



class AddUserDialog extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController numberOfSystemsController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController statusController = TextEditingController();

  final UserController userController = Get.find<UserController>();

  // Define the list of role options.
  final List<String> roleOptions = [
    "Pure aqua engineer",
    "dealer",
    "admin",
    "supervisor",
    "operator"
  ];

  AddUserDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use StatefulBuilder to manage the dropdown selection for role locally.
    return StatefulBuilder(
      builder: (context, setState) {
        String? selectedRole;
        return AlertDialog(
          title: Text(
            "Add User",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          content: Container(
            width: 600, // Fixed width for a desktop-friendly layout
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  SizedBox(
                    width: 280,
                    child: TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: "Username",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 280,
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: "Name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 280,
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 280,
                    child: TextField(
                      controller: contactController,
                      decoration: InputDecoration(
                        labelText: "Contact Number",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 280,
                    child: TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                  ),
                  SizedBox(
                    width: 280,
                    child: TextField(
                      controller: numberOfSystemsController,
                      decoration: InputDecoration(
                        labelText: "Number of Systems",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    width: 280,
                    child: TextField(
                      controller: locationController,
                      decoration: InputDecoration(
                        labelText: "Location",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  // Replace the role text field with a dropdown.
                  SizedBox(
                    width: 280,
                    child: DropdownButtonFormField<String>(
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
                  ),
                  SizedBox(
                    width: 280,
                    child: TextField(
                      controller: statusController,
                      decoration: InputDecoration(
                        labelText: "Status",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("Cancel", style: TextStyle(color: TColors.textBlack)),
            ),
            ElevatedButton(
              onPressed: () {
                final newUser = UserModel(
                  id: 0, // The backend should assign an ID
                  username: usernameController.text,
                  name: nameController.text,
                  email: emailController.text,
                  contactNumber: contactController.text,
                  password: passwordController.text,
                  numberOfSystems: int.tryParse(numberOfSystemsController.text) ?? 0,
                  location: locationController.text,
                  role: selectedRole ?? "",
                  status: statusController.text,
                );
                userController.addUser(newUser);
              },
              child: Text("Add", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
          ],
        );
      },
    );
  }
}
