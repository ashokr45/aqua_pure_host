import 'package:aqua_pure/getx_controllers/purifier_controller.dart';
import 'package:aqua_pure/models/purifier_model.dart';
import 'package:flutter/material.dart';
import 'package:aqua_pure/utils/constants/colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../common/QContainerSquare.dart';
import '../../../../common/sideMenu.dart';


class DashboardDesktop extends StatefulWidget {
  const DashboardDesktop({super.key});

  @override
  State<DashboardDesktop> createState() => _DashboardDesktopState();
}

class _DashboardDesktopState extends State<DashboardDesktop> {
  // Dynamic Purifier Dropdown value (e.g., using sales order number as string)
  String? selectedValue;

  // New Dropdowns for Continent, Country and City remain as-is.
  String? selectedContinent;
  final List<String> continentOptions = ['Asia', 'Europe', 'Africa', 'Americas'];

  String? selectedCountry;
  final List<String> countryOptions = ['India', 'Germany', 'Egypt', 'USA'];

  String? selectedCity;
  final List<String> cityOptions = ['Mumbai', 'Berlin', 'Cairo', 'New York'];

  late PurifierDataSource purifierDataSource;
  // This list is not used directly now because we rely on the controller
  List<Purifier> purifierList = [];

  // Instantiate the PurifierController to fetch data from the API.
  final PurifierController purifierController = Get.put(PurifierController());

  @override
  void initState() {
    super.initState();
    // Initially assign an empty list to the data source.
    purifierDataSource = PurifierDataSource(purifierData: purifierList);
  }

