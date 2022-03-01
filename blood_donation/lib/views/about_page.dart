import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  _launchURL(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
        centerTitle: true,
        backgroundColor: Colors.redAccent[100],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("App Name: Blood Donation"),
              Text("Developed by BlueSky IT"),
              Text("Owner: Md Noman Molla"),
              Text("Version: 1.0.3"),
              SizedBox(
                height: 20,
              ),
              Text(
                  '''Human body is gift from Allah and Blood also. It's necessary for live.
If our blood can save a person, we should donate blood to him. Your blood can keep someone alive on this earth even after you die.

My small effort to help you in your time of danger. Forgive the error and contact us at the email below for any suggestions.
              '''),
              TextButton(
                  onPressed: () {
                    _launchURL('mollanoman2017@gmail.com',
                        'Write your subject here', 'Write your body here');
                  },
                  child: Text("Send Mail")),
              SizedBox(
                height: 20,
              ),
              Text("© 2021 BlueSky IT. All rights reserved")
            ],
          ),
        ),
      ),
    );
  }
}
