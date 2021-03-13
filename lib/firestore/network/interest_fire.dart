import 'dart:convert';

import 'package:audioroom/helper/print_log.dart';
import 'package:audioroom/firestore/model/interest_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InterestService {
  final _fs = FirebaseFirestore.instance;
  final _coll = 'tbl_interest';

  InterestService() {
    _fs.settings = const Settings(persistenceEnabled: true);
  }

  Query getInterestQuery() {
    return FirebaseFirestore.instance.collection(_coll);
  }

  Future<List<InterestModel>> getInterest() async {
    return await _fs
        .collection(_coll)
        .get(GetOptions(source: Source.serverAndCache))
        .then((QuerySnapshot snapshot) {
      List<InterestModel> interestModels = [];
      if (snapshot != null &&
          snapshot.docs != null &&
          snapshot.docs.length > 0) {
        snapshot.docs.forEach((f) {
          PrintLog.printMessage("getCourse -> " + jsonEncode(f.data()));
          InterestModel interestModel = InterestModel.fromJson(f.data());
          interestModel.refId = f.id;
          interestModels.add(interestModel);
        });
        return interestModels;
      } else {
        return null;
      }
    });
  }

  Future<String> createInterest(InterestModel interestModel) async {
    DocumentReference documentReference =
        await _fs.collection('/$_coll').add(interestModel.toJson());
    return documentReference.id;
  }

  Future<void> updateInterest(InterestModel interestModel) async {
    PrintLog.printMessage(
        "updateInterest -> ${interestModel.refId.toString()}  ${interestModel.toJson().toString()}");
    await _fs
        .collection('/$_coll')
        .doc(interestModel.refId.toString())
        .update(interestModel.toJson());
  }
}
