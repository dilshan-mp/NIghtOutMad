import 'package:cloud_firestore/cloud_firestore.dart';

class EventMethods {
  final CollectionReference _offerCollection =
      FirebaseFirestore.instance.collection('Offers'); // Updated collection name

  Future<void> uploadOffer(Map<String, dynamic> offerMap) async {
    try {
      await _offerCollection.add(offerMap);
    } catch (e) {
      print('Error uploading offer: $e');
      throw e;
    }
  }
}
