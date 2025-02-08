//
// import '../My_models/user_model.dart';
// import '../data/network/Api_url.dart';
// import '../data/network/Baseapiservices.dart';
// import '../data/network/Networkapiservices.dart';
//
// class UserRepository {
//
//   BaseApiServices _apiServices = NetworkApiService() ;
//
//   Future<Usermodel> UsersList()async{
//
//     try{
//
//       dynamic response = await _apiServices.getGetApiResponse(AppUrl.userurl);
//       return response = Usermodel.fromJson(response);
//
//     }catch(e){
//       throw e ;
//     }
//   }
//
// }