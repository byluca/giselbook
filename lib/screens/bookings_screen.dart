// lib/screens/bookings_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firestore_service.dart';
import '../models/booking_model.dart';
import '../models/service_model.dart';

class BookingsScreen extends StatelessWidget {
  BookingsScreen({Key? key}) : super(key: key);

  final firestoreService = FirestoreService();

  Future<ServiceModel?> _getServiceById(String id) async {
    // Questo è un esempio semplice: potresti
    // creare un metodo in FirestoreService per recuperare un singolo service.
    final doc = await firestoreService
        .getDb()
        .collection('services')
        .doc(id)
        .get();
    if (!doc.exists) {
      return null;
    }
    return ServiceModel.fromMap(doc.data()!, doc.id);
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('Devi essere loggato per vedere le prenotazioni.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Le mie prenotazioni'),
      ),
      body: StreamBuilder<List<BookingModel>>(
        stream: firestoreService.getUserBookings(user.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Errore nel caricamento.'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final bookings = snapshot.data!;
          if (bookings.isEmpty) {
            return const Center(child: Text('Nessuna prenotazione trovata.'));
          }

          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (ctx, i) {
              final booking = bookings[i];
              return FutureBuilder<ServiceModel?>(
                future: _getServiceById(booking.serviceId),
                builder: (ctx, serviceSnap) {
                  if (serviceSnap.connectionState == ConnectionState.waiting) {
                    return const ListTile(
                      title: Text('Caricamento...'),
                    );
                  }
                  final service = serviceSnap.data;
                  if (service == null) {
                    return const ListTile(
                      title: Text('Servizio non trovato'),
                    );
                  }
                  return ListTile(
                    leading: Image.network(
                      service.imageUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(service.name),
                    subtitle: Text(
                        'Prenotato il ${booking.createdAt.toLocal().toString()}'),
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
