import 'package:aqua_pure/apis/purifier_apis.dart';
import 'package:get/get.dart';

import '../models/purifier_model.dart';


class PurifierController extends GetxController {
  var isLoading = true.obs;
  var purifierList = <Purifier>[].obs;
  var filteredPurifierList = <Purifier>[].obs;

  // Sorting state: sortColumn holds the name and sortDirection true for ascending, false for descending
  var sortColumn = ''.obs;
  var sortDirection = true.obs;

  @override
  void onInit() {
    fetchPurifiers();
    super.onInit();
  }

  void fetchPurifiers() async {
    try {
      isLoading(true);
      var purifiers = await PurifierApi.fetchPurifiers();
      purifierList.assignAll(purifiers);
      filteredPurifierList.assignAll(purifiers);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  void filterPurifiers(String query) {
    if (query.isEmpty) {
      filteredPurifierList.assignAll(purifierList);
    } else {
      filteredPurifierList.assignAll(
        purifierList.where((purifier) {
          return purifier.name.toLowerCase().contains(query.toLowerCase()) ||
              purifier.location.toLowerCase().contains(query.toLowerCase()) ||
              purifier.serialno.toString().contains(query) ||
              purifier.manufactureDate.contains(query);
        }).toList(),
      );
    }
  }

  void sortPurifiers(String columnName) {
    if (sortColumn.value == columnName) {
      // Reverse sort order if same column is tapped again
      sortDirection.value = !sortDirection.value;
    } else {
      sortColumn.value = columnName;
      sortDirection.value = true; // default to ascending
    }
    List<Purifier> sorted = List.from(filteredPurifierList);
    sorted.sort((a, b) {
      int compareResult = 0;
      switch (columnName) {
        case 'id':
          compareResult = a.id.compareTo(b.id);
          break;
        case 'serialno':
          compareResult = a.serialno.compareTo(b.serialno);
          break;
        case 'name':
          compareResult = a.name.compareTo(b.name);
          break;
        case 'manufactureDate':
          compareResult = a.manufactureDate.compareTo(b.manufactureDate);
          break;
        case 'location':
          compareResult = a.location.compareTo(b.location);
          break;
        case 'status':
          compareResult = a.status.compareTo(b.status);
          break;
      }
      return sortDirection.value ? compareResult : -compareResult;
    });
    filteredPurifierList.assignAll(sorted);
  }
}
