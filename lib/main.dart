import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Per gestire lo stato di autenticazione
import 'screens/auth_screen.dart'; // Schermata di autenticazione
import 'screens/home_screen.dart'; // Schermata principale
import 'firebase_options.dart'; // Generato automaticamente con FlutterFire CLI

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const GiselBookApp());
}

class GiselBookApp extends StatelessWidget {
  const GiselBookApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GiselBook',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthStateWrapper(), // Wrapper integrato
    );
  }
}

class AuthStateWrapper extends StatelessWidget {
  const AuthStateWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Controlla se Firebase ha finito di caricare lo stato
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Se l'utente è autenticato, mostra HomeScreen
        if (snapshot.hasData) {
          return const HomeScreen();
        }

        // Altrimenti, mostra AuthScreen
        return const AuthScreen();
      },
    );
  }
}
