import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/main.dart';
import 'package:flutter_application_1/pages/your_profile.dart';



class ActivityPage extends StatefulWidget {
  
  @override
  ActivityPageState createState() => ActivityPageState();
}

class ActivityPageState extends State<ActivityPage> {
  int _selectedIndex = 0;

  final List<Activity> activities = [
    Activity(username: 'Inês', action: 'added The History of Sound to her watchlist', timeAgo: '3h'),
    Activity(username: 'Inês', action: 'added Spaceman to her watchlist', timeAgo: '3d'),
    Activity(username: 'Juliana ', action: 'watched Cinema Paradiso', timeAgo: '3d'),
    Activity(username: 'Pedro ', action: 'watched End Game', timeAgo: '4d'),
    Activity(username: 'Pedro ', action: 'added Past Lives to his watchlist', timeAgo: '4d'),
    Activity(username: 'Bárbara ', action: 'watched Cinema Paradiso', timeAgo: '4d'),
    Activity(username: 'Juliana ', action: 'watched and rated Barbie', timeAgo: '4d'),
     Activity(username: 'Inês', action: 'added The History of Sound to her watchlist', timeAgo: '3h'),
    Activity(username: 'Inês', action: 'added Spaceman to her watchlist', timeAgo: '3d'),
    Activity(username: 'Juliana ', action: 'watched Cinema Paradiso', timeAgo: '3d'),
    Activity(username: 'Pedro ', action: 'watched End Game', timeAgo: '4d'),
    Activity(username: 'Pedro ', action: 'added Past Lives to his watchlist', timeAgo: '4d'),
    Activity(username: 'Bárbara ', action: 'watched Cinema Paradiso', timeAgo: '4d'),
    Activity(username: 'Juliana ', action: 'watched and rated Barbie', timeAgo: '4d')

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ActivityPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ActivityPage()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ActivityPage()),
      );
    } else if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity', style: TextStyle(
          color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
        ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true, 
      ),
      body: Container(
        color: Color(0xFF2C3440),
        child: ListView.builder(
          itemCount: activities.length,
          itemBuilder: (context, index) {
            final activity = activities[index];
            return Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey, // Color for the border
                    width: 0.5, // Width of the border
                  ),
                ),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.person),
                  backgroundColor: Colors.blueAccent,
                ),
                title: Text(
                  '${activity.username} ${activity.action}',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  activity.timeAgo,
                  style: TextStyle(color: Colors.white70),
                ),
                tileColor: Color(0xFF2C3440), 
              ),
            );
          },
        ),
      ),

       bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 64, 74, 90),
        unselectedItemColor: Colors.white54, 
        selectedItemColor: Colors.white, // when selected -> white 
        type: BottomNavigationBarType.fixed, 
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 30.0,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
              size: 30.0,
              color: Colors.green,
            ),
            label: 'Review/Log',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.flash_on_outlined,
              size: 30.0,
            ),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 30.0,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex, 
        onTap: _onItemTapped, // muda de cor quando clicado
      ),     
    );
  }
}

class Activity {
  final String username;
  final String action;
  final String timeAgo;

  Activity({required this.username, required this.action, required this.timeAgo});
}

