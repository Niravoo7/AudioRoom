import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/helper/print_log.dart';
import 'package:audioroom/firestore/model/room_model.dart';
import 'package:audioroom/helper/validate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RoomService {
  final _fs = FirebaseFirestore.instance;
  final _coll = 'tbl_room';

  RoomService() {
    _fs.settings = const Settings(persistenceEnabled: true);
  }

  Query getRoomQueryTop(int index) {
    if (index == 0) {
      return FirebaseFirestore.instance
          .collection(_coll)
          .where("people", arrayContains: FirebaseAuth.instance.currentUser.uid)
          .limit(3);
    } else {
      return FirebaseFirestore.instance
          .collection(_coll)
          .where("people", isNull: true);
    }
  }

  Query getRoomQueryHide() {
    return FirebaseFirestore.instance
        .collection(_coll)
        .where("hide_people", arrayContains: FirebaseAuth.instance.currentUser.uid);
  }

  Future<List<RoomModel>> getRoom() async {
    return await _fs
        .collection(_coll)
        .get(GetOptions(source: Source.serverAndCache))
        .then((QuerySnapshot snapshot) {
      List<RoomModel> roomModels = [];
      if (snapshot != null &&
          snapshot.docs != null &&
          snapshot.docs.length > 0) {
        snapshot.docs.forEach((f) {
          RoomModel roomModel = RoomModel.fromJson(f.data());
          roomModel.refId = f.id;
          roomModels.add(roomModel);
        });
        return roomModels;
      } else {
        return null;
      }
    });
  }

  Future<RoomModel> getRoomByReferences(String refId) async {
    DocumentReference reference = _fs.doc(_coll + '/' + refId);
    DocumentSnapshot snapshot = await _fs.doc(reference?.path ?? "").get();
    if (snapshot != null && snapshot.data() != null) {
      RoomModel roomModel = RoomModel.fromJson(snapshot.data());
      roomModel.refId = snapshot.id;
      return roomModel;
    } else {
      return null;
    }
  }

  Stream<RoomModel> getRoomByReferencesStream(String refId) {
    return Stream.fromFuture(getRoomByReferences(refId));
  }

  Future<String> createRoom(RoomModel roomModel) async {
    DocumentReference reference = _fs.doc(_coll + '/' + roomModel.channelName);
    DocumentSnapshot snapshot = await _fs.doc(reference?.path ?? "").get();
    if (snapshot == null || snapshot.data() == null) {
      await _fs
          .collection('/$_coll')
          .doc(roomModel.channelName)
          .set(roomModel.toJsonTimeStamp());
      return roomModel.channelName;
    } else {
      showToast(AppConstants.str_roomName_is_already_used);
      return null;
    }
  }

  Future<void> updateRoom(RoomModel roomModel) async {
    PrintLog.printMessage(
        "updateRoom -> ${roomModel.refId.toString()}  ${roomModel.toJson().toString()}");
    await _fs
        .collection('/$_coll')
        .doc(roomModel.channelName)
        .update(roomModel.toJsonTimeStamp());
  }

  Future<void> deleteRoom(String refID) async {
    await _fs.collection('/$_coll').doc(refID).delete();
  }
}
