// import 'package:flutter/cupertino.dart';
//
// import '../My_models/user_model.dart';
// import '../My_repository/user_repository.dart';
//
//
// class UserViewViewModel with ChangeNotifier {
//
//   final _myRepo = UserRepository();
//
//   ApiResponse<Usermodel> userList = ApiResponse.loading();
//
//   setuserList(ApiResponse<Usermodel> response){
//     userList = response ;
//     //print(response);
//     notifyListeners();
//   }
//
//
//   Future<void> fetchuserListApi ()async{
//
//     setuserList(ApiResponse.loading());
//
//     _myRepo.UsersList().then((value){
//
//       setuserList(ApiResponse.completed(value));
//
//     }).onError((error, stackTrace){
//
//       setuserList(ApiResponse.error(error.toString()));
//
//     });
//   }
//
//
// }