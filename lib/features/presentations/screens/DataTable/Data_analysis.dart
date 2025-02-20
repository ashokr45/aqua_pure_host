import 'package:aqua_pure/common/Responsive.dart';
import 'package:aqua_pure/features/presentations/screens/DataTable/dataTrennds.dart';
import 'package:flutter/material.dart';

import 'DataTableDesktop.dart';
import 'DataTableMobile.dart';



class DataAnalysis extends StatelessWidget {
  const DataAnalysis({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive(mobile : DataTableMobile(), desktop: DataTableDesktop());
  }
}
//mobile: DataTrends(), 