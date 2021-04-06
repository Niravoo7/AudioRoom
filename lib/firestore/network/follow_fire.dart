import 'package:audioroom/helper/print_log.dart';
import 'package:audioroom/firestore/model/follow_model.dart';
import 'package:audioroom/firestore/model/notification_model.dart';
import 'package:audioroom/firestore/network/notification_fire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FollowService {
  final _fs = FirebaseFirestore.instance;
  final _coll = 'tbl_follow';

  FollowService() {
    _fs.settings = const Settings(persistenceEnabled: true);
  }

  Query getFollowQuery() {
    return _fs.collection(_coll);
  }

  Query checkFollowByUser(String uId) {
    return _fs
        .collection(_coll)
        .where("follow_by", isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .where("follow_to", isEqualTo: uId);
  }

  Query checkFollowerByUID() {
    return _fs
        .collection(_coll)
        .where("follow_to", isEqualTo: FirebaseAuth.instance.currentUser.uid);
  }

  Query checkFollowingByUID() {
    return _fs
        .collection(_coll)
        .where("follow_by", isEqualTo: FirebaseAuth.instance.currentUser.uid);
  }

  Future<List<FollowModel>> getFollow() async {
    return await _fs
        .collection(_coll)
        .get(GetOptions(source: Source.serverAndCache))
        .then((QuerySnapshot snapshot) {
      List<FollowModel> followModels = [];
      if (snapshot != null &&
          snapshot.docs != null &&
          snapshot.docs.length > 0) {
        snapshot.docs.forEach((f) {
          FollowModel followModel = FollowModel.fromJson(f.data());
          followModel.refId = f.id;
          followModels.add(followModel);
        });
        return followModels;
      } else {
        return null;
      }
    });
  }

  Future<List<String>> getFollowUserConnected() async {
    return await _fs
        .collection(_coll)
        .where("follow_by", isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .get(GetOptions(source: Source.serverAndCache))
        .then((QuerySnapshot snapshot) async {
      List<String> strs = [];
      if (snapshot != null &&
          snapshot.docs != null &&
          snapshot.docs.length > 0) {
        snapshot.docs.forEach((f) {
          FollowModel followModel = FollowModel.fromJson(f.data());
          strs.add(followModel.followTo);
        });

        QuerySnapshot snapshot1 = await _fs
            .collection(_coll)
            .where("follow_to",
                isEqualTo: FirebaseAuth.instance.currentUser.uid)
            .get(GetOptions(source: Source.serverAndCache));

        if (snapshot1 != null &&
            snapshot1.docs != null &&
            snapshot1.docs.length > 0) {
          snapshot1.docs.forEach((f) {
            FollowModel followModel = FollowModel.fromJson(f.data());
            if (!strs.contains(followModel.followBy)) {
              strs.add(followModel.followBy);
            }
          });
        }

        return strs;
      } else {
        return null;
      }
    });
  }

  Future<FollowModel> getFollowByReferences(String refId) async {
    DocumentReference reference = _fs.doc(_coll + '/' + refId);
    DocumentSnapshot snapshot = await _fs.doc(reference?.path ?? "").get();
    if (snapshot != null && snapshot.data() != null) {
      FollowModel followModel = FollowModel.fromJson(snapshot.data());
      followModel.refId = snapshot.id;
      return followModel;
    } else {
      return null;
    }
  }

  Future<void> createFollow(
      FollowModel followModel, String userName, String imageUrl) async {
    await _fs
        .collection('/$_coll')
        .doc(followModel.followBy.substring(0, 10) +
            "@" +
            followModel.followTo.substring(0, 10))
        .set(followModel.toJson());
    NotificationModel notificationModel = new NotificationModel(
        uId: followModel.followTo,
        notificationType: "follow",
        description: "$userName followed you",
        imageUrl: imageUrl,
        createDatetime: DateTime.now(),
        title: "Follow");
    NotificationService().createNotification(notificationModel);
  }

  Future<void> deleteFollow(
      FollowModel followModel, String userName, String imageUrl) async {
    await _fs
        .collection('/$_coll')
        .doc(followModel.followBy.substring(0, 10) +
            "@" +
            followModel.followTo.substring(0, 10))
        .delete();
    NotificationModel notificationModel = new NotificationModel(
        uId: followModel.followTo,
        notificationType: "unfollow",
        description: "$userName unfollowed you",
        imageUrl: imageUrl,
        createDatetime: DateTime.now(),
        title: "Unfollow");
    NotificationService().createNotification(notificationModel);
  }

  Future<void> updateFollow(FollowModel followModel) async {
    PrintLog.printMessage("updateFollow -> ${followModel.refId.toString()}");
    await _fs
        .collection('/$_coll')
        .doc(followModel.followBy.substring(0, 10) +
            "@" +
            followModel.followTo.substring(0, 10))
        .update(followModel.toJson());
  }
}
