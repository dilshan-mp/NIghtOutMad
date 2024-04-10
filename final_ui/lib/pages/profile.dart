import 'package:final_ui/pages/add_event.dart';
import 'package:final_ui/pages/add_offers.dart';
import 'package:final_ui/pages/profile_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int points = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'My Profile',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
                fontSize: 25,
              ),
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileSettingsPage()),
                );
                // Add functionality to navigate to settings screen
              },
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            //Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(0.0),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const CircleAvatar(
                      backgroundImage: AssetImage("assets/profile.png"),
                      radius: 60.0,
                    ),
                    SizedBox(height: 10), // Adjust the height as needed
                    const Text(
                      'Hasala Perera',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                        height:
                            10), // Add some space between the text and the button

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddEvent()),
                      );
                      // Add functionality for "Become an Event Planner" button
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 203, 207, 210)), // Set background color
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0), // Reduce padding
                      ),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        const TextStyle(fontSize: 13.0,fontWeight: FontWeight.bold,color: Colors.black), // Reduce font size
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0), // Reduce border radius
                        ),
                      ),
                    ),
                    child: const Text('Become an Event Planner'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                    ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>AddOffer()),
                      );
                      // Add functionality for "Become an Event Planner" button
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 203, 207, 210)), // Set background color
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0), // Reduce padding
                      ),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        const TextStyle(fontSize: 13.0,fontWeight: FontWeight.bold), // Reduce font size
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0), // Reduce border radius
                        ),
                      ),
                    ),
                    child: const Text('Add Offer'),
                  ),
                      ],
                    ),
                    
                  ],
                ),
              ),
              const Divider(
                height: 20,
                thickness: 2,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  'Book marks',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 244, 74, 247),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Stack(
                  children: [
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/event_1.jpg",
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(width: 20.0),
                            Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    "My first scroll list ",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Inter',
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    "Time",
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    "Location",
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                ElevatedButton(
                                  onPressed: () {
                                    // Add your button functionality here
                                  },
                                  child: Text('View'),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 5.0,
                      right: 5.0,
                      child: IconButton(
                        icon: Icon(Icons.highlight_remove_rounded),
                        onPressed: () {
                          // Add functionality to remove the container here
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
