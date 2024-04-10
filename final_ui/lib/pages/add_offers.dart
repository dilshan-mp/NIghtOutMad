import 'dart:io';

import 'package:final_ui/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:intl/intl.dart';

class AddOffer extends StatefulWidget {
  const AddOffer({Key? key}) : super(key: key);

  @override
  State<AddOffer> createState() => _AddOfferState();
}

class _AddOfferState extends State<AddOffer> {
  TextEditingController offerTitleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController restaurantController = TextEditingController();
  File? selectedImage;
  final ImagePicker _picker = ImagePicker();
  final OfferMethods _offertMethods = OfferMethods();

  bool validateInputs() {
    return selectedImage != null &&
        offerTitleController.text.isNotEmpty &&
        dateController.text.isNotEmpty &&
        locationController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty &&
        restaurantController.text.isNotEmpty;
  }

  Future getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> uploadOffer() async {
    if (validateInputs()) {
      try {
        String offerId = generateRandomId();

        DateTime eventDate = DateTime.parse(dateController.text);

        // Format date into a standardized format
        String formattedDate = DateFormat('yyyy-MM-dd').format(eventDate);

        Reference firebaseStorageRef =
            FirebaseStorage.instance.ref().child("offerImages").child(offerId);
        final UploadTask uploadTask = firebaseStorageRef.putFile(selectedImage!);
        TaskSnapshot snapshot = await uploadTask;

        var downloadUrl = await snapshot.ref.getDownloadURL();

        // Construct offerMap with field values
        Map<String, dynamic> offerMap = {
          "Image": downloadUrl,
          "OfferTitle": offerTitleController.text,
          "Date": dateController.text,
          "Location": locationController.text,
          "Description": descriptionController.text,
          "PhoneNumber": phoneNumberController.text,
          "Restaurant": restaurantController.text,
        };

        await _offertMethods.uploadOffers(offerMap);
        // Handle Firebase database operations here with offerMap
        // For now, I'm just printing the offerMap
        print("Offer Details: $offerMap");

        // Clear all details after uploading
        offerTitleController.clear();
        dateController.clear();
        locationController.clear();
        descriptionController.clear();
        phoneNumberController.clear();
        restaurantController.clear();
        setState(() {
          selectedImage = null;
        });

        showSnackBar(context, "Offer added successfully");
      } catch (e) {
        print("Failed to upload offer: $e");
        showSnackBar(context, "Failed to add offer");
      }
    } else {
      showSnackBar(context, "Please fill all details and upload offer banner");
    }
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Offer',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Inter'
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed:(){ 
          Navigator.pop(context);
        },
      ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: getImage,
                child: selectedImage != null
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: FileImage(selectedImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.add_a_photo,
                            color: Colors.grey[800], size: 50),
                      ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: offerTitleController,
                decoration: const InputDecoration(
                  hintText: 'Offer Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: dateController,
                decoration: const InputDecoration(
                  hintText: 'Date',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: locationController,
                decoration: const InputDecoration(
                  hintText: 'Location',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
               TextFormField(
                controller: restaurantController,
                decoration: const InputDecoration(
                  hintText: 'Restaurant',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: phoneNumberController,
                decoration: const InputDecoration(
                  hintText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
               TextFormField(
                controller: descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: uploadOffer,
                child: const Text('Add Offer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
