import 'package:flutter/material.dart';
import 'package:pet360/screens/addnewanimal_screen.dart';
import 'package:pet360/screens/chat_screen.dart';
import 'package:pet360/screens/location_screen.dart';
import 'package:pet360/screens/profile_screen.dart';

import 'dashboard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTab = 0;
  final List<Widget> screens = [
    Dashboard(),
    ChatScreen(),
    ProfileScreen(),
    AddNewAnimalScreen(),
    LocationScreen(),
    HomeScreen(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Dashboard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen.shade300,
        child: const Icon(Icons.add_outlined),
        onPressed: () {
          setState(() {
            currentScreen= AddNewAnimalScreen();
            currentTab=0;
            });
        },
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //tabbar a sinistra
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen= Dashboard();
                          currentTab=0;
                        });
                      },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home_filled,
                          color: currentTab==0 ? Colors.lightGreen.shade300 : Colors.grey,
                        ),
                        Text('Home', style: TextStyle(color: currentTab==0 ? Colors.lightGreen.shade300 : Colors.grey),)
                      ],
                    ),
                      ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen= LocationScreen();
                        currentTab=1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: currentTab==1 ? Colors.lightGreen.shade300 : Colors.grey,
                        ),
                        Text('Traccia', style: TextStyle(color: currentTab==1? Colors.lightGreen.shade300 : Colors.grey),)
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen= ChatScreen();
                        currentTab=2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_rounded,
                          color: currentTab==2 ? Colors.lightGreen.shade300 : Colors.grey,
                        ),
                        Text('Chat', style: TextStyle(color: currentTab==2 ? Colors.lightGreen.shade300 : Colors.grey),)
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen= LocationScreen();
                        currentTab=3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.account_circle_rounded,
                          color: currentTab==3 ? Colors.lightGreen.shade300 : Colors.grey,
                        ),
                        Text('Profilo', style: TextStyle(color: currentTab==3 ? Colors.lightGreen.shade300 : Colors.grey),)
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

    );
  }
}
