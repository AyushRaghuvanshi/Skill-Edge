
import 'package:flutter/material.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:skilledge/models/interest_model.dart';
import 'package:skilledge/models/profile_details_model.dart';
import 'package:skilledge/screens/dashboard.dart';

import 'package:skilledge/services/api_services.dart';
import 'package:skilledge/widgets/logo.dart';

class OnBoardinginterest extends StatefulWidget {
  const OnBoardinginterest(
      {super.key,
      this.edu,
      this.pfc,
      this.fullName,
      this.email,
      this.dob,
      this.userName,
      this.phone,
      this.gender});
  final pfc;
  final edu;
  final userName;
  final email;

  final fullName;
  final dob;
  final phone;
  final gender;
  @override
  State<OnBoardinginterest> createState() => _OnBoardinginterestState();
}

class _OnBoardinginterestState extends State<OnBoardinginterest> {
  late Profile_details_req req;

  bool b1 = true;
  bool b2 = true;
  bool b3 = true;
  bool b4 = true;
  bool b5 = true;
  bool b6 = true;
  bool b7 = true;
  bool b8 = true;
  bool b9 = true;
  bool b10 = true;
  bool b11 = true;
  int chosen_design = 0;
  bool loading = false;

  Interest_req int_req = Interest_req();

  @override
  void initState() {
    
    super.initState();
    req = Profile_details_req();
    // int_req = Interest_req();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
          child: _pagebuild(context), inAsyncCall: loading, blur: 0.5),
    );
  }

  
  Widget _pagebuild(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      Logo(),
                      CircleAvatar(
                        radius: 70,
                        foregroundImage: (widget.pfc != null)
                            ? FileImage(widget.pfc)
                            : NetworkImage(
                                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png')
                                as ImageProvider,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                            child: Text(
                          'Choose Your Interest',
                          style: TextStyle(fontSize: 34),
                        )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                b1 = !b1;
                                if (b1) {
                                  chosen_design++;
                                } else {
                                  chosen_design--;
                                }
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      (!b1) ? Color(0xFF01C5A6) : Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(
                                    color: Color(0xFF01C5A6),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Music",
                                  style: TextStyle(
                                      color: (!b1)
                                          ? Colors.white
                                          : Color(0xFF01C5A6)),
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                b2 = !b2;
                                if (b2) {
                                  chosen_design++;
                                } else {
                                  chosen_design--;
                                }
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      (!b2) ? Color(0xFF01C5A6) : Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(
                                    color: Color(0xFF01C5A6),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Business",
                                  style: TextStyle(
                                      color: (!b2)
                                          ? Colors.white
                                          : Color(0xFF01C5A6)),
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                b3 = !b3;
                                if (b3) {
                                  chosen_design++;
                                } else {
                                  chosen_design--;
                                }
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      (!b3) ? Color(0xFF01C5A6) : Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(
                                    color: Color(0xFF01C5A6),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Design",
                                  style: TextStyle(
                                      color: (!b3)
                                          ? Colors.white
                                          : Color(0xFF01C5A6)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                b4 = !b4;
                                if (b4) {
                                  chosen_design++;
                                } else {
                                  chosen_design--;
                                }
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      (!b4) ? Color(0xFF01C5A6) : Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(
                                    color: Color(0xFF01C5A6),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Technical &  Academics",
                                  style: TextStyle(
                                      color: (!b4)
                                          ? Colors.white
                                          : Color(0xFF01C5A6)),
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                b5 = !b5;
                                if (b5) {
                                  chosen_design++;
                                } else {
                                  chosen_design--;
                                }
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      (!b5) ? Color(0xFF01C5A6) : Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(
                                    color: Color(0xFF01C5A6),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "IT & Software",
                                  style: TextStyle(
                                      color: (!b5)
                                          ? Colors.white
                                          : Color(0xFF01C5A6)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                b6 = !b6;
                                if (b6) {
                                  chosen_design++;
                                } else {
                                  chosen_design--;
                                }
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      (!b6) ? Color(0xFF01C5A6) : Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(
                                    color: Color(0xFF01C5A6),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Office & Productivity",
                                  style: TextStyle(
                                      color: (!b6)
                                          ? Colors.white
                                          : Color(0xFF01C5A6)),
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                b7 = !b7;
                                if (b7) {
                                  chosen_design++;
                                } else {
                                  chosen_design--;
                                }
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      (!b7) ? Color(0xFF01C5A6) : Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(
                                    color: Color(0xFF01C5A6),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Healthness and Fitness",
                                  style: TextStyle(
                                      color: (!b7)
                                          ? Colors.white
                                          : Color(0xFF01C5A6)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                b8 = !b8;
                                if (b8) {
                                  chosen_design++;
                                } else {
                                  chosen_design--;
                                }
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      (!b8) ? Color(0xFF01C5A6) : Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(
                                    color: Color(0xFF01C5A6),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Finance",
                                  style: TextStyle(
                                      color: (!b8)
                                          ? Colors.white
                                          : Color(0xFF01C5A6)),
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                b9 = !b9;
                                if (b9) {
                                  chosen_design++;
                                } else {
                                  chosen_design--;
                                }
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      (!b9) ? Color(0xFF01C5A6) : Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(
                                    color: Color(0xFF01C5A6),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Marketing",
                                  style: TextStyle(
                                      color: (!b9)
                                          ? Colors.white
                                          : Color(0xFF01C5A6)),
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                b10 = !b10;
                                if (b10) {
                                  chosen_design++;
                                } else {
                                  chosen_design--;
                                }
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      (!b10) ? Color(0xFF01C5A6) : Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(
                                    color: Color(0xFF01C5A6),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Development",
                                  style: TextStyle(
                                      color: (!b10)
                                          ? Colors.white
                                          : Color(0xFF01C5A6)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                b11 = !b11;
                                if (b11) {
                                  chosen_design++;
                                } else {
                                  chosen_design--;
                                }
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      (!b11) ? Color(0xFF01C5A6) : Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(
                                    color: Color(0xFF01C5A6),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Personal & Development",
                                  style: TextStyle(
                                      color: (!b11)
                                          ? Colors.white
                                          : Color(0xFF01C5A6)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: const Color(0xFF01C5A6)),
                            onPressed: () {
                              if (chosen_design == 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Please Select Atleast 1 Interest')));
                              } else {
                                setState(() {
                                  loading = true;
                                });
                                API api = API();
                                req.name = widget.fullName;
                                req.dateOfBirth = widget.dob;
                                String g = "";
                                switch (widget.gender) {
                                  case "Male":
                                    g = "M";
                                    break;
                                  case "Female":
                                    g = "F";
                                    break;
                                  default:
                                    g = "O";
                                }
                                req.gender = g;
                                req.isEducator = widget.edu;
                                req.mobile = int.parse(
                                    widget.phone.toString().substring(1));
                                req.picture = widget.pfc;
                                req.userName = widget.userName;
                                print(req.toJson());
                                api.profile(req).then((value) {
                                  if (value.message != null) {
                                    setState(() {
                                      loading = false;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(value.message!)));
                                  } else {
                                    print("step1");
                                    int_req.interest1 = (!b10).toString();
                                    int_req.interest2 = (!b2).toString();
                                    int_req.interest3 = (!b8).toString();
                                    int_req.interest4 = (!b5).toString();
                                    int_req.interest5 = (!b6).toString();
                                    int_req.interest6 = (!b11).toString();
                                    int_req.interest7 = (!b3).toString();
                                    int_req.interest8 = (!b9).toString();
                                    int_req.interest9 = (!b7).toString();
                                    int_req.interest10 = (!b1).toString();
                                    int_req.interest11 = (!b4).toString();
                                    print(int_req.toJson());
                                    api.interest(int_req).then((value) {
                                      setState(() {
                                        loading = false;
                                      });
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  Dashboard())));
                                      print(value.toJson());
                                    });
                                  }
                                });
                              }
                            },
                            child: Container(
                                height: 38,
                                width: double.infinity,
                                child: Center(
                                  child: Text(
                                    'Continue',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: TextButton(
                            style: TextButton.styleFrom(
                                side: BorderSide(color: Color(0xFF01C5A6))),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                                height: 38,
                                width: double.infinity,
                                child: Center(
                                  child: Text(
                                    'Back',
                                    style: TextStyle(color: Color(0xFF01C5A6)),
                                  ),
                                ))),
                      )
                    ])))));
  }
}
