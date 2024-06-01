
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/pic_and_bio.dart';
import 'package:flutter_application_1/widgets/recent_activity.dart';
import 'package:flutter_application_1/widgets/your_favourites.dart';
import 'package:flutter_application_1/pages/main.dart';
import 'package:flutter_application_1/widgets/profile_list_view.dart';
import 'package:flutter_application_1/pages/activity.dart';




class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
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
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
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
        backgroundColor: Colors.black,
        title: Text(
          "Account",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, 
        leading: IconButton(
          icon: Icon(
            Icons.settings,
            color: Colors.white,
          ),
          onPressed: () {}, 
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.cloud_upload,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),  
      body: Container(
        color: Color(0xFF2C3440),
        child: SingleChildScrollView( 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfilePicture(),
              Favourites(),
              Padding(
                padding: EdgeInsets.only(top: 10), 
                child: Recents(), 
              ),
              Padding(
              padding: EdgeInsets.only(top: 25), 
              child: ProfileList(), 
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