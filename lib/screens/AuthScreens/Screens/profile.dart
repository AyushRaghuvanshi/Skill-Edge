import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skilledge/screens/AuthScreens/Screens/editProfile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? name;

  String? pic;

  bool educator = false;

  var file;

  String? dob;

  int? phone;

  bool? isedu;

  String? username;

  bool? gender;

  Future<void> getdata() async {
    var snapshot = await SharedPreferences.getInstance();
    name = await snapshot.getString("Name");
    username = await snapshot.getString("Username");
    pic = await snapshot.getString("picture");
    dob = await snapshot.getString("dateOfBirth");
    phone = await snapshot.getInt("mobile");
    isedu = await snapshot.getBool("is_educator");
    gender = await snapshot.getBool("gender");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getdata(),
        builder: ((context, snapshot) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(bottom: 48),
                        child: Text(
                          'My Profile',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Color(0xFF01C5A6),
                            borderRadius:
                                BorderRadius.all(Radius.circular(100))),
                        child: Stack(
                            alignment: Alignment.bottomRight,
                            clipBehavior: Clip.none,
                            children: [
                              CircleAvatar(
                                radius: 70,
                                foregroundImage: (file != null)
                                    ? FileImage(file)
                                    : NetworkImage((pic != null)
                                            ? pic!
                                            : 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png')
                                        as ImageProvider,
                              ),
                              Positioned(
                                bottom: -10,
                                right: -10,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xFFF6FAFA),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100))),
                                  child: IconButton(
                                    color: Colors.black,
                                    icon: Icon(Icons.edit),
                                    onPressed: () async {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => EditProfile(
                                                  pic: pic,
                                                  name: name,
                                                  dob: dob,
                                                  phone: phone,
                                                  user_name: username,
                                                  gender: gender,
                                                  is_educator: isedu)));
                                      // file = await pickImage();
                                      // print(file);
                                      // setState(() {});
                                    },
                                  ),
                                ),
                              ),
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 22.5),
                        child: Text(
                          (name != null) ? name! : 'User',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Switch to Educator',
                            style: TextStyle(fontSize: 20),
                          ),
                          Switch(
                            // thumb color (round icon)
                            activeColor: Colors.white,
                            activeTrackColor: Color(0xFF01C5A6),
                            inactiveThumbColor: Colors.blueGrey.shade600,
                            inactiveTrackColor: Colors.grey.shade400,
                            splashRadius: 50.0,
                            // boolean variable value
                            value: educator,
                            // changes the state of the switch
                            onChanged: (value) =>
                                setState(() => educator = value),
                          )
                        ],
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 31.0, right: 32, top: 62),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Icon(Icons.wallet),
                                      Text('Wallet')
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Icon(Icons.people),
                                      Text('Invite')
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Icon(Icons.lock),
                                      Text('Privacy')
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              // padding: const EdgeInsets.all(8.0),
                              padding: EdgeInsets.only(
                                  left: 31.0, right: 10, top: 32),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Icon(Icons.warning),
                                      Text('Help')
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Icon(Icons.bookmark_border),
                                      Text('About us')
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Icon(Icons.thumb_up),
                                      Text('Contact us')
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 32.0, left: 24),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Icon(Icons.logout),
                                      Text('Log out')
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ]),
              ),
            ))));
  }
}
