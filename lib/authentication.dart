import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'login.dart';
import 'userClass.dart';

class AuthenticationService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signupProcess(String email, String password, String name,
      String surname, String interest, String age,int point) async {
    if (email.trim().isEmpty || !email.trim().contains("@")) {
      return "Please enter a valid email address";
    }
    if (password.trim().length < 6) {
      return "Password must be at least 6 characters long";
    }
    if (name.trim().length < 3) {
      return "Name must be at least 3 characters long";
    }

    try {
      print("Inputs are verified");

      // with e-mail and password the authentication user is generated
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user.uid)
          .set(
        {
          "name": name.trim(),
          "surname": surname.trim(),
          "interest": interest.trim(),
          "age": age,
          "point":point,
        },
      );

      return "Correct";
    } on FirebaseAuthException catch (err) {
      var message = "An error occured, please check your credentials!";

      if (err.message != null) {
        message = err.message;
      }
      throw message;
    } catch (err) {
      throw err.message;
    }
  }

  Future<userClass> signInProccess(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      var user = await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user.uid)
          .get();

      userClass newUser = new userClass(
        email: userCredential.user.email,
        id: userCredential.user.uid,
        name: user["name"],
        surname: user["surname"],
        interest: user["interest"],
        age: user["age"],
      );

      return newUser;
    } on FirebaseAuthException catch (err) {
      var message = "An error occured, please check your credentials!";

      if (err.code != null) {
        message = err.code;
      }
      throw message;
    } catch (err) {
      throw err.code;
    }
  }

  Future<String> updateUserInfo(String id, String name, String surname,
      String interest, String age) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(id).update({
        'name': name,
        'interest': interest,
        'surname': surname,
        'age': age,
      });

      return 'Correct';
    } on FirebaseAuthException catch (err) {
      var message = "An error occured, please check your credentials!";

      if (err.code != null) {
        message = err.code;
      }
      throw message;
    } catch (err) {
      throw err.code;
    }
  }

  Future<String> updateIsRated(String id, bool is_rated) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(Login.newUser.id)
          .collection('recent_trips')
          .doc(id)
          .update({
        'is_rated': is_rated,
      });

      return 'Correct';
    } on FirebaseAuthException catch (err) {
      var message = "An error occured, please check your credentials!";

      if (err.code != null) {
        message = err.code;
      }
      throw message;
    } catch (err) {
      throw err.code;
    }
  }
  Future<String> updateUserInfo2(int point) async {
    var temp = await FirebaseFirestore.instance
        .collection('users')
        .get();

    int d=0;
    temp.docs.forEach((doc) {
      if (doc["name"] == Login.newUser.name&&doc["surname"]==Login.newUser.surname) {
        print("firebase10");
        d=doc["point"];
        d+=point;
      }
    });

    try {
      await FirebaseFirestore.instance.collection('users').doc(Login.newUser.id).update({

        'point': d,
      });

      return 'Correct';
    } on FirebaseAuthException catch (err) {
      var message = "An error occured, please check your credentials!";

      if (err.code != null) {
        message = err.code;
      }
      throw message;
    } catch (err) {
      throw err.code;
    }
  }

  Future<String> addToQR(
      String category, String name, int point,String url) async {
    DocumentReference ref = FirebaseFirestore.instance
        .collection("users")
        .doc(Login.newUser.id)
        .collection('QR')
        .doc();

    ref.set({
      "category": category,
      "name": name,
      "point": point,
      "url": url,
    });
  }

  Future<String> addtoRecentTours(
      String tour_name, double tour_rate, double rate_number) async {
    DocumentReference ref = FirebaseFirestore.instance
        .collection("users")
        .doc(Login.newUser.id)
        .collection('recent_trips')
        .doc();

    ref.set({
      "tour_id": ref.id,
      "tour_name": tour_name,
      "is_rated": false,
    });
  }

  Future<String> updateRating(String id, tour_rate, rate_number) async {
    try {
      await FirebaseFirestore.instance.collection('tours').doc(id).update({
        'tour_rate': tour_rate,
        'rate_number': rate_number,
      });

      return 'Correct';
    } on FirebaseAuthException catch (err) {
      var message = "An error occured, please check your credentials!";

      if (err.code != null) {
        message = err.code;
      }
      throw message;
    } catch (err) {
      throw err.code;
    }
  }
}
