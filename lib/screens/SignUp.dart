import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _phoneNoController = TextEditingController();
  String _verificationId;

  Stream<String> get onAuthStateChanged => _auth.authStateChanges().map(
        (User user) => user?.uid,
      );

  void showSnackbar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  void signInwithPhonenumber() async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await _auth.signInWithCredential(phoneAuthCredential);
      showSnackbar(
          "Phone number automatically verified and user signed in: ${_auth.currentUser.uid}");
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      showSnackbar(
          'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
    };
    PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      showSnackbar('Please check your phone for the verification code.');
      _verificationId = verificationId;
    };
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      showSnackbar("verification code: " + verificationId);
      _verificationId = verificationId;
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: _phoneNoController.text,
          timeout: const Duration(seconds: 10),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      showSnackbar(" Failed to Verify Phone Number: $e ");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width -50,
          child: TextFormField(
            keyboardType: TextInputType.numberWithOptions(),
            controller: _phoneNoController,
            decoration: InputDecoration(
              icon: Icon(Icons.phone_android),
              hintText: "Phone Number",
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 0.0)),
              contentPadding:
                  const EdgeInsets.only(left: 14.0, bottom: 10.0, top: 10.0),
            ),
          ),
        ),
        SizedBox(height: 20),
        RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          color: Colors.orange[100],
          textColor: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              " Verify ",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          onPressed: signInwithPhonenumber,
        ),
      ],
    ));
  }
}
