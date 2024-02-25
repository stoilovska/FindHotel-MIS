// HotelDetailPage.dart

import 'package:flutter/material.dart';
import 'package:find_hotel_mis/models/hotel.dart';

class HotelDetailPage extends StatelessWidget {
  final Hotel hotel;

  const HotelDetailPage({Key? key, required this.hotel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hotel.name),
        backgroundColor: Color.fromRGBO(
          (0.84 * 255).round(),
          (1.00 * 255).round(),
          (0.99 * 255).round(),
          1.0,
        ),
      ),
      backgroundColor: Color.fromRGBO(
        (0.84 * 255).round(),
        (1.00 * 255).round(),
        (0.99 * 255).round(),
        1.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location: ${hotel.location}',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Description: ${hotel.description}',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Phone: ${hotel.phone}',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Map: ${hotel.map}',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Price: \$${hotel.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Distance: ${hotel.distance} miles',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
