import 'dart:io';

import 'package:final_ui/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart'; 

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController ticketPriceController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  File? selectedImage;
  final ImagePicker _picker = ImagePicker();
  final EventMethods _eventMethods = EventMethods();

  bool validateInputs() {
    return selectedImage != null &&
        nameController.text.isNotEmpty &&
        dateController.text.isNotEmpty &&
        locationController.text.isNotEmpty &&
        ticketPriceController.text.isNotEmpty &&
        detailController.text.isNotEmpty;
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

  Future<void> uploadEvent() async {
  if (validateInputs()) {
    try {
      String eventId = generateRandomId();

      // Parse date string into DateTime object
      DateTime eventDate = DateTime.parse(dateController.text);

      // Format date into a standardized format
      String formattedDate = DateFormat('yyyy-MM-dd').format(eventDate);


      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("eventImages").child(eventId);
      final UploadTask uploadTask =
          firebaseStorageRef.putFile(selectedImage!);
      TaskSnapshot snapshot = await uploadTask;

      var downloadUrl = await snapshot.ref.getDownloadURL();

      Map<String, dynamic> eventMap = {
        "Image": downloadUrl,
        "Name": nameController.text,
        "Date": formattedDate, // Use the formatted date
        "Location": locationController.text,
        "TicketPrice": ticketPriceController.text,
        "Detail": detailController.text,
      };

      await _eventMethods.uploadEvent(eventMap);

      // Clear all details after uploading
      nameController.clear();
      dateController.clear();
      locationController.clear();
      ticketPriceController.clear();
      detailController.clear();
      setState(() {
        selectedImage = null;
      });

      showSnackBar(context, "Event added successfully");
    } catch (e) {
      print("Failed to upload event: $e");
      showSnackBar(context, "Failed to add event");
    }
  } else {
    showSnackBar(context, "Please fill all details and Upload event banner");
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Event',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
            fontSize: 25,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
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
              SizedBox(height: 20),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Event Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: dateController,
                decoration: InputDecoration(
                  hintText: 'Date',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: locationController,
                decoration: InputDecoration(
                  hintText: 'Location',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: ticketPriceController,
                decoration: InputDecoration(
                  hintText: 'Ticket Price',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: detailController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Event Detail',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: uploadEvent,
                child: Text('Add Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}