  // Helper method to build dropdowns for filters.
  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> options,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButton<String>(
      value: value,
      hint: Text(
        hint,
        style: TextStyle(color: TColors.textBlack, fontSize: 16),
      ),
      isExpanded: true,
      items: options.map((String option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: onChanged,
      dropdownColor: TColors.textWhite,
      style: TextStyle(color: TColors.textBlack, fontSize: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.withOpacity(0.3),
      body: Stack(
        children: [
          Row(
            children: [
              Container(
                width: 250,
                child: sideMenu(),
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, screenSize) {
                    // Fixed dimensions for QContainer widgets.
                    const double containerWidth = 214;
                    const double containerHeight = 159;
                    return Column(
                      children: [
                        AppBar(
                          backgroundColor: TColors.textWhite,
                          title: Text(
                            "DASHBOARD",
                            style: GoogleFonts.inknutAntiqua().copyWith(
                              color: TColors.textBlack,
                              fontSize: 25,
                            ),
                          ),
                          centerTitle: false,
                          toolbarHeight: 90,
                          actions: [
                            // Dynamic dropdown using API data.
                            Padding(
                              padding: const EdgeInsets.only(right: 650.0),
                              child: Obx(() {
                                if (purifierController.isLoading.value) {
                                  return const CircularProgressIndicator();
                                } else if (purifierController.filteredPurifierList.isEmpty) {
                                  return Text("No Purifiers", style: TextStyle(color: TColors.textBlack, fontSize: 18));
                                } else {
                                  return DropdownButton<String>(
                                    value: selectedValue,
                                    hint: Text(
                                      "Select Purifier",
                                      style: TextStyle(color: TColors.textBlack, fontSize: 18),
                                    ),
                                    items: purifierController.filteredPurifierList.map((Purifier purifier) {
                                      // Here, we use the salesOrderNumber as the value.
                                      return DropdownMenuItem<String>(
                                        value: purifier.salesOrderNumber.toString(),
                                        child: Text(
                                          "PURIFIER ${purifier.salesOrderNumber}",
                                          style: TextStyle(color: TColors.textBlack, fontSize: 18),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedValue = newValue;
                                      });
                                    },
                                    dropdownColor: TColors.textWhite,
                                    style: TextStyle(color: TColors.textBlack, fontSize: 18),
                                  );
                                }
                              }),
                            ),
                            IconButton(
                              icon: const Icon(Iconsax.notification),
                              onPressed: () {
                                // Add your notification functionality here.
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: screenSize.maxHeight * 0.03),
                        // Row of QContainer widgets.
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Navigate to Purifier Manager if needed.
                              },
                              child: QContainer(
                                titleText: "05\nPurifiers",
                                activeText: "03 Active",
                                inactiveText: "02 Inactive",
                                moreInfoText: "More info",
                                titleIcon: Iconsax.box,
                                moreInfoIcon: Iconsax.direct_right,
                                startColor: const Color(0xFF0D4456),
                                endColor: const Color(0xFF1D95BC),
                                dividerColor: Colors.white,
                                width: containerWidth,
                                height: containerHeight,
                              ),
                            ),
                            QContainer(
                              titleText: "Main\nInterface",
                              activeText: "",
                              inactiveText: "",
                              moreInfoText: "More info",
                              titleIcon: Iconsax.menu_board4,
                              moreInfoIcon: Iconsax.direct_right,
                              startColor: const Color(0xFF4B1D0A),
                              endColor: const Color(0xFFC75829),
                              dividerColor: Colors.white,
                              width: containerWidth,
                              height: containerHeight,
                            ),
                            QContainer(
                              titleText: "34\nWarning",
                              activeText: "",
                              inactiveText: "",
                              moreInfoText: "More info",
                              titleIcon: Iconsax.notification,
                              moreInfoIcon: Iconsax.direct_right,
                              startColor: const Color(0xFF354C10),
                              endColor: const Color(0xFF7CB224),
                              dividerColor: Colors.white,
                              width: containerWidth,
                              height: containerHeight,
                            ),
                            QContainer(
                              titleText: "10\nAlarm",
                              activeText: "",
                              inactiveText: "",
                              moreInfoText: "More info",
                              titleIcon: Iconsax.alarm,
                              moreInfoIcon: Iconsax.direct_right,
                              startColor: const Color(0xFF70470A),
                              endColor: const Color(0xFFD68814),
                              dividerColor: Colors.white,
                              width: containerWidth,
                              height: containerHeight,
                            ),
                          ],
                        ),
                        SizedBox(height: screenSize.maxHeight * 0.01),
                        // Expanded white container that conditionally renders filters and table OR the purifier image.
                        Expanded(
                          child: Center(
                            child: Container(
                              width: 1457,
                              height: 646,
                              color: Colors.white,
                              child: selectedValue == null
                                  ? Column(
                                      children: [
                                        // Row of dropdown filters.
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: _buildDropdown(
                                                  hint: "Select Continent",
                                                  value: selectedContinent,
                                                  options: continentOptions,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectedContinent = value;
                                                    });
                                                  },
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              Expanded(
                                                child: _buildDropdown(
                                                  hint: "Select Country",
                                                  value: selectedCountry,
                                                  options: countryOptions,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectedCountry = value;
                                                    });
                                                  },
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              Expanded(
                                                child: _buildDropdown(
                                                  hint: "Select City",
                                                  value: selectedCity,
                                                  options: cityOptions,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectedCity = value;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Expanded table area.
                                        Expanded(child: _buildPurifierTable()),
                                      ],
                                    )
                                  : _buildPurifierImage(),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPurifierTable() {
    return SfDataGrid(
      source: purifierDataSource,
      columnWidthMode: ColumnWidthMode.fill,
      columns: <GridColumn>[
        GridColumn(
          columnName: 'id',
          label: Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            color: TColors.button,
            child: const Text(
              'SO.No.',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        GridColumn(
          columnName: 'serialno',
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            color: TColors.button,
            child: const Text(
              'Serial Number',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        GridColumn(
          columnName: 'name',
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            color: TColors.button,
            child: const Text(
              'Purifier Name',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        GridColumn(
          columnName: 'date',
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            color: TColors.button,
            child: const Text(
              'MFR. Date',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        GridColumn(
          columnName: 'Location',
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            color: TColors.button,
            child: const Text(
              'Location',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        GridColumn(
          columnName: 'Status',
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            color: TColors.button,
            child: const Text(
              'Status',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPurifierImage() {
    String assetPath;
    if (selectedValue == "1001") {
      assetPath = "assets/HMIR.png";
    } else if (selectedValue == "1002") {
      assetPath = "assets/HMIR2.png";
    } else {
      assetPath = "assets/HMIR3.png";
    }
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 1004,
            height: 596,
            child: Image.asset(assetPath, fit: BoxFit.contain),
          ),
          Positioned(
            top: -20,
            right: -30,
            child: IconButton(
              icon: Icon(Icons.fullscreen, color: TColors.textBlack, size: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FullScreenImagePage(assetPath: assetPath),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PurifierDataSource extends DataGridSource {
  PurifierDataSource({required List<Purifier> purifierData}) {
    _purifierData = purifierData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<int>(columnName: 'serialno', value: e.salesOrderNumber),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(columnName: 'date', value: e.manufactureDate),
              DataGridCell<String>(columnName: 'Location', value: e.location),
              DataGridCell<String>(columnName: 'Status', value: e.status),
            ]))
        .toList();
  }

  List<DataGridRow> _purifierData = [];

  @override
  List<DataGridRow> get rows => _purifierData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((e) {
        if (e.columnName == 'Status') {
          final status = e.value.toString();
          final bgColor = status.toLowerCase() == 'active'
              ? const Color.fromARGB(255, 170, 216, 116)
              : const Color.fromARGB(255, 222, 113, 105);
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            color: Colors.white,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                status,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            color: Colors.white,
            child: Text(
              e.value.toString(),
              style: TextStyle(color: TColors.textBlack),
            ),
          );
        }
      }).toList(),
    );
  }
}

/// Full screen view for the purifier image.
class FullScreenImagePage extends StatelessWidget {
  final String assetPath;
  const FullScreenImagePage({Key? key, required this.assetPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.asset(assetPath, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
