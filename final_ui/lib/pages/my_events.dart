import 'dart:html';

import 'package:flutter/material.dart';

class My_events extends StatefulWidget {
  const My_events({Key? key});

  @override
  State<My_events> createState() => _My_eventsState();
}

class _My_eventsState extends State<My_events> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Events',
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
            //Navigator.push(context, MaterialPageRoute(builder: (context)=>Events()));
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Stack(
          children: [
            Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: EdgeInsets.all(5),
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
      ),
    );
  }
}
