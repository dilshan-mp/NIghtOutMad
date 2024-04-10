import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';

// Initialize Firebase app
void initializeFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

// Utility method to show a SnackBar
void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

class EventMethods {
  final CollectionReference _eventCollection =
      FirebaseFirestore.instance.collection('events');

  // Method to upload event data to Firestore
  Future<void> uploadEvent(Map<String, dynamic> eventMap) async {
    try {
      await _eventCollection.add(eventMap);
    } catch (e) {
      print('Error uploading event: $e');
      throw e;
    }
  }
}

class OfferMethods {
  final CollectionReference _offercollection = 
   FirebaseFirestore.instance.collection('Offers');

   Future<void> uploadOffers(Map<String,dynamic> offerMap) async{
    try{
      await _offercollection.add(offerMap);
    }catch(e){
      print('Error uploading offers: $e');
      throw e;
    }
   }
  
}

// Utility method to generate a random alphanumeric ID
String generateRandomId() {
  return randomAlphaNumeric(10);
}
