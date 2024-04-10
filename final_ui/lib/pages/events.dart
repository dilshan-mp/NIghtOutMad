import 'package:final_ui/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  late Stream<QuerySnapshot> _todayEventsStream;
  late Stream<QuerySnapshot> _upcomingEventsStream;
  

  @override
  void initState() {
    super.initState();

    DateTime now = DateTime.now();
    String currentDate = DateFormat('yyyy-MM-dd').format(now);

    _todayEventsStream = FirebaseFirestore.instance
        .collection('events')
        .where('Date', isEqualTo: currentDate)
        .snapshots();

    _upcomingEventsStream = FirebaseFirestore.instance
        .collection('events')
        .where('Date', isGreaterThan: currentDate)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Events',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
            fontSize: 25,
          ),
        ),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
        //   },
        // ),
      ),
      body: Column(
        children: <Widget>[
          _buildTopNavigationBar(),
          Expanded(
            child: _currentIndex == 0
                ? _buildEventSection(_todayEventsStream)
                : _buildEventSection(_upcomingEventsStream),
          ),
        ],
      ),
    );
  }

  int _currentIndex = 0;

  Widget _buildTopNavigationBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                _currentIndex = 0;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _currentIndex == 0 ? Colors.purple : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Today',
                style: TextStyle(
                  color: _currentIndex == 0 ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _currentIndex = 1;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _currentIndex == 1 ? Colors.purple : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Upcoming',
                style: TextStyle(
                  color: _currentIndex == 1 ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventSection(Stream<QuerySnapshot> eventsStream) {
    return StreamBuilder<QuerySnapshot>(
      stream: eventsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.data!.docs.isEmpty) {
          return Text(_currentIndex == 0 ? 'No events today' : 'No upcoming events');
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int index) {
            Map<String, dynamic> data =
                snapshot.data!.docs[index].data() as Map<String, dynamic>;


            return Container(
              margin: const EdgeInsets.all(10.0),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  // Wrap with Stack
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            data['Image'],
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 20.0),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  data['Name'],
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Inter',
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  data['Date'],
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  data['Location'],
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Event Details'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        data['Image'],
                                        height: 200,
                                        width: 200,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Name: ${data['Name']}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        'Date: ${data['Date']}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        'Location: ${data['Location']}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        'Ticket Price: ${data['TicketPrice']}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        'Detail: ${data['Detail']}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(); // Close the dialog
                                        },
                                        child: const Text('Close'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: const Text('View'),
                        ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: 5.0,
                      right: 5.0,
                      child: IconButton(
                        icon: const Icon(Icons.bookmark),
                        onPressed: () {
                          // Add functionality to remove the container here
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
