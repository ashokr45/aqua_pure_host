import 'package:aqua_pure/common/QAppBar.dart';
import 'package:aqua_pure/common/sideMenu.dart';
import 'package:aqua_pure/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AddPurifierPage extends StatefulWidget {
  @override
  _AddPurifierPageState createState() => _AddPurifierPageState();
}

class _AddPurifierPageState extends State<AddPurifierPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController _searchController = TextEditingController();
  TextEditingController _modelController = TextEditingController();
  TextEditingController _serialController = TextEditingController();
  TextEditingController _manufacturerDateController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  List<bool> _configSelections = List.generate(10, (index) => false);
  List<bool> _roleSelections = List.generate(5, (index) => false);

  final List<String> _configItems =
      List.generate(10, (index) => "Configuration Item ${index + 1}");
  final List<String> _roleItems = [
    "Admin",
    "Technician",
    "Operator",
    "Viewer",
    "Guest"
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: [
            Tab(text: "Purifier Details"),
            Tab(text: "Purifier Configurations"),
            Tab(text: "User Role"),
          ],
        ),
        title: Text("Add purifier",
            style: TextStyle(color: Colors.black, fontSize: 20)),
        centerTitle: true,
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: Icon(
            Iconsax.menu_1,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Icon(Iconsax.user, color: Colors.black),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(Iconsax.notification, color: Colors.black),
          ),
        ],
      ),
      drawer: sideMenu(),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPurifierDetailsTab(),
          _buildPurifierConfigurationsTab(),
          _buildUserRoleTab(),
        ],
      ),
    );
  }

  Widget _buildPurifierDetailsTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildTextField("Model Number", _modelController),
          SizedBox(height: 12),
          _buildTextField("Serial Number", _serialController),
          SizedBox(height: 12),
          _buildTextField("Manufacturer Date", _manufacturerDateController),
          SizedBox(height: 12),
          _buildTextField("Location", _locationController),
          Spacer(),
          _buildProceedButton(),
        ],
      ),
    );
  }

  Widget _buildPurifierConfigurationsTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Select Variants",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Expanded(
            child: ListView.builder(
              itemCount: _configItems.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(_configItems[index]),
                  value: _configSelections[index],
                  onChanged: (bool? value) {
                    setState(() {
                      _configSelections[index] = value!;
                    });
                  },
                );
              },
            ),
          ),
          _buildProceedButton(),
        ],
      ),
    );
  }

  Widget _buildUserRoleTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Select User Role",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          _buildSearchBar(),
          Expanded(
            child: ListView.builder(
              itemCount: _roleItems.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(_roleItems[index]),
                  value: _roleSelections[index],
                  onChanged: (bool? value) {
                    setState(() {
                      _roleSelections[index] = value!;
                    });
                  },
                );
              },
            ),
          ),
          _buildProceedButton(),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search...',
        prefixIcon: Icon(Iconsax.search_normal, color: Colors.green),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildProceedButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF0267FF),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text("Proceed"),
      ),
    );
  }
}
