
import 'package:audioroom/firestore/model/notification_model.dart';
import 'package:audioroom/helper/print_log.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationService {
  final _fs = FirebaseFirestore.instance;
  final _coll = 'tbl_notification';

  NotificationService() {
    _fs.settings = const Settings(persistenceEnabled: true);
  }

  Query getNotificationQuery() {
    return FirebaseFirestore.instance
        .collection(_coll)
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser.uid);
  }

  Future<List<NotificationModel>> getNotification() async {
    return await _fs
        .collection(_coll)
        .get(GetOptions(source: Source.serverAndCache))
        .then((QuerySnapshot snapshot) {
      List<NotificationModel> notificationModels = [];
      if (snapshot != null &&
          snapshot.docs != null &&
          snapshot.docs.length > 0) {
        snapshot.docs.forEach((f) {
          //PrintLog.printMessage("getCourse -> " + jsonEncode(f.data()));
          NotificationModel notificationModel =
              NotificationModel.fromJson(f.data());
          notificationModel.refId = f.id;
          notificationModels.add(notificationModel);
        });
        return notificationModels;
      } else {
        return null;
      }
    });
  }

  Future<void> createNotification(NotificationModel notificationModel) async {
    await _fs.collection('/$_coll').add(notificationModel.toJsonTimeStamp());
  }

  Future<void> updateNotification(NotificationModel notificationModel) async {
    PrintLog.printMessage(
        "updateNotification -> ${notificationModel.refId.toString()}  ${notificationModel.toJsonTimeStamp().toString()}");
    await _fs
        .collection('/$_coll')
        .doc(notificationModel.refId.toString())
        .update(notificationModel.toJsonTimeStamp());
  }
}
