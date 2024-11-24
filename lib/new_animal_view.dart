import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewAnimalView extends StatefulWidget {
  const NewAnimalView({super.key});

  @override
  _NewAnimalViewState createState() => _NewAnimalViewState();
}

class _NewAnimalViewState extends State<NewAnimalView> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _pictureController = TextEditingController();

  void _addAnimal() async {
    if (_nameController.text.isNotEmpty &&
        _ageController.text.isNotEmpty &&
        _pictureController.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection('animals').add({
        'name': _nameController.text.trim(),
        'age': _ageController.text.trim(),
        'picture': _pictureController.text.trim(),
      });
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Animal')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _pictureController,
              decoration: const InputDecoration(labelText: 'Picture URL'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addAnimal,
              child: const Text('Add Animal'),
            ),
          ],
        ),
      ),
    );
  }
}
