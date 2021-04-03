import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:ChatApp/screens/profile1.dart';

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
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter OTP"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _codeController,
                ),
              ],
            ),
            actions: [
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
                  child: Text("Confirm"),
                  textColor: Colors.black)
            ],
          );
        },
      );
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
    return Scaffold(
        key: _scaffoldKey,
        body: Center(
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
                      borderSide: BorderSide(color: Colors.black, width: 0.0)),
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
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              onPressed: () {
                signInwithPhonenumber(context);
              },
            ),
          ],
        )));
  }
}
