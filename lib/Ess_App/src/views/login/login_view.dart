import 'package:ess/Ess_App/generated/assets.dart';
import 'package:ess/Ess_App/src/base/utils/utils.dart';
import 'package:ess/Ess_App/src/shared/bottons.dart';
import 'package:ess/Ess_App/src/shared/input_field.dart';
import 'package:ess/Ess_App/src/shared/spacing.dart';
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:ess/Ess_App/src/styles/text_theme.dart';
import 'package:ess/Ess_App/src/views/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:stacked/stacked.dart';
import '../../services/local/navigation_service.dart';
import 'Login_with_biometric.dart';

class LoginView extends StatefulWidget {
  final String? msg;
  LoginView({ Key? key, this.msg }) :super( key: key );
  @override
  State<LoginView> createState( ) => _LoginViewState( );
}

class _LoginViewState extends State<LoginView> {

  final LocalAuthentication auth = LocalAuthentication();
  SupportState supportState = SupportState.unknown;
  List<BiometricType>? availableBiometrics;
  LoginViewModel model = LoginViewModel();


  @override
  void initState()
  {
    auth.isDeviceSupported().then((bool isSupported) => setState(() => supportState = isSupported ? SupportState.supported : SupportState.unSupported ));
    super.initState();
    checkBiometric();
    getAvailableBiometrics();
  }


  Future<void> checkBiometric() async
  {
    late bool canCheckBiometric;
    try
    {
      canCheckBiometric = await auth.canCheckBiometrics;
      print("Biometric supported: $canCheckBiometric");
    }
    on
      PlatformException catch (e)
    {
      print(e);
      canCheckBiometric = false;
    }
  }

  Future<void> getAvailableBiometrics() async {
    late List<BiometricType> biometricTypes;
    try {
      biometricTypes = await auth.getAvailableBiometrics();
      print("supported biometrics $biometricTypes");
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) {
      return;
    }
    setState(() {
      availableBiometrics = biometricTypes;
    });
  }
  Future<void> authenticateWithBiometrics() async {
    try {
      final authenticated = await auth.authenticate(
          localizedReason: 'Authenticate with fingerprint or Face ID',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          )
      );

      if (!mounted) {
        return;
      }

      if (authenticated) {
        model.LogIn(context);

      }
    } on PlatformException catch (e) {
      print(e);
      return;
    }
  }
  @override
  Widget build(BuildContext context)
  {
    return ViewModelBuilder<LoginViewModel>.reactive(

      builder: (context, model, child) =>
          Scaffold(

        resizeToAvoidBottomInset: true,
        extendBodyBehindAppBar: true,
        body:
        Container(
            margin: const EdgeInsets.fromLTRB(28, 30, 28, 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap: (){
                          NavService.appmenu();
                        },
                        child: Icon(Icons.arrow_back)),
                  ],
                ),
                Spacer(),
                Image.asset(
                  Assets.imagesPremierlogo,
                  width: context.screenSize().width,
                ),
                VerticalSpacing(3),
                Text(
                  "Please Login To Continue The App",
                  style: TextStyling.text16.copyWith(color: AppColors.darkGrey),
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                Column(
                  children: [
                    MainInputField(
                      hint: 'Enter Email Address',
                      controller: model.email,
                      inputType: TextInputType.emailAddress,
                      onChanged: (val) {
                        model.checkButtonValidate(context);
                      },
                      message: 'Please enter email address',
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: AppColors.primary,
                        size: 24,
                      ),
                    ),
                    VerticalSpacing(24),
                    MainInputField(
                      hint: 'Enter Password',
                      controller: model.password,
                      isPassword: (model.isShowPassword) ? false : true,
                      onChanged: (val) {
                        model.checkButtonValidate(context);
                      },
                      message: 'Please enter password',
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: AppColors.primary,
                        size: 24,
                      ),
                      suffixIcon: InkWell(
                          onTap: () {
                            model.isShowPassword = !model.isShowPassword;
                            model.notifyListeners();
                          },
                          child: Icon(
                            Icons.remove_red_eye,
                            color: AppColors.primary,
                            size: 24,
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text(''),
                    if(model.checktabledata == false)
                    Row(
                      children: [
                        Text('Enable thumb Recognition', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),),
                        Switch(
                          value: model.isSwitched,
                          onChanged: (value) {

                            setState(() {
                              model.isSwitched = value;
                              print(model.isSwitched);
                            });
                          },
                          activeColor: AppColors.primary, // On state color
                          inactiveThumbColor: Colors.black, // Off state color
                          inactiveTrackColor: Colors.grey,
                        ),
                      ],
                    ),




                  ],
                ),
                SizedBox(height: 10,),
                if(widget.msg !=null)
                  Container(
                    padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                      color: Colors.red
                      ),
                      child: Text(widget.msg!, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)),

                if(model.checktabledata == true && widget.msg == null )

                  InkWell(
                      onTap: (){
                        authenticateWithBiometrics();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Container(
                            padding: EdgeInsets.all(4),
                              decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(width: 2, color: AppColors.primary)
                              ),
                              child: Image.asset('assets/images/file.png', height: 50,width: 50,)),
                          SizedBox(height: 8,),
                          Text("Login with Touch Id", style: TextStyle(fontWeight: FontWeight.bold),),

                        ],
                      )
                  ),

                Spacer(),
                if(widget.msg ==null)
                MainButton(
                    text: "Log In",
                    isEnabled: model.isSignInButtonEnable,
                    isBusy: model.isBusy,
                    onTap: () {

                      model.onLogIn(context);

                    }
                    ),

                //Spacer(),
              ],
            ),
          ),
        ),

      viewModelBuilder: () => LoginViewModel(),
      onModelReady: (model) => model.init(context),
    );
  }
}
