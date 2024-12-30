import 'package:flutter/material.dart';
import '../models/service_model.dart';
import '../widgets/service_item.dart';
import 'service_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final List<ServiceModel> services = [
    ServiceModel(
      id: '1',
      name: 'Taglio Uomo',
      description: 'Taglio classico o moderno per uomo.',
      price: 20.0,
      imageUrl: 'https://via.placeholder.com/150', // link di esempio
    ),
    ServiceModel(
      id: '2',
      name: 'Taglio Donna',
      description: 'Taglio per donna, scalato o con frangia.',
      price: 25.0,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    ServiceModel(
      id: '3',
      name: 'Colore',
      description: 'Colorazione professionale per capelli.',
      price: 45.0,
      imageUrl: 'https://via.placeholder.com/150',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hair Salon'),
      ),
      body: ListView.builder(
        itemCount: services.length,
        itemBuilder: (ctx, index) {
          return ServiceItem(
            service: services[index],
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => ServiceDetailScreen(service: services[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
