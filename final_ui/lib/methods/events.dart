import 'package:cloud_firestore/cloud_firestore.dart';

class EventMethods {
  final CollectionReference _eventCollection =
      FirebaseFirestore.instance.collection('events');

  Future<void> uploadEvent(Map<String, dynamic> eventMap) async {
    try {
      await _eventCollection.add(eventMap);
    } catch (e) {
      print('Error uploading event: $e');
      throw e;
    }
  }
}
