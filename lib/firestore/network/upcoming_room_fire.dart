import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/helper/print_log.dart';
import 'package:audioroom/firestore/model/upcoming_room_model.dart';
import 'package:audioroom/helper/validate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpcomingRoomService {
  final _fs = FirebaseFirestore.instance;
  final _coll = 'tbl_upcoming_room';

  UpcomingRoomService() {
    _fs.settings = const Settings(persistenceEnabled: true);
  }

  Query getUpcomingRoomQueryTop(int index) {
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

  Query getUpcomingRoomQueryHide() {
    return FirebaseFirestore.instance.collection(_coll).where("hide_people",
        arrayContains: FirebaseAuth.instance.currentUser.uid);
  }

  Future<List<UpcomingRoomModel>> getUpcomingRoom() async {
    return await _fs
        .collection(_coll)
        .get(GetOptions(source: Source.serverAndCache))
        .then((QuerySnapshot snapshot) {
      List<UpcomingRoomModel> roomModels = [];
      if (snapshot != null &&
          snapshot.docs != null &&
          snapshot.docs.length > 0) {
        snapshot.docs.forEach((f) {
          UpcomingRoomModel roomModel = UpcomingRoomModel.fromJson(f.data());
          roomModel.refId = f.id;
          roomModels.add(roomModel);
        });
        return roomModels;
      } else {
        return null;
      }
    });
  }

  Future<UpcomingRoomModel> getUpcomingRoomByReferences(String refId) async {
    DocumentReference reference = _fs.doc(_coll + '/' + refId);
    DocumentSnapshot snapshot = await _fs.doc(reference?.path ?? "").get();
    if (snapshot != null && snapshot.data() != null) {
      UpcomingRoomModel roomModel = UpcomingRoomModel.fromJson(snapshot.data());
      roomModel.refId = snapshot.id;
      return roomModel;
    } else {
      return null;
    }
  }

  Stream<UpcomingRoomModel> getUpcomingRoomByReferencesStream(String refId) {
    return Stream.fromFuture(getUpcomingRoomByReferences(refId));
  }

  Future<String> createUpcomingRoom(UpcomingRoomModel roomModel) async {
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

  Future<void> updateUpcomingRoom(UpcomingRoomModel roomModel) async {
    PrintLog.printMessage(
        "updateRoom -> ${roomModel.refId.toString()}  ${roomModel.toJson().toString()}");
    await _fs
        .collection('/$_coll')
        .doc(roomModel.channelName)
        .update(roomModel.toJsonTimeStamp());
  }

  Future<void> deleteUpcomingRoom(String refID) async {
    await _fs.collection('/$_coll').doc(refID).delete();
  }
}
