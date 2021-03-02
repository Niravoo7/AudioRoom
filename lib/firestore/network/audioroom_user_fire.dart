import 'dart:convert';

import 'package:audioroom/firestore/model/audioroom_user_model.dart';
import 'package:audioroom/helper/print_log.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AudioRoomUsersService {
  final _fs = FirebaseFirestore.instance;
  final _coll = 'tbl_audio_room';
  final _collSub = 'tbl_audio_room_user';

  AudioRoomUsersService() {
    _fs.settings = const Settings(persistenceEnabled: true);
  }

  Query getAudioRoomsQuery() {
    return FirebaseFirestore.instance
        .collection(_coll)
        .where("channel_delete", isEqualTo: false);
  }

  Future<List<AudioRoomUserModel>> getAudioRoomUsers(String audioRoomId) async {
    return await _fs
        .collection(_coll)
        .doc(audioRoomId)
        .collection(_collSub)
        .get(GetOptions(source: Source.serverAndCache))
        .then((QuerySnapshot snapshot) {
      List<AudioRoomUserModel> audioRoomUserModels =
          new List<AudioRoomUserModel>();
      if (snapshot != null &&
          snapshot.docs != null &&
          snapshot.docs.length > 0) {
        snapshot.docs.forEach((f) {
          PrintLog.printMessage("getAudioRoomUsers -> " + jsonEncode(f.data()));
          AudioRoomUserModel audioRoomUserModel =
              AudioRoomUserModel.fromJson(f.data());
          audioRoomUserModel.refId = f.id;
          audioRoomUserModels.add(audioRoomUserModel);
        });
        return audioRoomUserModels;
      } else {
        return null;
      }
    });
  }

  Future<String> createAudioRoomUser(
      String audioRoomId, AudioRoomUserModel audioRoomUserModel) async {
    DocumentReference documentReference = await _fs
        .collection('/$_coll')
        .doc(audioRoomId)
        .collection(_collSub)
        .add(audioRoomUserModel.toJson());
    return documentReference.id;
  }

  Future<void> updateAudioRoomUser(
      String audioRoomId, AudioRoomUserModel audioRoomUserModel) async {
    PrintLog.printMessage(
        "updateAudioRoom -> ${audioRoomUserModel.refId.toString()}  ${audioRoomUserModel.toJson().toString()}");
    await _fs
        .collection('/$_coll')
        .doc(audioRoomId)
        .collection(_collSub)
        .doc(audioRoomUserModel.refId.toString())
        .update(audioRoomUserModel.toJson());
  }

  Future<String> getUserNameFromUSerRoomId(
      String audioRoomId, int audioRoomUserId) async {
    PrintLog.printMessage("updateAudioRoom -> $audioRoomId  $audioRoomUserId");
    return await _fs
        .collection('/$_coll')
        .doc(audioRoomId)
        .collection(_collSub)
        .where("user_room_id", isEqualTo: audioRoomUserId)
        .get(GetOptions(source: Source.serverAndCache))
        .then((QuerySnapshot snapshot) {
      List<AudioRoomUserModel> audioRoomUserModels =
          new List<AudioRoomUserModel>();
      if (snapshot != null &&
          snapshot.docs != null &&
          snapshot.docs.length > 0) {
        snapshot.docs.forEach((f) {
          audioRoomUserModels.add(AudioRoomUserModel.fromJson(f.data()));
        });
        return audioRoomUserModels[0].userName;
      } else {
        return "";
      }
    });
  }
}
