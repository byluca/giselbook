// lib/models/service_model.dart
class ServiceModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  ServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  // Per convertire da e verso Firestore
  factory ServiceModel.fromMap(Map<String, dynamic> data, String documentId) {
    return ServiceModel(
      id: documentId,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
