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


   void deleteUser(String email) async {
    try {
      isLoading(true);
      bool success = await UserManagementApi.deleteUser(email);
      if (success) {
        userList.removeWhere((user) => user.email == email);
        Get.snackbar("Success", "User deleted successfully");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to delete user");
    } finally {
      isLoading(false);
    }
  }

  // Update user.
  void updateUser(String email, UserModel updatedUser) async {
    try {
      isLoading(true);
      var user = await UserManagementApi.updateUser(email, updatedUser);
      int index = userList.indexWhere((u) => u.email == email);
      if (index != -1) {
        userList[index] = user;
        Get.snackbar("Success", "User updated successfully");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to update user");
    } finally {
      isLoading(false);
    }
  }
}
