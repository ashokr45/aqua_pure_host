import 'package:aqua_pure/apis/user_management_apis.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';


class UserController extends GetxController {
  var isLoading = true.obs;
  var userList = <UserModel>[].obs;
  var searchQuery = ''.obs;

  final UserManagementApis UserManagementApi = UserManagementApis();

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  void fetchUsers() async {
    try {
      isLoading(true);
      var users = await UserManagementApi.fetchUsers();
      if (users != null) {
        userList.assignAll(users);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load users");
    } finally {
      isLoading(false);
    }
  }

  void addUser(UserModel user) async {
    try {
      isLoading(true);
      var newUser = await UserManagementApi.addUser(user);
      userList.add(newUser);
      Get.back(); // Close the dialog
      Get.snackbar("Success", "User added successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to add user");
    } finally {
      isLoading(false);
    }
  }

  List<UserModel> get filteredUsers {
    if (searchQuery.value.isEmpty) {
      return userList;
    } else {
      return userList.where((user) {
        return user.name.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
            user.username.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
            user.role.toLowerCase().contains(searchQuery.value.toLowerCase()) || 
            user.location.toLowerCase().contains(searchQuery.value.toLowerCase());
      }).toList();
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }
}
