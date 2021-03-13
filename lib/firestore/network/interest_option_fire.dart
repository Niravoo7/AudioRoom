import 'dart:convert';

import 'package:audioroom/firestore/model/interest_option_model.dart';
import 'package:audioroom/helper/print_log.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InterestOptionService {
  final _fs = FirebaseFirestore.instance;
  final _coll = 'tbl_interest';
  final _collSub = 'tbl_interest_options';

  InterestOptionService() {
    _fs.settings = const Settings(persistenceEnabled: true);
  }

  Query getInterestOptionQuery(String interestId) {
    return FirebaseFirestore.instance
        .collection(_coll)
        .doc(interestId)
        .collection(_collSub);
  }

  Future<List<InterestOptionModel>> getInterestOption(String interestId) async {
    return await _fs
        .collection(_coll)
        .doc(interestId)
        .collection(_collSub)
        .get(GetOptions(source: Source.serverAndCache))
        .then((QuerySnapshot snapshot) {
      List<InterestOptionModel> interestOptionModels = [];
      if (snapshot != null &&
          snapshot.docs != null &&
          snapshot.docs.length > 0) {
        snapshot.docs.forEach((f) {
          PrintLog.printMessage("getInterestOption -> " + jsonEncode(f.data()));
          InterestOptionModel interestOptionModel =
              InterestOptionModel.fromJson(f.data());
          interestOptionModel.refId = f.id;
          interestOptionModels.add(interestOptionModel);
        });
        return interestOptionModels;
      } else {
        return null;
      }
    });
  }

  Future<String> createInterestOption(
      String interestId, InterestOptionModel interestOptionModel) async {
    DocumentReference documentReference = await _fs
        .collection('/$_coll')
        .doc(interestId)
        .collection(_collSub)
        .add(interestOptionModel.toJson());
    return documentReference.id;
  }

  Future<void> updateInterestOption(
      String interestId, InterestOptionModel interestOptionModel) async {
    PrintLog.printMessage(
        "updateInterestOption -> ${interestOptionModel.refId.toString()}  ${interestOptionModel.toJson().toString()}");
    await _fs
        .collection('/$_coll')
        .doc(interestId)
        .collection(_collSub)
        .doc(interestOptionModel.refId.toString())
        .update(interestOptionModel.toJson());
  }
}
