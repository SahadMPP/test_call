
// import 'package:zego_express_engine/zego_express_engine.dart';
// import 'package:zego_zim/zego_zim.dart';

// class ZIMService {
//   // ...
//   Future<void> init({required int appID, String appSign = ''}) async {
//     initEventHandle();
//     ZIM.create(
//       ZIMAppConfig()
//         ..appID = appID
//         ..appSign = appSign,
//     );
//   }
//   // ...
//    Future<void> connectUser(String userID, String userName) async {
//     ZIMUserInfo userInfo = ZIMUserInfo();
//     userInfo.userID = userID;
//     userInfo.userName = userName;
//     zimUserInfo = userInfo;
//     ZIM.instance?.login(userInfo);
//   }

// }



import 'dart:convert';

import 'package:call_tester/calling_config/screens/home_page.dart';
import 'package:zego_express_engine/zego_express_engine.dart';
import 'package:zego_zim/zego_zim.dart';

class ZIMService {
  ZIM? zimInstance;
  ZIMUserInfo? zimUserInfo; // Store user info in an instance variable
  bool isLoggedIn = false; // Track the logged-in status

  Future<void> init({required int appID, required String appSign}) async {
    zimInstance = ZIM.create(
      ZIMAppConfig()
        ..appID = appID
        ..appSign = appSign,
    );
  }

  Future<void> connectUser(String userID, String userName) async {
    // Create a new instance of ZIMUserInfo
    zimUserInfo = ZIMUserInfo()
      ..userID = userID
      ..userName = userName;
    ZIMLoginConfig loginConfig = ZIMLoginConfig();
    // Attempt to log in
    try {
      await zimInstance?.login(userID,loginConfig); // Pass userID as a String
      isLoggedIn = true; // Set the logged-in status
    } catch (e) {
      throw Exception('Failed to log in: $e');
    }
  }

  Future<ZIMCallInvitationSentResult> sendVideoCallInvitation(
      String targetUserID, String callerName) async {
    // Check if zimInstance has been initialized
    if (zimInstance == null) {
      throw Exception('ZIM instance is not initialized. Call init() first.');
    }

    // Define the call type (change to video if needed)
    const int callType = ZegoCallType.audio; // Use video call type

    // Create extended data as a map to pass additional call details
    final Map<String, dynamic> extendedData = {
      'callType': callType,
      'callerName': callerName,
    };

    // Convert the extended data map to a JSON string
    final String extendedDataString = jsonEncode(extendedData);

    // Prepare the call invite configuration with the extended data
    final ZIMCallInviteConfig inviteConfig = ZIMCallInviteConfig();
    inviteConfig.extendedData = extendedDataString;

    // Use the initialized zimInstance to send the call invitation
    final result = await zimInstance!.callInvite([targetUserID], inviteConfig);

    return result;
  }

  bool get userIsLoggedIn => isLoggedIn; // Getter for logged-in status
}
class ZEGOSDKManager {
  ZEGOSDKManager._internal();
  factory ZEGOSDKManager() => instance;
  static final ZEGOSDKManager instance = ZEGOSDKManager._internal();

  ExpressService expressService = ExpressService();
  ZIMService zimService = ZIMService();

  Future<void> init(int appID, String appSign) async {
    await expressService.init(appID: appID, appSign: appSign);
    await zimService.init(appID: appID, appSign: appSign);
  }

  Future<void> connectUser(String userID, String userName) async {
    // await expressService.connectUser(userID, userName);
    await zimService.connectUser(userID, userName);
  }
  // ...
}

class ExpressService {

  // ...  
  Future<void> init({
    required int appID,
    String appSign = '',
    ZegoScenario scenario = ZegoScenario.StandardVideoCall,
  }) async {
    final profile = ZegoEngineProfile(appID, scenario, appSign: appSign);
    await ZegoExpressEngine.createEngineWithProfile(profile);
  }
  // ...  
}
