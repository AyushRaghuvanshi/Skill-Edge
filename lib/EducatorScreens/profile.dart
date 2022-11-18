import 'package:flutter/material.dart';
import 'package:mailto/mailto.dart';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skilledge/EducatorScreens/edit.dart';
import 'package:skilledge/EducatorScreens/wallet.dart';
import 'package:skilledge/screens/Getting_started/gettingstarted.dart';
import 'package:skilledge/screens/Screens/editProfile.dart';

import 'package:skilledge/screens/dashboard.dart';
import 'package:skilledge/services/api_services.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePageEdu extends StatefulWidget {
  const ProfilePageEdu({super.key});

  @override
  State<ProfilePageEdu> createState() => _ProfilePageEduState();
}

class _ProfilePageEduState extends State<ProfilePageEdu> {
  String? name;

  String? pic;

  bool educator = false;

  var file;

  String? dob;

  int? phone;

  bool? isedu;

  String? username;

  String? gender;

  bool? iscertified;

  double? israting;

  bool loading = false;

  Future<void> getdata() async {
    var snapshot = await SharedPreferences.getInstance();
    name = await snapshot.getString("Name");
    username = await snapshot.getString("Username");
    pic = await snapshot.getString("picture");
    dob = await snapshot.getString("dateOfBirth");
    phone = await snapshot.getInt("mobile");
    isedu = await snapshot.getBool("is_educator");
    gender = await snapshot.getString("gender");
    iscertified = await snapshot.getBool("is_certified_educator");
    israting = await snapshot.getDouble("educator_rating");
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
                                              builder: (context) =>
                                                  EditProfileEdu(
                                                      pic: pic,
                                                      name: name,
                                                      dob: dob,
                                                      phone: phone,
                                                      user_name: username,
                                                      gender: gender,
                                                      is_educator: isedu)));
                                      // file = await pickImage();

                                      // setState(() {});
                                    },
                                  ),
                                ),
                              ),
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 22.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              (name != null) ? name! : 'User',
                              style: TextStyle(fontSize: 24),
                            ),
                            Container(
                              child: (iscertified == null)
                                  ? null
                                  : (iscertified! != true)
                                      ? null
                                      : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.verified,
                                            color: Colors.blue,
                                          ),
                                        ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Switch to Student',
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
                              value: !educator,
                              // changes the state of the switch
                              onChanged: (value) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Dashboard(),
                                    ),
                                    (route) => false);
                              })
                        ],
                      ),
                      Container(
                        child: (iscertified == null)
                            ? null
                            : (iscertified!)
                                ? null
                                : Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                        color: Color(0xFFeed202),
                                        border: Border.all(
                                            color: Colors.amber, width: 10),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: (iscertified == null)
                                        ? null
                                        : (iscertified!)
                                            ? null
                                            : Center(
                                                child: Text(
                                                  (iscertified == null)
                                                      ? ""
                                                      : (iscertified!)
                                                          ? ""
                                                          : "You are not a Certified Educator.\n Your Rating is ${(israting.toString().length > 3) ? israting.toString().substring(0, 4) : israting.toString()}\n You Need to be above 2.5 to be able to Host Paid Courses",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black),
                                                ),
                                              ),
                                  ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                        Container(
                                          child: (loading)
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                )
                                              : IconButton(
                                                  icon: Icon(Icons.wallet),
                                                  onPressed: () {
                                                    screentouch = true;
                                                    setState(() {
                                                      loading = true;
                                                    });
                                                    API api = API();
                                                    api
                                                        .getwalletmoney()
                                                        .then((value) {
                                                      setState(() {
                                                        loading = false;
                                                      });
                                                      screentouch = false;
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: ((context) =>
                                                                  WalletEdu(
                                                                      amount:
                                                                          value))));
                                                    });
                                                  },
                                                ),
                                        ),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        IconButton(
                                            icon: Icon(Icons.thumb_up),
                                            onPressed: (() async {
                                              final mailtoLink = Mailto(
                                                to: [
                                                  'skilledge.contactus@gmail.com'
                                                ],
                                                cc: [
                                                  'ayushraghuvanshi03@gmail.com',
                                                  'suhaillahmadd0@gmail.com',
                                                  'shreyanshagarwal.16.2022@gmail.com'
                                                ],
                                                subject:
                                                    'Contacting SkillEdge Team',
                                                body: 'Hello, My Issue is....',
                                              );
                                              // Convert the Mailto instance into a string.
                                              // Use either Dart's string interpolation
                                              // or the toString() method.
                                              print(mailtoLink);
                                              await launchUrl(
                                                  Uri.parse('$mailtoLink'));
                                            })),
                                        Text('Contact us')
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 54.0),
                                      child: Column(
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.logout),
                                            onPressed: () =>
                                                _showpopup(context),
                                          ),
                                          Text('Log out')
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
              ),
            ))));
  }

  _showpopup(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Log Out",
      desc: "Are you sure you want to log out?",
      buttons: [
        DialogButton(
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () async {
            var pref = await SharedPreferences.getInstance();
            await pref.setString("token", "");
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => GettingStarted(),
                ),
                (route) => false);
          },
          color: Colors.red,
        ),
        DialogButton(
          child: Text(
            "No",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.green,
        )
      ],
    ).show();
  }
}
