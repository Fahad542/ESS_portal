import 'package:ess/Ess_App/src/views/Loan/customtextfeild.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'login_view_model.dart';

class BiometricPage extends StatefulWidget {
  BiometricPage();

  @override
  State<BiometricPage> createState() => _AuthScreenState();
}

enum SupportState { unknown, supported, unSupported }

class _AuthScreenState extends State<BiometricPage> {
  final LocalAuthentication auth = LocalAuthentication();
  SupportState supportState = SupportState.unknown;
  List<BiometricType>? availableBiometrics;
 TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  LoginViewModel model =   LoginViewModel();

  @override
  void initState()
  {
    auth.isDeviceSupported().then((bool isSupported) => setState(() => supportState = isSupported ? SupportState.supported : SupportState.unSupported));
    super.initState();
    checkBiometric();
    getAvailableBiometrics();
  }

  Future<void> checkBiometric() async {
    late bool canCheckBiometric;
    try {
      canCheckBiometric = await auth.canCheckBiometrics;
      print("Biometric supported: $canCheckBiometric");
    } on PlatformException catch (e) {
      print(e);
      canCheckBiometric = false;
    }
  }

  Future<void> getAvailableBiometrics( ) async {
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
          ) ) ;

      if ( !mounted )
      {
        return;
      }

    }
    on PlatformException catch ( e )
    {
      print(e);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biometric Authentication'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(controller: email, labelText: "Email"),
              SizedBox(height: 20),
              CustomTextField(controller: password, labelText: "Password"),

               SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/Face_ID_logo.svg.png',
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                   SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: authenticateWithBiometrics,
                    child: const Text("Authenticate with Face ID"),
                  ),
                  SizedBox(height: 20),
                ],
              ),
           
            ],
          ),
        ),
      ),
    );
  }
}
