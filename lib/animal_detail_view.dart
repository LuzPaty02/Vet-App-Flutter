import 'package:flutter/material.dart';

class AnimalDetailView extends StatelessWidget {
  final dynamic animal;

  const AnimalDetailView({super.key, required this.animal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(animal['name']),
        automaticallyImplyLeading: true, // Default back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${animal['name']}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Age: ${animal['age']} ${animal['age'] == 1 ? "year" : "years"} old'),
            const SizedBox(height: 20),
            if (animal['picture'] != null && animal['picture'].isNotEmpty)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FullScreenImageView(imageUrl: animal['picture']),
                    ),
                  );
                },
                child: Image.network(
                  animal['picture'],
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Text('Failed to load image'),
                ),
              )
            else
              Image.network(
                'https://drive.usercontent.google.com/download?id=1_B5FxxLSL8pc7HD1U0iT9RlLfqxbBuyt&export=view&authuser=1',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  if (error.toString().contains('HTTP error 404')) {
                    return const Text('Image not found');
                  }
                  else if (error.toString().contains('HTTP error 403')) {
                    return const Text('Image access forbidden');
                  }
                  else if (error.toString().contains('HTTP error 400')) {
                    return const Text('Bad request');
                  }
                  else {
                    return const Text('Failed to load image');
                  }
                  
                },
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class FullScreenImageView extends StatelessWidget {
  final String imageUrl;

  const FullScreenImageView({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) =>
              const Text('Failed to load image'),
        ),
      ),
    );
  }
}
