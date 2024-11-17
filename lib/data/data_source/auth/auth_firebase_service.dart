// dependency inversion - Trừu tượng hóa data_source nên repository sẽ không phu thuộc vào các Service
// Làm việc trực tiếp với FirebaseService
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_iot/data/models/auth/create_user_req.dart';
import 'package:smart_iot/data/models/auth/signin_user_req.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(CreateUserReq createUserReq);

  Future<Either> signIn(SignInUserReq signInUserReq);
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {

  @override
  Future<Either> signIn(SignInUserReq signInUserReq) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signInUserReq.email,
        password: signInUserReq.password,
      );
      return const Right("Sign In was successful");
    } on FirebaseAuthException catch (e) {
      String message = "Signup Failed";

      if(e.code == "invalid-email"){
        message = "Not user found for that email ";
      } else if (e.code == "invalid-credential") {
        message = "Wrong password provider for that user";
      }
      return Left(message);
    }
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    try {
      // Đăng kí người dùng FirebaseAuth
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserReq.email,
        password: createUserReq.password,
      );

      // Lưu thông tin người dùng vào collection FirebaseFirestore
      FirebaseFirestore.instance.collection("Users").add(
        {
          'name' : createUserReq.fullName,
          'email' : data.user?.email,
        }
      );

      return const Right("Signup was successful");
    } on FirebaseAuthException catch (e) {
      String message = "Signup Failed";

      if(e.code == "weak-password"){
        message = "The password provided is too weak";
      } else if (e.code == "email-already-in-use") {
        message = "An account already exists with that email";
      }
      return Left(message);
    }
  }
}
