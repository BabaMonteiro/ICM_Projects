import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/widgets/everyone_favourite.dart';
import 'package:flutter_application_1/widgets/week_popular.dart';
import 'package:flutter_application_1/widgets/new_from_friends.dart';
import 'package:flutter_application_1/pages/your_profile.dart';
import 'package:flutter_application_1/pages/activity.dart';
import 'package:flutter_application_1/widgets/popular_with_friends.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

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
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
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
        title: const Text(
          'Letterboxd',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Color(0xFF2C3440),
        child: SingleChildScrollView( 
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 9),
                child: PopularThisWeek(), 
              ),
              Padding(
                padding: EdgeInsets.only(top: 20), //
                child: NewFromFriends(), 
              ),
              Padding(
                padding: EdgeInsets.only(top: 20), //
                child: PopularWithFriends(), 
              ),
               Padding(
                padding: EdgeInsets.only(top: 20), //
                child: EveryonesFav(), 
              ),
            ],
          ),
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
