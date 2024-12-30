// lib/models/booking_model.dart
class BookingModel {
  final String id;
  final String userId;
  final String serviceId;
  final DateTime createdAt;

  BookingModel({
    required this.id,
    required this.userId,
    required this.serviceId,
    required this.createdAt,
  });

  factory BookingModel.fromMap(Map<String, dynamic> data, String documentId) {
    return BookingModel(
      id: documentId,
      userId: data['userId'] ?? '',
      serviceId: data['serviceId'] ?? '',
      createdAt: (data['createdAt'] as DateTime?) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'serviceId': serviceId,
      'createdAt': createdAt,
    };
  }
}
