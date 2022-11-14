import 'package:diabeta_app/components/constants.dart';
import 'package:diabeta_app/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}

class _AuthScreenState extends State<AuthScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  bool isLoad = true;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> _authenticateWithBiometrics() async {
    SharedPreferences prefs = await _prefs;
    bool authenticated = false;

    if (prefs.getBool("isAppLock") == null) {
      prefs.setBool("isAppLock", false);
    }

    if (prefs.getBool("isAppLock")!) {
      isLoad = false;
      try {
        setState(() {
          _isAuthenticating = true;
          _authorized = 'Authenticating';
        });
        authenticated = await auth.authenticate(
          localizedReason: 'Scan your fingerprint to authenticate',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ),
        );
        setState(() {
          _isAuthenticating = false;
          _authorized = 'Authenticating';
        });
      } on PlatformException catch (e) {
        setState(() {
          _isAuthenticating = false;
          _authorized = 'Error - ${e.message}';
        });
        return;
      }
      if (!mounted) {
        return;
      }

      if (authenticated) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      }
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    }
  }

  @override
  void initState() {
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
              ? _SupportState.supported
              : _SupportState.unsupported),
        );
    _authenticateWithBiometrics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoad
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Image.asset(
                        "assets/images/frontlogo.png",
                        width: 300,
                        height: 300,
                      ),
                    ),
                    const Center(
                      child: Text(
                        "DiaBeta",
                        style: TextStyle(fontSize: 36, color: Colors.teal),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainScreen()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Text(
                      "Continue",
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Image.asset(
                        "assets/images/frontlogo.png",
                        width: 300,
                        height: 300,
                      ),
                    ),
                    const Center(
                      child: Text(
                        "DiaBeta Locked",
                        style: TextStyle(fontSize: 24, color: Colors.teal),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    _authenticateWithBiometrics();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Text(
                      "Unlock",
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
