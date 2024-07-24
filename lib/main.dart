import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:velocity_x/velocity_x.dart';

import 'auth/Login.dart';
import 'firebase_options.dart';
import 'pages/Quiz/Timer.dart';
import 'pages/home/Home.dart';
import 'util/store.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

//global navigator key
final navgatorKey = GlobalKey<NavigatorState>();

//main App
class MyApp extends StatelessWidget {
  // ignore: non_constant_identifier_names

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navgatorKey,
      title: 'Student Chemia Galaxy',
      theme: ThemeData(
        // Application theme data, you can set the colors for the application as
        // you want
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {"/": (context) => Splash()},
    );
  }
}
//spalsh screen

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Container(
        decoration: BoxDecoration(
          // border:
          //     Border.all(color: Color.fromARGB(143, 243, 117, 117), width: 1),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Container(
          height: 84.5,
          width: 81,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              boxShadow: const [
                // BoxShadow(
                //     color: Colors.white38, blurRadius: 20, spreadRadius: 2),
              ]),
          child: Image.asset(
            "assets/images/logo1.png",
            scale: 2,
            fit: BoxFit.cover,
          ),
        ),
      ),
      duration: 1000,
      nextScreen: Verifier(),
      splashTransition: SplashTransition.scaleTransition,
      pageTransitionType: PageTransitionType.fade,
      backgroundColor: Color.fromARGB(255, 190, 164, 198),
    );
  }
}

//Auth verification and First page supply

class Verifier extends StatefulWidget {
  const Verifier({super.key});

  @override
  State<Verifier> createState() => _VerifierState();
}

class _VerifierState extends State<Verifier> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // FirebaseAuth.instance.signOut();

          if (snapshot.hasData) {
            return Home();
          } else {
            return Login();
          }
        });
  }
}

// import 'package:cstudents/pages/payment/test.dart';
// import 'package:cstudents/util/store.dart';
// import 'package:flutter/material.dart';
// import 'package:velocity_x/velocity_x.dart';

// void main() {
//   runApp(VxState(store: MyStore(), child: const MyApp()));
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Widget Test App'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     // VxState.watch(context, on: [Increment]);

//     // MyStore store = VxState.store;

//     return Scaffold(
//         // appBar: VxAppBar(
//         //   backgroundColor: Colors.transparent,
//         //   elevation: 0,
//         // ),
//         body: const ParallaxNFT());
//   }
// }
