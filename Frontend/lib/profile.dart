// ignore_for_file: sort_child_properties_last

// import 'dart:html';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/urls.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'scrollercontroller.dart';
import 'support_pages/customButtons.dart';

class PatientProfile extends StatefulWidget {
  final user;
  final Function updateName;
  const PatientProfile({Key? key, this.user,required this.updateName}) : super(key: key);
  @override
  State<PatientProfile> createState() => _MyAppState();
}

class _MyAppState extends State<PatientProfile> {

  late String _firstname = "";
  late String _lastname = "";
  late String _email = "";
  late String _dob = "";
  late String _mobile = "";
  late String _medhist = "";
  late String _password = "";
  late String _cert = "";
  late String _token = "";
  late String _passworddupe = _password;

  @override
  void initState() {
    print("state started");
    Future futureData = getUserData(widget.user);
    futureData.then((value) {
      print("value is" + json.decode(value)['firstname']);
      _firstname = json.decode(value)['firstname'];
      _lastname = json.decode(value)['lastname'];
      _password = json.decode(value)['password'];
      _passworddupe = _password;
      _email = json.decode(value)['email'];
      _dob = json.decode(value)['dob'];
      _mobile = json.decode(value)['mobilenumber'];
      _medhist = json.decode(value)['medicalhistory'];
      _cert = json.decode(value)['certificate'];
      _token = widget.user.value['Authorization'];
      textControllers['firstname']!.text = _firstname;
      textControllers['lastname']!.text = _lastname;
      textControllers['password']!.text = "";
      textControllers['confirmPassword']!.text = "";
      textControllers['email']!.text = _email;
      textControllers['dob']!.text = _dob;
      textControllers['mobile']!.text = _mobile;
      textControllers['medhist']!.text = _medhist;
      textControllers['certificate']!.text = _cert;
    });
  }

  final _formKey = GlobalKey<FormState>();
  Map<String, double> editButtonDetails = {
    'width': 60.0,
    'height': 25.0,
    'fontSize': 12
  };


  late Map<String, TextEditingController> textControllers = {
    'firstname': TextEditingController(text: _firstname),
    'lastname': TextEditingController(text: _lastname),
    'password': TextEditingController(text: ''),
    'confirmPassword': TextEditingController(text: ''),
    'email': TextEditingController(text: _email),
    'dob': TextEditingController(text: _dob),
    'mobile': TextEditingController(text: _mobile),
    'medhist': TextEditingController(text: _medhist),
    'certificate': TextEditingController(text: _cert)
  };

  Map<String, EdgeInsetsGeometry> textInset = {
    'firstname': const EdgeInsets.fromLTRB(30, 4, 4, 4),
    'lastname': const EdgeInsets.fromLTRB(31, 4, 4, 4),
    'password': const EdgeInsets.fromLTRB(70, 4, 4, 4),
    'confirmPassword': const EdgeInsets.fromLTRB(10, 4, 4, 0),
    'email': const EdgeInsets.fromLTRB(69, 4, 4, 4),
    'dob': const EdgeInsets.fromLTRB(17, 4, 4, 4),
    'mobile': const EdgeInsets.fromLTRB(31, 4, 4, 4),
    'medhist': const EdgeInsets.fromLTRB(30, 4, 4, 4),
    'certificate': const EdgeInsets.fromLTRB(30, 4, 4, 4),
  };


  // Variables
  bool enabledStatus = false;
  Color textBoxSelectedColor = Color.fromRGBO(201, 217, 214, 1);
  Color textBoxNotSelectedColor = Color.fromRGBO(224, 224, 224, 1);
  Color textBoxBackgrounds = Color.fromRGBO(224, 224, 224, 1);

  final double editButtonPadding = 2.0;
  Color itemColor = Colors.black;
  double itemTitleFontSize = 16;
  double itemFontSize = 18;
  double textBoxWidth = 200;
  int passwordMaxLength = 255;
  int passwordMinLength = 7;
  double mainEdgeInset = 16.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: DefaultAppbar(appbarText: "Profile",onPressed: () async {Navigator.pop(context);}),
        body: SingleChildScrollView (
            controller: AdjustableScrollController(100),
            child: Padding(
              padding: EdgeInsets.all(mainEdgeInset),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: <Widget>[
                            const Icon(Icons.email_outlined),
                            ProfileLabel(text:'Email',itemColor: itemColor, itemTitleFontSize:itemTitleFontSize),
                          ]
                        ),
                        ProfileInput(textInset: textInset['email']!,textBoxWidth:textBoxWidth,textBoxBackgrounds:textBoxNotSelectedColor,
                            textController: textControllers['email']!,enabledStatus: false),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: <Widget>[
                            const Icon(Icons.person_outlined),
                            ProfileLabel(text:'First Name',itemColor: itemColor, itemTitleFontSize:itemTitleFontSize),
                            ]
                        ),

