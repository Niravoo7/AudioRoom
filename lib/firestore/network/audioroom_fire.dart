import 'dart:convert';

import 'package:audioroom/firestore/model/audioroom_model.dart';
import 'package:audioroom/helper/print_log.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AudioRoomService {
  final _fs = FirebaseFirestore.instance;
  final _coll = 'tbl_audio_room';

  AudioRoomService() {
    _fs.settings = const Settings(persistenceEnabled: true);
  }

  Query getAudioRoomsQuery() {
    return FirebaseFirestore.instance
        .collection(_coll)
        .where("channel_delete", isEqualTo: false);
  }

  Future<List<AudioRoomModel>> getAudioRoomsByName(String roomname) async {
    return await _fs
        .collection(_coll)
        .where("channel_name", isEqualTo: roomname)
        .where("channel_delete", isEqualTo: false)
        .get(GetOptions(source: Source.serverAndCache))
        .then((QuerySnapshot snapshot) {
      List<AudioRoomModel> audioRoomModels = [];
      if (snapshot != null &&
          snapshot.docs != null &&
          snapshot.docs.length > 0) {
        snapshot.docs.forEach((f) {
          //PrintLog.printMessage("getCourse -> " + jsonEncode(f.data()));
          AudioRoomModel audioRoomModel = AudioRoomModel.fromJson(f.data());
          audioRoomModel.refId = f.id;
          audioRoomModels.add(audioRoomModel);
        });
        return audioRoomModels;
      } else {
        return null;
      }
    });
  }

  Future<List<AudioRoomModel>> getAudioRooms() async {
    return await _fs
        .collection(_coll)
        .where("channel_delete", isEqualTo: false)
        .get(GetOptions(source: Source.serverAndCache))
        .then((QuerySnapshot snapshot) {
      List<AudioRoomModel> audioRoomModels = [];
      if (snapshot != null &&
          snapshot.docs != null &&
          snapshot.docs.length > 0) {
        snapshot.docs.forEach((f) {
          PrintLog.printMessage("getCourse -> " + jsonEncode(f.data()));
          AudioRoomModel audioRoomModel = AudioRoomModel.fromJson(f.data());
          audioRoomModel.refId = f.id;
          audioRoomModels.add(audioRoomModel);
        });
        return audioRoomModels;
      } else {
        return null;
      }
    });
  }

  Future<String> createAudioRoom(AudioRoomModel audioRoomModel) async {
    DocumentReference documentReference =
        await _fs.collection('/$_coll').add(audioRoomModel.toJson());
    return documentReference.id;
  }

  Future<void> updateAudioRoom(AudioRoomModel audioRoomModel) async {
    PrintLog.printMessage(
        "updateAudioRoom -> ${audioRoomModel.refId.toString()}  ${audioRoomModel.toJson().toString()}");
    await _fs
        .collection('/$_coll')
        .doc(audioRoomModel.refId.toString())
        .update(audioRoomModel.toJson());
  }
}
