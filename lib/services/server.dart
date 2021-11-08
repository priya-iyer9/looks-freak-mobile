import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:looksfreak/utils/user.dart';

enum AuthResponseCode { success, failed }
enum DbResponseCode { success, failed }

class DbResponse {
  DbResponseCode code;
  String message, insertedId;
  DbResponse({this.code, this.message, this.insertedId});
}

class AuthResponse {
  AuthResponseCode code;
  CustomUser user;
  String message;
  AuthResponse({this.code, this.user, this.message});
}

class CheckUserResponse {
  bool found;
  CustomUser user;
  CheckUserResponse({this.found, this.user});
}

class Server {
  FirebaseApp app;
  FirebaseFirestore fstore;
  CustomUser user;
  FirebaseAuth fauth;
  final BuildContext context;

  QueryDocumentSnapshot lastFetchedPost, lastFetchedJob, lastFetchedEvent;

  Server({@required this.context, @required this.app});

  createFstoreInstance() {
    fstore = FirebaseFirestore.instanceFor(app: app);
  }

  createFauthInstance() {
    fauth = FirebaseAuth.instanceFor(app: app);
  }

  setUser(CustomUser u) {
    this.user = u;
  }

  Future<AuthResponse> register(String email, String password) async {
    try {
      // final UserCredential res = (await fauth.createUserWithEmailAndPassword(
      //     email: email.trim(), password: password.trim()));
      UserCredential res = await fauth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (res.user != null) {
        return AuthResponse(
            code: AuthResponseCode.success,
            user: CustomUser(
              uid: res.user.uid,
              email: res.user.email,
            ));
      } else {
        return AuthResponse(code: AuthResponseCode.failed, message: "Error");
      }
    } on FirebaseAuthException catch (e) {
      return AuthResponse(code: AuthResponseCode.failed, message: e.code);
    }
  }

  Future<AuthResponse> login(String email, String password) async {
    try {
      final res = await fauth.signInWithEmailAndPassword(
          email: email, password: password);
      if (res.user.email != null) {
        final userinfo =
            await fstore.collection("users").doc(res.user.uid).get();
        if (userinfo.exists) {
          return AuthResponse(
              code: AuthResponseCode.success,
              user: CustomUser.fromJson(userinfo));
        } else {
          return AuthResponse(code: AuthResponseCode.failed, message: "Error");
        }
      }
    } on FirebaseAuthException catch (e) {
      return AuthResponse(code: AuthResponseCode.failed, message: e.code);
    }
    return AuthResponse(code: AuthResponseCode.failed);
  }

  Future<AuthResponse> forgotPassword(String email) async {
    try {
      await FirebaseAuth.instanceFor(app: app)
          .sendPasswordResetEmail(email: email);
      return AuthResponse(code: AuthResponseCode.success);
    } on FirebaseException catch (e) {
      return AuthResponse(code: AuthResponseCode.failed, message: e.code);
    }
  }

  Future<CheckUserResponse> checkUser(String uid) async {
    final res = await fstore.collection("users").doc(uid).get();
    if (res.exists && res.data().isNotEmpty) {
      return CheckUserResponse(
          found: true, user: CustomUser.fromJson(res.data()));
    }
    return CheckUserResponse(found: false);
  }

  Future<CheckUserResponse> checkUserByEmail(String email) async {
    final res =
        await fstore.collection("users").where("email", isEqualTo: email).get();
    if (res.docs.isNotEmpty) {
      return CheckUserResponse(
          found: true, user: CustomUser.fromJson(res.docs.first));
    }
    return CheckUserResponse(found: false);
  }

  Future<CheckUserResponse> checkUserByPhone(String phone) async {
    final res = await fstore
        .collection("users")
        .where("phonenumber", isEqualTo: phone)
        .get();
    if (res.docs.isNotEmpty) {
      return CheckUserResponse(
          found: true, user: CustomUser.fromJson(res.docs.first));
    }
    return CheckUserResponse(found: false);
  }

  Future<DbResponse> createUserRecord(CustomUser user) async {
    try {
      // final r = await fstore.collection('users').add(user.toJson());
      await fstore
          .collection("users")
          .doc(user.uid.toString())
          .set(user.toJson(), SetOptions(merge: true));
      return DbResponse(code: DbResponseCode.success, insertedId: user.uid);
    } on Exception catch (e) {
      return DbResponse(code: DbResponseCode.failed, message: e.toString());
    }
  }

  Future<DbResponse> updateUserRecord(CustomUser user) async {
    try {
      await fstore
          .collection('users')
          .doc(user.uid.toString())
          .set(user.toJson(), SetOptions(merge: true));
      return DbResponse(code: DbResponseCode.success);
    } on Exception catch (e) {
      return DbResponse(code: DbResponseCode.failed, message: e.toString());
    }
  }

  Future<List<CustomUser>> getUserRecord(CustomUser user) async {
    List<CustomUser> user = [];
    final res = await fstore.collection('users').limit(10).get();
    if (res.docs.length > 0) {
      res.docs.forEach((element) {
        // Utils.debugPrint(element.id);
        user.add(CustomUser.fromJson(element));
      });
    }
    return user;
  }

  Future<CustomUser> getUserById(String uid) async {
    final r = await fstore.collection("users").doc(uid).get();
    return CustomUser.fromJson(r);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser(String uid) {
    return fstore.collection("users").doc(uid).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamAppointments(
      CustomUser user) {
    return fstore
        .collection("appointments")
        .where("vendorid", isEqualTo: user.uid.toString())
        .where("vendoremail", isEqualTo: user.email.toString())
        .snapshots();
  }
}