                        ProfileInput(textInset: textInset['firstname']!,textBoxWidth:textBoxWidth,textBoxBackgrounds:textBoxBackgrounds,
                            textController: textControllers['firstname']!,enabledStatus: enabledStatus),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                            children: <Widget>[
                              const Icon(Icons.person),
                              ProfileLabel(text:'Last Name',itemColor: itemColor, itemTitleFontSize:itemTitleFontSize),

                          ],
                        ),

                        ProfileInput(textInset: textInset['lastname']!,textBoxWidth:textBoxWidth,textBoxBackgrounds:textBoxBackgrounds,
                            textController: textControllers['lastname']!,enabledStatus: enabledStatus),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: <Widget>[
                            const Icon(Icons.calendar_month_rounded),
                            ProfileLabel(text:'Date Of Birth',itemColor: itemColor, itemTitleFontSize:itemTitleFontSize),

                          ],
                        ),

                        Padding(
                          padding: textInset['dob']!,
                          child: SizedBox(
                            width: textBoxWidth,
                            child: TextFormField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: textBoxBackgrounds,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                ),
                                controller: textControllers['dob'],
                                enabled: enabledStatus,
                                onTap: () async {
                                  if (enabledStatus) {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime.now());
                                    if (pickedDate != null) {
                                      String newDOB = DateFormat('dd-MM-yyyy')
                                          .format(pickedDate);
                                      setState(() {
                                        textControllers["dob"] =
                                            TextEditingController(text: newDOB);
                                      });
                                    }
                                  }
                                }),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: <Widget>[
                            const Icon(Icons.local_phone_rounded),
                            ProfileLabel(text:'Mobile No.',itemColor: itemColor, itemTitleFontSize:itemTitleFontSize),
                          ],
                        ),

                        ProfileInput(textInset: textInset['mobile']!,textBoxWidth:textBoxWidth,textBoxBackgrounds:textBoxBackgrounds,
                            textController: textControllers['mobile']!,enabledStatus: enabledStatus),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.newspaper_outlined),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(6, 4, 4, 4),
                          child: widget.user.value['usertype'] == "doctor"
                              ? Text(
                            'Doctor Certificates',
                            style: TextStyle(
                                color: itemColor,
                                fontSize: itemTitleFontSize),
                          )
                              : Text(
                            'Medical History',
                            style: TextStyle(
                                color: itemColor,
                                fontSize: itemTitleFontSize),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                      child: Container(
                          width: double.infinity,
                          color: textBoxBackgrounds,
                          child: widget.user.value['usertype'] == "doctor"
                              ? TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                              )
                            ),
                            maxLines: 5,
                            controller: textControllers['certificate'],
                            enabled: enabledStatus,
                          )
                              : TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),
                            maxLines: 5,
                            controller: textControllers['medhist'],
                            enabled: enabledStatus,
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.lock_outline_rounded),
                        ProfileLabel(text:'Password',itemColor: itemColor, itemTitleFontSize:itemTitleFontSize),
                        Padding(
                          padding: textInset['password']!,
                          child: SizedBox(
                            height:65,
                            width: 180,
                            child: TextFormField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                  filled: true,
                                  fillColor: textBoxBackgrounds,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                ),
                                controller: textControllers['password'],
                                obscureText: true,
                                enabled: enabledStatus,
                                validator: (value) {
                                  if (value == null ||
                                      value.length < passwordMinLength ||
                                      value.length > passwordMaxLength) {
                                    return 'This password does not match with the inputted password';
                                  } else {
                                    return null;
                                  }
                                }
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.lock_outline_rounded),
                        ProfileLabel(text:'Confirm password',itemColor: itemColor, itemTitleFontSize:itemTitleFontSize),
                        Padding(
                          padding: textInset['confirmPassword']!,
                          child: SizedBox(
                            height:65,
                            width: 180,
                            child: TextFormField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                  filled: true,
                                  fillColor: textBoxBackgrounds,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                ),
                                controller: textControllers['confirmPassword'],
                                obscureText: true,
                                enabled: enabledStatus,
                                validator: (value) {
                                  if (value == null ||
                                      value.length < passwordMinLength ||
                                      value.length > passwordMaxLength ||
                                      value != textControllers['password']!.text) {
                                    return 'Passwords do not match';
                                  } else {
                                    return null;
                                  }
                                }
                            ),
                          ),
                        ),
                      ],
                    ),Padding(
                      padding: EdgeInsets.all(editButtonPadding),
                      child: SizedBox(
                        width: editButtonDetails['width'], // <-- match_parent
                        height:
                        editButtonDetails['height'], // <-- match-parent
                        child: SizedBox(
                            child:IconButton(
                              padding: EdgeInsets.all(0),
                              iconSize: 40,
                              icon: enabledStatus
                                  ? const Icon(Icons.save_outlined)
                                  : const Icon(Icons.create_outlined),
                              color: Colors.blue,
                              onPressed: () {
                                setState(() {
                                  enabledStatus = !enabledStatus;
                                  print("User Type is: "+widget.user.value['usertype']);
                                  if (enabledStatus) {
                                    textBoxBackgrounds = textBoxSelectedColor;
                                    // do nothing
                                  } else {
                                    textBoxBackgrounds = textBoxNotSelectedColor;
                                    print("Has the token," +_token.toString());
                                    if (_formKey.currentState!.validate()) {
                                      Future response = putProfileData(textControllers, widget.user.value['usertype'], _token);
                                    } else {
                                      print("The duplicated password is: "+_passworddupe.toString());
                                      textControllers['password']!.text =
                                          _passworddupe;
                                      Future response = putProfileData(
                                          textControllers, widget.user.value['usertype'], _token);
                                      textControllers['password']!.text = '';
                                      textControllers['password']!.text = textControllers['password']!.text;
                                    }
                                    widget.updateName(textControllers['firstname']!.text);
                                  }
                                });
                              },
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            )
        )
            ),
    );
  }
}

