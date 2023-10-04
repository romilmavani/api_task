import 'package:api_task/modules/Home/views/home_screen.dart';
import 'package:api_task/modules/authentication/views/login_screen.dart';
import 'package:api_task/modules/authentication/views/signup_screen.dart';
import 'package:api_task/utils/const/cache_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(),
        primarySwatch: Colors.red,
      ),
      initialRoute: '/splash',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/splash': (context) => const SplashScreen(),
        '/signup': (context) => SignUpScreen(),
      },
      debugShowCheckedModeBanner: false,
      // home: LoginScreen(),
    );
  }
}


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(getPref.hasData(CacheKeys.loginKey)){
        Get.offAll(()=> const HomeScreen());
      }
      else{
        Get.offAll(()=> const LoginScreen());
      }
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              child:  const Text("Splash Screen"),
            ),
          ),Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}

