// lib/screens/services_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firestore_service.dart';
import '../models/service_model.dart';
import 'service_detail_screen.dart';

class ServicesScreen extends StatelessWidget {
  ServicesScreen({Key? key}) : super(key: key);

  final _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Servizi disponibili'),
      ),
      body: StreamBuilder<List<ServiceModel>>(
        stream: _firestoreService.getServices(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Errore di caricamento'),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final services = snapshot.data!;
          if (services.isEmpty) {
            return const Center(
              child: Text('Nessun servizio trovato'),
            );
          }

          return ListView.builder(
            itemCount: services.length,
            itemBuilder: (ctx, i) {
              final service = services[i];
              return ListTile(
                leading: Image.network(
                  service.imageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
                title: Text(service.name),
                subtitle: Text('€ ${service.price.toStringAsFixed(2)}'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ServiceDetailScreen(service: service),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
