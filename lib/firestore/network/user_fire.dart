import 'package:audioroom/helper/print_log.dart';
import 'package:audioroom/firestore/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final _fs = FirebaseFirestore.instance;
  final _coll = 'tbl_user';

  UserService() {
    _fs.settings = const Settings(persistenceEnabled: true);
  }

  Query getUserQuery() {
    return FirebaseFirestore.instance
        .collection(_coll)
        .where("is_delete", isEqualTo: false);
  }

  Query getUserTopQuery() {
    return FirebaseFirestore.instance
        .collection(_coll)
        .where("is_delete", isEqualTo: false);
  }

  Future<List<UserModel>> getUsers() async {
    return await _fs
        .collection(_coll)
        .where("is_delete", isEqualTo: false)
        .get(GetOptions(source: Source.serverAndCache))
        .then((QuerySnapshot snapshot) {
      List<UserModel> userModels = [];
      if (snapshot != null &&
          snapshot.docs != null &&
          snapshot.docs.length > 0) {
        snapshot.docs.forEach((f) {
          UserModel userModel = UserModel.fromJson(f.data());
          userModel.refId = f.id;
          userModels.add(userModel);
        });
        return userModels;
      } else {
        return null;
      }
    });
  }

  Future<List<UserModel>> getUsersWithoutUser(String uId) async {
    return await _fs
        .collection(_coll)
        .where("is_delete", isEqualTo: false)
        .where("uid", isNotEqualTo: uId)
        .get(GetOptions(source: Source.serverAndCache))
        .then((QuerySnapshot snapshot) {
      List<UserModel> userModels = [];
      if (snapshot != null &&
          snapshot.docs != null &&
          snapshot.docs.length > 0) {
        snapshot.docs.forEach((f) {
          UserModel userModel = UserModel.fromJson(f.data());
          userModel.refId = f.id;
          userModels.add(userModel);
        });
        return userModels;
      } else {
        return null;
      }
    });
  }

  Future<UserModel> getUserByUserName(String userName) async {
    return await _fs
        .collection(_coll)
        .where("is_delete", isEqualTo: false)
        .where("tag_name", isEqualTo: userName)
        .get(GetOptions(source: Source.serverAndCache))
        .then((QuerySnapshot snapshot) {
      List<UserModel> userModels = [];
      if (snapshot != null &&
          snapshot.docs != null &&
          snapshot.docs.length > 0) {
        snapshot.docs.forEach((f) {
          UserModel userModel = UserModel.fromJson(f.data());
          userModel.refId = f.id;
          userModels.add(userModel);
        });
        return userModels[0];
      } else {
        return null;
      }
    });
  }

  Stream<UserModel> getUserByReferencesStream(String refId) {
    return Stream.fromFuture(getUserByReferences(refId));
  }

  Future<UserModel> getUserByReferences(String refId) async {
    DocumentReference reference = _fs.doc(_coll + '/' + refId);
    DocumentSnapshot snapshot = await _fs.doc(reference?.path ?? "").get();
    if (snapshot != null && snapshot.data() != null) {
      if (!UserModel.fromJson(snapshot.data()).isDelete) {
        UserModel userModel = UserModel.fromJson(snapshot.data());
        userModel.refId = snapshot.id;
        return userModel;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<void> createUser(UserModel userModel) async {
    await _fs
        .collection('/$_coll')
        .doc(userModel.uId.toString())
        .set(userModel.toJsonTimeStamp());
  }

  Future<int> updateUser(UserModel userModel) async {
    PrintLog.printMessage(
        "updateUser -> ${userModel.refId.toString()}  ${userModel.toJson().toString()}");
    await _fs
        .collection('/$_coll')
        .doc(userModel.refId.toString())
        .update(userModel.toJsonTimeStamp())
        .then((value) {
      return null;
    });
    return null;
  }
}
