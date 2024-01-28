import 'package:geolocator/geolocator.dart';
import 'package:location/Global.dart';
import 'package:flutter/material.dart';
import 'package:location/Components/Utils.dart';
import 'package:location/Screens/HomeScreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:location/Services/Auth_service.dart';
import 'package:location/Methods/RequestPermission.dart';
import 'package:location/Controllers/User_Controller.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showLoader = false;
  final Utils utils = Utils();
  late Position position;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      deviceWidth = MediaQuery.of(context).size.width;
      deviceHeight = MediaQuery.of(context).size.height;
    });
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: ModalProgressHUD(
        inAsyncCall: _showLoader,
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40.0,
                    width: 40.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: const Image(
                        image: AssetImage('assets/images/logo.jpg'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  const Text(
                    'LocNav',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25.0),
              const Column(
                children: [
                  Text(
                    'Your Location Navigation Expert',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    'Quick • Accurate • Trusted',
                    style: TextStyle(
                      fontSize: 12.5,
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              Container(
                height: 55.0,
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: InkWell(
                  onTap: () async {
                    try {
                      setState(() {
                        _showLoader = true;
                      });
                      final account = await AuthService().signInWithGoogle();
                      if (account != null) {
                        setState(() {
                          userEmail = account.email ?? "";
                        });
                        await UpdateUser().updateUser();
                        final permissionGranted = await requestPermission();
                        setState(() {
                          givenLocation = permissionGranted;
                        });
                        if (givenLocation) {
                          position = await Geolocator.getCurrentPosition(
                              desiredAccuracy:
                                  LocationAccuracy.bestForNavigation);
                          setState(() {
                            userPosition = position;
                          });
                        }
                        // ignore: use_build_context_synchronously
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      }
                      setState(() {
                        _showLoader = false;
                      });
                    } catch (e) {
                      GoogleSignIn().signOut();
                      setState(() {
                        _showLoader = false;
                      });
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 15.0),
                        child: Image.asset(
                          ('assets/images/Google_logo.png'),
                        ),
                      ),
                      const Text(
                        'Continue With Google',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
