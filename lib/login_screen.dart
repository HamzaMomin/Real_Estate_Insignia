import 'package:flutter/material.dart';
import 'package:fyp/person_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/Login.png'), fit: BoxFit.cover),
      ),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
             backgroundColor: Colors.transparent,
              elevation: 0, // 1
            leading: IconButton(
              icon: Icon(Icons.keyboard_arrow_left_sharp, size: 25,color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
                 backgroundColor: Colors.transparent,
            
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: const Color(0xffe7edeb),
                              hintText: 'Email',
                              prefixIcon: Icon(Icons.email_outlined,
                                  color: Colors.grey.shade400),
                            ),
                          ),
                       ),
                              const SizedBox(
                          height: 10,
                        ),

                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: const Color(0xffe7edeb),
                              hintText: 'Password',
                              prefixIcon: Icon(Icons.password_outlined,
                                  color: Colors.grey.shade400),
                            ),
                        ),
                         ),

                             const SizedBox(
                          height: 10,
                        ),

                        OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                minimumSize: Size(300, 60),
                                textStyle: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                                primary: Color(0xff0059D4),
                                side: BorderSide(width: 3, color: Color(0xff006BFF)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                              //button press function

                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const PersonScreen()
                                        )
                                        );
                              },

                              child: Text('Login'),
                            ),


            ]),

        ),
      ),
    );
  }
}
