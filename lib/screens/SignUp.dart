import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:ChatApp/screens/profile1.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  String _verificationId;
  final SmsAutoFill _autoFill = SmsAutoFill();

  @override
  void initState() {
    _phoneNoController.text = "+91 90049 39490";
    _codeController.text = "123456";
    super.initState();
  }

  Stream<String> get onAuthStateChanged => _auth.authStateChanges().map(
        (User user) => user?.uid,
      );

  void showSnackbar(String message, BuildContext context) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        width: MediaQuery.of(context).size.width - 50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }

  Future<void> dialog(var verificationId) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Text("Enter OTP",
              style: GoogleFonts.montserrat(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 10.0,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0)),
                  contentPadding: const EdgeInsets.only(
                      left: 14.0, bottom: 10.0, top: 10.0),
                ),
                controller: _codeController,
              ),
            ],
          ),
          actions: [
            Icon(Icons.done, color: Colors.black, size: 30),
            FlatButton(
                onPressed: () async {
                  PhoneAuthCredential phoneAuthCredential =
                      PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: "123456",
                  ); //_codeController.text.trim());
                  await _auth.signInWithCredential(phoneAuthCredential);
                  Navigator.of(context).pop();
                  showSnackbar(
                      "Phone number automatically verified and user signed in: ${_auth.currentUser.uid}",
                      context);
                  // Copy the navigation code from varification completed
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Profile(_phoneNoController.text)));
                },
                child: Text(
                  "CONFIRM",
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                textColor: Colors.black)
          ],
        );
      },
    );
  }

  void signInwithPhonenumber(BuildContext context) async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      Navigator.of(context).pop();
      await _auth.signInWithCredential(phoneAuthCredential);
      showSnackbar(
          "Phone number automatically verified and user signed in: ${_auth.currentUser.uid}",
          context);
      // Navigation to home screen (profile setup section)

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Profile(_phoneNoController.text)));
      // verification is done only through auto code retreival
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      showSnackbar(
          'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}',
          context);
      print(
          'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
    };
    PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      showSnackbar(
          'Please check your phone for the verification code.', context);
      _verificationId = verificationId;
      dialog(verificationId);
    };
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      showSnackbar("verification code: " + verificationId, context);
      _verificationId = verificationId;
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: _phoneNoController.text,
          timeout: const Duration(seconds: 30),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      showSnackbar(" Failed to Verify Phone Number: $e ", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xffFFD400), Color(0xffFFDD3C)])),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Stack(
                  children: [
                    ClipPath(
                      clipper: DrawClip(),
                      child: Container(
                        height: 560,
                        width: size.width - 50,
                        color: Colors.white,
                      ),
                    ),
                    /*Positioned(
                    right: 5,
                    child: Container(
                      width: 150,
                      height: 150,
                      child: Image( image: AssetImage('Assets/Icons/TrialLogo2.jpg'),fit: BoxFit.fill,),
                    ),
                  ),*/
                    Positioned(
                      left: 30,
                      top: 150,
                      child: Text(
                        "Login",
                        style: GoogleFonts.montserrat(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            shadows: [
                              Shadow(
                                color: Colors.grey.shade500,
                                offset: Offset(3.0, 3.0),
                                blurRadius: 3.0,
                              ),
                              Shadow(
                                color: Colors.white,
                                offset: Offset(-3.0, 3.0),
                                blurRadius: 3.0,
                              ),
                            ]),
                      ),
                    ),
                    Positioned(
                      left: 30,
                      top: 250,
                      child: Material(
                        elevation: 10,
                        child: Container(
                          width: 320,
                          child: TextFormField(
                            style: GoogleFonts.roboto(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            initialValue:
                                _phoneNoController == null ? "+91 " : null,
                            keyboardType: TextInputType.numberWithOptions(),
                            controller: _phoneNoController,
                            decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.phone, color: Colors.black),
                              labelStyle: GoogleFonts.montserrat(
                                color: Colors.black.withOpacity(0.7),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                              labelText: "Phone Number",
                              hintText: "+91 xxxx xxxxxx ",
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0)),
                              contentPadding: const EdgeInsets.only(
                                  left: 14.0, bottom: 10.0, top: 10.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 125,
                      top: 330,
                      child: Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        elevation: 0,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          color: Colors.orange[600],
                          textColor: Colors.black,
                          child: Text(
                            " VERIFY",
                            style: TextStyle(
                                fontSize: 30.0, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            signInwithPhonenumber(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 50);
    path.quadraticBezierTo(0, 0, 50, 30);
    path.lineTo(size.width, size.height / 3);
    path.lineTo(size.width, size.height - 50);
    path.quadraticBezierTo(
        size.width, size.height, size.width - 50, size.height - 30);
    path.lineTo(0, size.height * 2 / 3);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

/*Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                child: TextFormField(
                  initialValue: _phoneNoController == null ? "+91 " : null,
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: _phoneNoController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                    hintText: "+91 xxxx xxxxxx ",
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 0.0)),
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 10.0, top: 10.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                color: Colors.orange[100],
                textColor: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    " Verify ",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () {
                  signInwithPhonenumber(context);
                },
              ),
            ],
          ),
        ), */
