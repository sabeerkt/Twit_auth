import 'package:chats/auth/auth.dart';
import 'package:chats/auth/login_reg.dart';
import 'package:chats/controller/auth_provider.dart';
import 'package:chats/controller/posts_provider.dart';
import 'package:chats/firebase_options.dart';
import 'package:chats/views/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthPro(),
        ),
        ChangeNotifierProvider(create: (context) => PostProvider(),)

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: AuthPage(),
      ),
    );
  }
}
