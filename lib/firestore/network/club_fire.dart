import 'dart:convert';

import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/helper/print_log.dart';
import 'package:audioroom/firestore/model/club_model.dart';
import 'package:audioroom/helper/validate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ClubService {
  final _fs = FirebaseFirestore.instance;
  final _coll = 'tbl_club';

  ClubService() {
    _fs.settings = const Settings(persistenceEnabled: true);
  }

  Query getClubByUIDQuery() {
    return FirebaseFirestore.instance.collection(_coll).where("user_list",
        arrayContains: FirebaseAuth.instance.currentUser.uid);
  }

  Query getClubQuery() {
    return FirebaseFirestore.instance.collection(_coll);
  }

  Future<List<ClubModel>> getClub() async {
    return await _fs
        .collection(_coll)
        .get(GetOptions(source: Source.serverAndCache))
        .then((QuerySnapshot snapshot) {
      List<ClubModel> clubModels = [];
      if (snapshot != null &&
          snapshot.docs != null &&
          snapshot.docs.length > 0) {
        snapshot.docs.forEach((f) {
          PrintLog.printMessage("getClub -> " + jsonEncode(f.data()));
          ClubModel clubModel = ClubModel.fromJson(f.data());
          clubModel.refId = f.id;
          clubModels.add(clubModel);
        });
        return clubModels;
      } else {
        return null;
      }
    });
  }

  Future<List<ClubModel>> getClubByUserId() async {
    return await _fs
        .collection(_coll)
        .where("user_list",
            arrayContains: FirebaseAuth.instance.currentUser.uid)
        .get(GetOptions(source: Source.serverAndCache))
        .then((QuerySnapshot snapshot) {
      List<ClubModel> clubModels = [];
      if (snapshot != null &&
          snapshot.docs != null &&
          snapshot.docs.length > 0) {
        snapshot.docs.forEach((f) {
          PrintLog.printMessage("getClub -> " + jsonEncode(f.data()));
          ClubModel clubModel = ClubModel.fromJson(f.data());
          clubModel.refId = f.id;
          clubModels.add(clubModel);
        });
        return clubModels;
      } else {
        return null;
      }
    });
  }

  Stream<ClubModel> getClubByReferencesStream(String refId) {
    return Stream.fromFuture(getClubByReferences(refId));
  }

  Future<ClubModel> getClubByReferences(String refId) async {
    DocumentReference reference = _fs.doc(_coll + '/' + refId);
    DocumentSnapshot snapshot = await _fs.doc(reference?.path ?? "").get();
    if (snapshot != null && snapshot.data() != null) {
      ClubModel clubModel = ClubModel.fromJson(snapshot.data());
      clubModel.refId = snapshot.id;
      return clubModel;
    } else {
      return null;
    }
  }

  Future<void> createClub(ClubModel clubModel) async {
    PrintLog.printMessage("clubmodel -> " + clubModel.toJson().toString());
    DocumentReference reference = _fs.doc(
        _coll + '/' + clubModel.clubName.toLowerCase().replaceAll(" ", "_"));
    DocumentSnapshot snapshot = await _fs.doc(reference?.path ?? "").get();
    if (snapshot == null || snapshot.data() == null) {
      await _fs
          .collection('/$_coll')
          .doc(clubModel.clubName.toLowerCase().replaceAll(" ", "_"))
          .set(clubModel.toJson());
    } else {
      showToast(AppConstants.str_clubName_is_already_used);
    }
  }

  Future<void> updateClub(ClubModel clubModel) async {
    PrintLog.printMessage(
        "updateClub -> ${clubModel.refId.toString()}  ${clubModel.toJson().toString()}");
    await _fs
        .collection('/$_coll')
        .doc(clubModel.refId)
        .update(clubModel.toJson());
  }
}
