import 'package:blood_donation/views/about_page.dart';
import 'package:blood_donation/views/admobe_ad.dart';
import 'package:blood_donation/views/front_page.dart';
import 'package:blood_donation/views/register_for_donation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> bloodgroupList = [
    "All",
    "AB+",
    "AB-",
    "O+",
    "O-",
    "A+",
    "A-",
    "B+",
    "B-"
  ];
  String selectedBloodGroup = "All";
  var searching_input;
  var logged = false;
  var Uid;
  var donation = false;
  var currentEmail = "";
  AdmobeHelper admobeHelper=new AdmobeHelper();

  _launchCaller(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<dynamic> getData() async {
    await FirebaseFirestore.instance
        .collection("Collection")
        .doc(Uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      var Donation = {};
      Donation = documentSnapshot.data();

      if (Donation["Donner"].toString() == "Yes") {
        setState(() {
          donation = true;
        });
      }
    });
  }

  @override
  void initState() {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    var uid = firebaseAuth.currentUser;
    setState(() {
      Uid = uid.uid;
      currentEmail = uid.email;
    });
    getData();
    admobeHelper.createInerAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
                child: Image.asset(
              'images/blood2.jpg',
              fit: BoxFit.cover,
              width: _width,
            )),
            SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    currentEmail,
                    style: TextStyle(fontSize: _width / 100 * 3),
                  ),
                  SizedBox(
                    height: _height / 100 * 4,
                  ),
                  donation
                      ? Container(
                          child: Column(
                          children: [
                            Text(
                              "Now you are a donner",
                                style: GoogleFonts.montserrat(fontSize: _width / 100 * 5)
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            /*InkWell(
                              child: Text(
                                "Edit",
                                style: TextStyle(
                                    fontSize: _width / 100 * 5,
                                    color: Colors.redAccent,
                                    decoration: TextDecoration.underline),
                              ),
                              onTap: () {
                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>Donation()));
                                Fluttertoast.showToast(
                                    msg: "This fetcher is coming soon...");
                              },
                            )*/
                          ],
                        ))
                      : Container(
                          width: 150,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side:
                                      BorderSide(width: 1.5, color: Colors.red),
                                )),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                elevation:
                                    MaterialStateProperty.all<double>(0.0)),
                            child: Text(
                              'Donor',
                              style: GoogleFonts.lato(fontSize: 20,color:Colors.grey)
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Donation()));
                              admobeHelper.showInterAd();
                            },
                          ),
                        ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 150,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(width: 1.5, color: Colors.red),
                          )),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          elevation: MaterialStateProperty.all<double>(0.0)),
                      child: Text(
                        'Share',
                          style: GoogleFonts.lato(fontSize: 20,color:Colors.grey)
                      ),
                      onPressed: () async {
                      await  FlutterShare.share(title: "Share",
                        text: "Share with your friends",
                          linkUrl: "https://play.google.com/store/apps/details?id=com.purelifep.unique.blood",
                          chooserTitle: "Where You Want to Share"

                        );
                      },
                    ),
                  ),
                  Container(
                    width: 150,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double>(0.0),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(width: 1.5, color: Colors.red),
                          )),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.redAccent)),
                      child: Text(
                        'About',
                          style: GoogleFonts.lato(fontSize: 20,color:Colors.white)
                      ),
                      onPressed: () {
                        Get.to(AboutPage());
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 150,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double>(0.0),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(width: 1.5, color: Colors.red),
                          )),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.redAccent)),
                      child: Text(
                        'Log Out',
                          style: GoogleFonts.lato(fontSize: 20,color:Colors.white)
                      ),
                      onPressed: () {
                        admobeHelper.showInterAd();
                        FirebaseAuth.instance.signOut().then((value) async {
                          SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.remove('mail');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FrontPage()));
                        });

                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: _height / 2 * 0.2 - 4,
              width: _width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(13),
                  bottomLeft: Radius.circular(13),
                ),
                color: Colors.redAccent[100],
              ),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Center(
                            child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: selectedBloodGroup,
                            items: bloodgroupList.map((e) {
                              return DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ));
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedBloodGroup = value;
                               // print(selectedBloodGroup);
                              });
                            },
                          ),
                        ))),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: TextFormField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              border: InputBorder.none,
                              hintText: 'Thana/Upazila'),
                          onChanged: (value) {
                            setState(() {
                              searching_input = value.trim().toString().toLowerCase();
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Builder(
                          builder: (con) {
                            return InkWell(
                              child: Icon(
                                Icons.list,
                                size: 28,
                              ),
                              onTap: () {
                               // admobeHelper.showInterAd();
                                Scaffold.of(con).openDrawer();
                              },
                            );
                          },
                        )),
                    // Expanded(flex: 1, child: ElevatedButton(child: Text('Admin'),)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                  child: StreamBuilder<QuerySnapshot>(
                stream: (searching_input == null ||
                        searching_input.toString().trim() == '')
                    ? FirebaseFirestore.instance
                        .collection(selectedBloodGroup)
                        .snapshots()
                    : FirebaseFirestore.instance
                        .collection(selectedBloodGroup)
                        .where('Index', arrayContains: searching_input)
                        .snapshots(),
                builder: (context, snapshort) {
                  if (snapshort.hasData) {
                    final List<DocumentSnapshot> documents =
                        snapshort.data.docs;
                    return documents.length==0?Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            height:100,
                            width: 100,
                            child: Image.asset("images/empty.gif")),
                        Container(child: Center(child: Text("No donner found for ($selectedBloodGroup) blood"),),),
                      ],
                    ): ListView(
                      children: documents.map((e) {
                        return Card(
                          child: ExpansionTile(
                            leading: CircleAvatar(
                                radius: 21,
                                backgroundColor: Colors.redAccent[100],
                                child: Text(
                                  e['BloodGroup'],
                                    style: GoogleFonts.lato(color: Colors.white,fontSize: _width/100*4)
                                )),
                            title: Text(e['Name'],
                                style: GoogleFonts.lato(color:Colors.black)
                            ),
                            subtitle: Row(
                              children: [
                                Expanded(
                                    flex: 1, child: Text(e['Thana_Upazila'],
                                    style: GoogleFonts.lato(color:Colors.black)
                                )),
                                Expanded(flex: 1, child: Text(e['Disrtict'],
                                    style: GoogleFonts.lato(color:Colors.black)
                                ))
                              ],
                            ),
                            children: [
                              ListTile(
                                title: Text(e['PhoneNumber'],
                                    style: GoogleFonts.lato(color:Colors.black)
                                ),
                                subtitle: e['Mail'] == ''
                                    ? Text('example@gmail.com')
                                    : SelectableText(e['Mail'],
                                    style: GoogleFonts.lato()
                                ),
                                trailing: InkWell(
                                  child: Icon(
                                    Icons.phone,
                                  ),
                                  onTap: () {
                                    _launchCaller('tel:${e['PhoneNumber']}');
                                  },
                                ),
                              )
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )),
            ),
          ],
        ),
      ),
    );
  }
}
