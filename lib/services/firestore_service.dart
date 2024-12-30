// lib/services/firestore_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/service_model.dart';
import '../models/booking_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Ritorna uno stream di tutti i servizi (dalla collezione "services")
  Stream<List<ServiceModel>> getServices() {
    return _db.collection('services').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ServiceModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  /// Crea una prenotazione nella collezione "bookings"
  Future<void> createBooking({
    required String userId,
    required String serviceId,
  }) async {
    final booking = BookingModel(
      id: '', // verrà generato automaticamente da Firestore
      userId: userId,
      serviceId: serviceId,
      createdAt: DateTime.now(),
    );

    await _db.collection('bookings').add(booking.toMap());
  }

  /// Ritorna le prenotazioni di un utente specifico
  Stream<List<BookingModel>> getUserBookings(String userId) {
    return _db
        .collection('bookings')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        // Gestione di 'createdAt' come Timestamp
        final createdAtTs = data['createdAt'] as Timestamp?;
        final createdAt = createdAtTs?.toDate() ?? DateTime.now();

        return BookingModel(
          id: doc.id,
          userId: data['userId'] ?? '',
          serviceId: data['serviceId'] ?? '',
          createdAt: createdAt,
        );
      }).toList();
    });
  }
}
