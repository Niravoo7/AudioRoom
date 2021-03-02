import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/firestore/model/audioroom_model.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AudioRoomWidget extends StatelessWidget {
  final DocumentSnapshot snapshot;
  final Function onTap;

  AudioRoomWidget(this.snapshot, this.onTap);

  Map<String, dynamic> get movie {
    return snapshot.data();
  }

  @override
  Widget build(BuildContext context) {
    AudioRoomModel audioRoomModel = AudioRoomModel.fromJson(movie);
    return GestureDetector(
      child: Container(
        child: Column(
          children: [
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                    color: AppConstants.clrWhite,
                    shape: BoxShape.circle,
                    border:
                        Border.all(width: 2, color: AppConstants.clrDarkGrey)),
                alignment: Alignment.center,
                child: TextWidget(audioRoomModel.channelIcon.toString(),
                    color: AppConstants.clrBlack, fontSize: 30),
              ),
              flex: 1,
            ),
            TextWidget(audioRoomModel.channelName.toString(),
                color: AppConstants.clrBlack, fontSize: 14)
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
