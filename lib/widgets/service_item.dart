import 'package:flutter/material.dart';
import '../models/service_model.dart';

class ServiceItem extends StatelessWidget {
  final ServiceModel service;
  final VoidCallback onTap;

  const ServiceItem({
    Key? key,
    required this.service,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.all(8.0),
        elevation: 3,
        child: Row(
          children: [
            // Immagine del servizio
            Image.network(
              service.imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 10),
            // Info del servizio
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(service.description),
                    const SizedBox(height: 5),
                    Text(
                      '€ ${service.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
