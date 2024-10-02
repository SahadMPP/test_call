import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

class CallView extends StatefulWidget {
  final String? roomId;
  final String? name;
  const CallView({super.key, this.roomId, this.name});

  @override
  State<CallView> createState() => _CallViewState();
}

class _CallViewState extends State<CallView> {

 String roomIdd = '';

  void startListenEvent() {
  // Callback for updates on the status of other users in the room.
  // Users can only receive callbacks when the isUserStatusNotify property of ZegoRoomConfig is set to `true` when logging in to the room (loginRoom).
  ZegoExpressEngine.onRoomUserUpdate = (roomID, updateType, List<ZegoUser> userList) {
    (
        'onRoomUserUpdate: roomID: $roomID, updateType: ${updateType.name}, userList: ${userList.map((e) => e.userID)}');
  };
  // Callback for updates on the status of the streams in the room.
  ZegoExpressEngine.onRoomStreamUpdate = (roomID, updateType, List<ZegoStream> streamList, extendedData) {
    (
        'onRoomStreamUpdate: roomID: $roomID, updateType: $updateType, streamList: ${streamList.map((e) => e.streamID)}, extendedData: $extendedData');
    if (updateType == ZegoUpdateType.Add) {
      for (final stream in streamList) {
        startPlayStream(stream.streamID);
      }
    } else {
      for (final stream in streamList) {
        stopPlayStream(stream.streamID);
      }
    }
  };
  // Callback for updates on the current user's room connection status.
  ZegoExpressEngine.onRoomStateUpdate = (roomID, state, errorCode, extendedData) {
    (
        'onRoomStateUpdate: roomID: $roomID, state: ${state.name}, errorCode: $errorCode, extendedData: $extendedData');
  };

  // Callback for updates on the current user's stream publishing changes.
  ZegoExpressEngine.onPublisherStateUpdate = (streamID, state, errorCode, extendedData) {
    (
        'onPublisherStateUpdate: streamID: $streamID, state: ${state.name}, errorCode: $errorCode, extendedData: $extendedData');
  };
}

Future<void> startPlayStream(String streamID) async {
  // Start to play streams.
  ZegoExpressEngine.instance.startPlayingStream(streamID);
}

Future<void> stopPlayStream(String streamID) async {
  ZegoExpressEngine.instance.stopPlayingStream(streamID);
}

void stopListenEvent() {
  ZegoExpressEngine.onRoomUserUpdate = null;
  ZegoExpressEngine.onRoomStreamUpdate = null;
  ZegoExpressEngine.onRoomStateUpdate = null;
  ZegoExpressEngine.onPublisherStateUpdate = null;
}

 //Create room Id
  String getRoomId() {
    // Random rand = Random();
    if (widget.roomId == null) {
      ///creating a meeting
      // final id = rand.nextInt(100000000).toString();
      final id = '100';
      print(id);
      return id;
    } else {
      ///Joining a meeting
      return widget.roomId!;
    }
  }

  ///generate user id
  String getUserId() {
    Random rand = Random();
    return rand.nextInt(100000000).toString();
  }

  
Future<ZegoRoomLoginResult> loginRoom(String userID, String userNm) async {
  // The value of `userID` is generated locally and must be globally unique.
  final user = ZegoUser(userID, userNm);

  // The value of `roomID` is generated locally and must be globally unique.
   roomIdd = getRoomId();

  // onRoomUserUpdate callback can be received when "isUserStatusNotify" parameter value is "true".
  ZegoRoomConfig roomConfig = ZegoRoomConfig.defaultConfig()..isUserStatusNotify = true;

  // log in to a room
  // Users must log in to the same room to call each other.
  return ZegoExpressEngine.instance.loginRoom(roomIdd, user, config: roomConfig).then((ZegoRoomLoginResult loginRoomResult) {
    ('loginRoom: errorCode:${loginRoomResult.errorCode}, extendedData:${loginRoomResult.extendedData}');
    if (loginRoomResult.errorCode == 0) {
      // startPreview();
      startPublish();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('loginRoom failed: ${loginRoomResult.errorCode}')));
    }
    return loginRoomResult;
  });
}

Future<ZegoRoomLogoutResult> logoutRoom() async {
  // stopPreview();
  stopPublish();
  return ZegoExpressEngine.instance.logoutRoom(roomIdd);
}

Future<void> startPublish() async{
  // After calling the `loginRoom` method, call this method to publish streams.
  // The StreamID must be unique in the room.
  String streamID = 'rooom_${widget.name}_call';
  ZegoExpressEngine.instance.enableCamera(false);
  return ZegoExpressEngine.instance.startPublishingStream(streamID);
}

Future<void> stopPublish() async {
  return ZegoExpressEngine.instance.stopPublishingStream();
}

  @override
  void initState() {
    super.initState();
    startListenEvent();
    loginRoom(getUserId(), widget.name!);
  }


@override
  void dispose() {
    super.dispose();
    stopListenEvent();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Text('User Name : ${widget.name}'),
          CircleAvatar(
            backgroundColor: Colors.red,
            child: IconButton(onPressed: (){
              logoutRoom().then((value) {
                Navigator.of(context).pop();
              },);
            }, icon: const Icon(Icons.call,color: Colors.white,)),
          ),
          const SizedBox(height: 100)
        ],
      ),
    );
  }
}