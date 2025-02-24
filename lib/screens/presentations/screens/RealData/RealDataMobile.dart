import 'package:aqua_pure/common/QAppBar.dart';
import 'package:aqua_pure/common/sideMenu.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class RealDataMobile extends StatefulWidget {
  const RealDataMobile({super.key});

  @override
  State<RealDataMobile> createState() => _RealDataMobileState();
}

class _RealDataMobileState extends State<RealDataMobile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _buildMetricRow(String label, {bool multiLine = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(fontSize: 12),
              maxLines: multiLine ? 2 : 1,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Color(0xFF0267FF).withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: sideMenu(),
      appBar: QAppBar(
        notificationIcon: Iconsax.notification,
        userIcon: Iconsax.user,
        title: 'Real Time Data',
        menuIcon: Iconsax.menu_1,
        onPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Home / Real Time Data",
                style: TextStyle(color: Colors.blue.shade700),
              ),
              SizedBox(height: 16),
              
              // Detailed Metrics Section
              _buildSection(
                'Detailed Metrics',
                [
                  _buildMetricRow('Pre Filter Pressure PT1'),
                  _buildMetricRow('Post Filter Pressure PT2'),
                  _buildMetricRow('Pump Pressure PT3'),
                  _buildMetricRow('System Pressure PT4'),
                  _buildMetricRow('Reject Pressure PT5'),
                  _buildMetricRow('Interstage Pressure PT6'),
                  _buildMetricRow('Flow Rate 1'),
                  _buildMetricRow('Flow Rate 2'),
                  _buildMetricRow('Recirculation Flow Rate 3', multiLine: true),
                  _buildMetricRow('Water Temperature'),
                  _buildMetricRow('Recovery %'),
                  _buildMetricRow('Rejection %'),
                  _buildMetricRow('ΔP Membrane'),
                  _buildMetricRow('ΔP Prefilter'),
                ],
              ),

              // Quality Metrics Section
              _buildSection(
                'Quality Metrics',
                [
                  _buildMetricRow('Feed ORP'),
                  _buildMetricRow('Feed TDS'),
                  _buildMetricRow('Feed pH'),
                  _buildMetricRow('Product TDS'),
                  _buildMetricRow('Product pH'),
                ],
              ),

              // Component Status Section
              _buildSection(
                'Component Status',
                [
                  _buildMetricRow('Feed pump status'),
                  _buildMetricRow('Inlet valve status'),
                  _buildMetricRow('Permeate flush valve status', multiLine: true),
                  _buildMetricRow('Blending valve status'),
                  _buildMetricRow('RO high pressure pump status', multiLine: true),
                  _buildMetricRow('Flush Valve Status'),
                  _buildMetricRow('Reject Valve Status'),
                  _buildMetricRow('Divert Valve Status'),
                ],
              ),

              // Level Switches Status Section
              _buildSection(
                'Level Switches Status',
                [
                  _buildMetricRow('Raw water tank low level switch', multiLine: true),
                  _buildMetricRow('Post chlorination low level switch', multiLine: true),
                  _buildMetricRow('Pre chlorination dosing low level switch', multiLine: true),
                  _buildMetricRow('Antiscalant dosing low level switch', multiLine: true),
                  _buildMetricRow('Dechlorination dosing low level switch', multiLine: true),
                  _buildMetricRow('Post pH low level switch'),
                  _buildMetricRow('Permeate water tank high-high level switch', multiLine: true),
                  _buildMetricRow('Permeate water tank high-medium level switch', multiLine: true),
                ],
              ),

              // Pressure Switches Status Section
              _buildSection(
                'Pressure Switches Status',
                [
                  _buildMetricRow('Pressure switch low'),
                  _buildMetricRow('Pressure switch high'),
                ],
              ),

              // Alarms & Warnings Section
              _buildSection(
                'Alarms & Warnings',
                [
                  _buildMetricRow('Current Alarm'),
                  _buildMetricRow('Warning Indicators'),
                  _buildMetricRow('Pretreat lock out'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

