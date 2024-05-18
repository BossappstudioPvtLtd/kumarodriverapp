// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';



class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _databaseReference = FirebaseDatabase.instance.reference();

  late String _userName, _email, _password, _phoneNumber, _carModel, _carNumber;
  late int _carSeats;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      // Assuming you have a unique identifier for each user, such as a UID
      String userId = 'unique_user_id';

      _databaseReference.child('users').child(userId).set({
        'userName': _userName,
        'email': _email,
        'password': _password, // Note: Storing passwords in plain text is not secure.
        'phoneNumber': _phoneNumber,
        'carDetails': {
          'carModel': _carModel,
          'carNumber': _carNumber,
          'carSeats': _carSeats,
        },
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'User Name'),
              onSaved: (value) => _userName = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              onSaved: (value) => _email = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              onSaved: (value) => _password = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Phone Number'),
              onSaved: (value) => _phoneNumber = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Car Model'),
              onSaved: (value) => _carModel = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Car Number'),
              onSaved: (value) => _carNumber = value!,
            ),
            DropdownButtonFormField(
              items: [
                DropdownMenuItem(child: Text('3 seats'), value: 3),
                DropdownMenuItem(child: Text('4 seats'), value: 4),
                DropdownMenuItem(child: Text('7 seats'), value: 7),
              ],
              onChanged: (value) => _carSeats = value!,
              onSaved: (value) => _carSeats = value!,
              decoration: InputDecoration(labelText: 'Car Seats'),
            ),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Register'),
            ),
          ],
        ),
      
    );
  }
}