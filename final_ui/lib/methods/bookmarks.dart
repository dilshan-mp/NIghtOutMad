import 'package:cloud_firestore/cloud_firestore.dart';

class BookmarkMethods{
  final CollectionReference _BookmarkCollection = FirebaseFirestore.instance.collection('bookmark');

  Future<void> uploadOffers(Map<String,dynamic> BookmarkMap) async{
    try{
      await _BookmarkCollection.add(BookmarkMap);
    }catch(e){
      print('Error uploading Bookmark : $e');
      throw e;
    }
  }
}