Future<Response> putProfileData(
    Map<String, TextEditingController> textControlDict, userType, token) async {
  Response response;

  if (userType == "doctor") {
    String uri = "$api:$profile_port/doctor/profile";
    final url = Uri.parse(uri);
    response = await put(url,
        headers: {
          'Accept': 'application/json',
          'content-type': 'application/json',
          'Authorization': token
        },
        body: jsonEncode(<String, String>{
          'firstname': textControlDict['firstname']!.text,
          'lastname': textControlDict['lastname']!.text,
          'email': textControlDict['email']!.text,
          'dob': textControlDict['dob']!.text,
          'password': textControlDict['password']!.text,
          'mobilenumber': textControlDict['mobile']!.text,
          'certificate': textControlDict['certificate']!.text,
        }));
  } else {
    String uri = "$api:$profile_port/patient/profile";
    final url = Uri.parse(uri);
    print(textControlDict['password']!.text);
    response = await put(url,
        headers: {
          'Accept': 'application/json',
          'content-type': 'application/json',
          'Authorization': token
        },
        body: jsonEncode(<String, String>{
          'firstname': textControlDict['firstname']!.text,
          'lastname': textControlDict['lastname']!.text,
          'email': textControlDict['email']!.text,
          'dob': textControlDict['dob']!.text,
          'password': textControlDict['password']!.text,
          'mobilenumber': textControlDict['mobile']!.text,
          'medicalhistory': textControlDict['medhist']!.text,
        }));
  }

  if (response.statusCode == 200 || response.statusCode == 202) {
    print("success response");
    return response;
  } else {
    print(response.headers);
  }
  return response;
}

// Adds

Future<String> getUserData(user) async {
  // construct the request
  String uri = "$api:$profile_port/";
  String typeUri = "doctor/profile/";
  if(user.value['usertype']=='patient') {
    typeUri = "patient/profile/";
  }
  uri = uri + typeUri + user.value["uid"].toString();
  final url = Uri.parse(uri);
  print(user.value["password"]);
  print(url);
  final Response response = await get(url,
      headers: {
        'Accept': 'application/json',
        'content-type': 'application/json',
        'Authorization': user.value["Authorization"]
      });
  if (response.statusCode == 200) {
    print(json.decode(response.body));
    return response.body;
  } else {
    print(response.statusCode);
    throw Exception("Error getting profile data");
  }
}