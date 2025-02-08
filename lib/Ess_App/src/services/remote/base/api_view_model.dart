import 'package:ess/Ess_App/src/configs/app_setup.locator.dart';
import 'package:ess/Ess_App/src/services/remote/api_service.dart';
import 'package:ess/Ess_App/src/services/remote/network_exceptions.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

mixin ApiViewModel on BaseViewModel {
  ApiService _apiService = locator<ApiService>();

  ApiService get apiService => _apiService;

  showError(NetworkExceptions error, {String message = "There was an error!"}) {
    locator<SnackbarService>().showSnackbar(message: message);
  }
}
