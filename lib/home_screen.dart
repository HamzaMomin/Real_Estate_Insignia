import 'package:flutter/material.dart';
import 'package:fyp/ui/posts/posts_screen.dart';
import 'Image_deatails.dart';
import 'camera_screen.dart';
import 'login_or_signup.dart';
import 'nav_bar.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
        drawer: const NavBar(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          shape:
              const Border(bottom: BorderSide(color: Colors.black, width: 2)),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Center(
          

          child: Container(
             decoration: BoxDecoration(
                  gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue.shade600,
                Colors.blue.shade800,
              ],
                ),
            ),
            child: Column(
              
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              
              children: [
                
                Expanded(
                  child: ListView.builder(
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ImageClick()));
                            },
                            child: Container(
                              height: 350,
                              width: 350,
                              margin: const EdgeInsets.only(top: 10, bottom: 10),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg'),
                                  fit: BoxFit.cover,
                              
                                ),
                              
                              ),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 80,
                                      width: 350,
                                      child: const Text(' Image details', 
                                      style: TextStyle(
                                        fontSize: 20,color:
                                         Colors.white
                                         ),
                                      ),
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [Color.fromARGB(148, 114, 127, 202), Color.fromARGB(149, 104, 158, 202),
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        
                                        
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  // variables

  int _currentScreen = 0;
//list
  final List<Widget> _screens = [
    //screens to change
    const HomeScreen(),
    const CameraScreen(),
    const SelectOne(),  // login / signup
    const PostScreen()
  ];
  //funtion to change screen
  void onButtonTap(int index) {
    setState(() {
      _currentScreen = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentScreen],
      bottomNavigationBar: BottomNavigationBar(
          elevation: 8.0,
          onTap: onButtonTap,
          currentIndex: _currentScreen,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled, color: Colors.black),
              label: 'Home',
            
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.upload_sharp,
                color: Colors.black,
              ),
              label: 'Upload',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.black),
              label: 'Profile',
            ),
          ]),
    );
  }
}
