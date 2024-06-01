import 'package:flutter/material.dart';

class PopularWithFriends extends StatelessWidget {
  final List<String> covers = [
  'assets/images/the_zone_of_interest.jpg',
  'assets/images/scent_of_a_woman.jpg',
  'assets/images/monster.jpg',
  'assets/images/the_boy_and_the_heron.jpg',
  'assets/images/forrest_gump.jpg',
  'assets/images/500_days_of_summer.jpg',
  ]; 

  PopularWithFriends ({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // title on top of image carroussel
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // child é o texto
      children:[
        

        // Align( 
        //   alignment: Alignment.centerLeft,
        //   padding: EdgeInsets.all(8),
        //   child: Container(
        //     child: const Text(
        //       'Popular this week',
        //       style: TextStyle(
        //         color: Colors.black,
        //         fontSize: 15.0, 
        //         letterSpacing: 1,
        //         fontWeight: FontWeight.bold,
        //         ),
        //     )
            
        //   )
        // ),

      const Padding(
        padding: EdgeInsets.only(
          left: 8.0, top: 3, bottom: 2),
        child: Text(
          'Popular with friends',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
          ),
          ),
        ),

      Container(
          height: 195, 
          // list view -> scrollable
      
          child: 
          ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: covers.length,
            itemBuilder: (context, index) {
              return Container(
                width: 140, // Set a width that works for your layout.
                padding: const EdgeInsets.only(left: 8, top: 0), // Add padding as needed.
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4), // Adjust the corner radius as needed.
                  child: Image.asset(
                    covers[index],
                    fit: BoxFit.cover, 
                    
                  ),
                ),
              );
            },
          ),
        )
      ]
    );
  }
}
