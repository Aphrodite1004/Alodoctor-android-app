import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient/component/Bottombar.dart';
import 'package:flutter_patient/component/MainHeader.dart';
import 'package:flutter_patient/component/NavDrawer.dart';
import 'package:flutter_patient/controllers/consultantcontroller.dart';
import 'package:flutter_patient/models/doctor.dart';
import 'package:flutter_patient/utils/Configs.dart';
import 'package:flutter_patient/utils/api_endpoints.dart';
import 'package:flutter_patient/utils/colors.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:wakelock/wakelock.dart';

class VoicePage extends StatefulWidget {
  final String channelName;

  /// non-modifiable client role of the page
  final ClientRole role;
  final String callType;
  const VoicePage({Key key, this.channelName, this.role, this.callType})
      : super(key: key);

  @override
  VoicePageState createState() => VoicePageState();
}

class VoicePageState extends StateMVC<VoicePage> with SingleTickerProviderStateMixin{

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  static final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  bool disable = true;
  bool loud_flag = false;

  Timer _timer;
  int _start = 0;

  consultantcontroller _con;

  VoicePageState() : super(consultantcontroller()){
    _con = controller;
  }
  doctor temp_doctor;
  String category = '';

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          _start++;
        },
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < Configs.umodel.doctors.length; i++) {
      if (Configs.umodel.doctors[i].id == Configs.callmodel.doctorId) {
        temp_doctor = Configs.umodel.doctors[i];
      }
    }
    for (int i = 0; i < Configs.umodel.menus.length; i++) {
      if (Configs.umodel.menus[i].id == temp_doctor.menulist_id) {
        setState(() {
          category = Configs.umodel.menus[i].text;
        });
      }
    }
    Wakelock.enable();
    initialize();
    startTimer();
  }
  @override
  void dispose() {
    // clear users
    print('destory');
    _timer.cancel();
    _users.clear();
    // destroy sdk
    AgoraRtcEngine.leaveChannel();
    AgoraRtcEngine.destroy();
    Wakelock.disable();
    super.dispose();
  }

  Future<void> initialize() async {
    if (Configs.APP_ID.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }
    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    await AgoraRtcEngine.enableWebSdkInteroperability(true);
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    configuration.dimensions = Size(1920, 1080);
    await AgoraRtcEngine.setVideoEncoderConfiguration(configuration);
    await AgoraRtcEngine.joinChannel(null, widget.channelName, null, 0);

  }
  Future<void> _initAgoraRtcEngine() async {
    await AgoraRtcEngine.create(Configs.APP_ID);
    await AgoraRtcEngine.enableAudio();
    await AgoraRtcEngine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await AgoraRtcEngine.setClientRole(widget.role);
    await AgoraRtcEngine.setEnableSpeakerphone(false);
  }

  /// Add agora event handlers
  void _addAgoraEventHandlers() {
    AgoraRtcEngine.onError = (dynamic code) {
      setState(() {
        final info = 'onError: $code';
        _infoStrings.add(info);
      });
    };


    AgoraRtcEngine.onJoinChannelSuccess = (
        String channel,
        int uid,
        int elapsed,
        ) {
      setState(() {
        final info = 'onJoinChannel: $channel, uid: $uid';
        _infoStrings.add(info);
      });
    };

    AgoraRtcEngine.onLeaveChannel = () {
      setState(() {
        _infoStrings.add('onLeaveChannel');
        _users.clear();
      });
    };

    AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {
      setState(() {
        final info = 'userJoined: $uid';
        _infoStrings.add(info);
        _users.add(uid);
      });
    };

    AgoraRtcEngine.onUserOffline = (int uid, int reason) {
      setState(() {
        final info = 'userOffline: $uid';
        _infoStrings.add(info);
        _users.remove(uid);
      });
      Navigator.pop(context);
    };

    AgoraRtcEngine.onFirstRemoteVideoFrame = (
        int uid,
        int width,
        int height,
        int elapsed,
        ) {
      setState(() {
        final info = 'firstRemoteVideo: $uid ${width}x $height';
        _infoStrings.add(info);
      });
    };
  }
  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<AgoraRenderWidget> list = [];
    if (widget.role == ClientRole.Broadcaster) {
      list.add(AgoraRenderWidget(0, local: true, preview: true,));
    }
    _users.forEach((int uid) => list.add(AgoraRenderWidget(uid)));
    return list;
  }

  /// Video view wrapper
  Widget _videoView(view) {
    return Expanded(child: Container(child: view));
  }

  /// Video view row wrapper
  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  /// Video layout wrapper
  Widget _viewRows() {
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
        return Container(
            child: Column(
              children: <Widget>[_videoView(views[0])],
            ));
      case 2:
        return Container(
            child: Column(
              children: <Widget>[
                _expandedVideoRow([views[0]]),
                _expandedVideoRow([views[1]])
              ],
            ));
      case 3:
        return Container(
            child: Column(
              children: <Widget>[
                _expandedVideoRow(views.sublist(0, 2)),
                _expandedVideoRow(views.sublist(2, 3))
              ],
            ));
      case 4:
        return Container(
            child: Column(
              children: <Widget>[
                _expandedVideoRow(views.sublist(0, 2)),
                _expandedVideoRow(views.sublist(2, 4))
              ],
            ));
      default:
    }
    return Container();
  }

  /// Toolbar layout
  Widget _videoToolbar() {
    if (widget.role == ClientRole.Audience) return Container();
    return Container(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 50,
            child: RawMaterialButton(
              onPressed: _onToggleLoud,
              child: Icon(
                loud_flag ? Icons.volume_off : Icons.volume_up,
                color: muted ? Colors.white : Theme.of(context).primaryColor,
                size: 20.0,
              ),
              shape: CircleBorder(),
              elevation: 2.0,
              fillColor: muted ? Theme.of(context).primaryColor : Colors.white,
              padding: const EdgeInsets.all(5.0),
            ),
          ),
          Container(
            width: 50,
            child: RawMaterialButton(
              onPressed: _onToggleMute,
              child: Icon(
                muted ? Icons.mic_off : Icons.mic,
                color: muted ? Colors.white : Theme.of(context).primaryColor,
                size: 20.0,
              ),
              shape: CircleBorder(),
              elevation: 2.0,
              fillColor: muted ? Theme.of(context).primaryColor : Colors.white,
              padding: const EdgeInsets.all(5.0),
            ),
          ),
          Container(
            width: 50,
            child: RawMaterialButton(
              onPressed: () => _onCallEnd(context),
              child: Icon(
                Icons.call_end,
                color: Colors.white,
                size: 35.0,
              ),
              shape: CircleBorder(),
              elevation: 2.0,
              fillColor: Colors.redAccent,
              padding: const EdgeInsets.all(5.0),
            ),
          ),
          Container(
            width: 50,
            child: RawMaterialButton(
              onPressed: _onSwitchCamera,
              child: Icon(
                Icons.switch_camera,
                color: Theme.of(context).primaryColor,
                size: 20.0,
              ),
              shape: CircleBorder(),
              elevation: 2.0,
              fillColor: Colors.white,
              padding: const EdgeInsets.all(5.0),
            ),
          ),
          Container(
            width: 50,
            child: RawMaterialButton(
              onPressed: _disVideo,
              child: Icon(
                disable ? Icons.videocam : Icons.videocam_off,
                color: disable ? Theme.of(context).primaryColor : Colors.white,
                size: 20.0,
              ),
              shape: CircleBorder(),
              elevation: 2.0,
              fillColor: !disable ? Theme.of(context).primaryColor : Colors.white,
              padding: const EdgeInsets.all(5.0),
            ),
          )
        ],
      ),
    );
  }

  Widget _audioToolbar() {
    if (widget.role == ClientRole.Audience) return Container();
    return Container(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: RawMaterialButton(
              onPressed: _onToggleLoud,
              child: Icon(
                loud_flag ? Icons.volume_off : Icons.volume_up,
                color: loud_flag ? Colors.white : Theme.of(context).primaryColor,
                size: 20.0,
              ),
              shape: CircleBorder(),
              elevation: 2.0,
              fillColor: loud_flag ? Theme.of(context).primaryColor : Colors.white,
              padding: const EdgeInsets.all(5.0),
            ),
            width: 50,
          ),
          Container(
            child: RawMaterialButton(
              onPressed: _onToggleMute,
              child: Icon(
                muted ? Icons.mic_off : Icons.mic,
                color: muted ? Colors.white : Theme.of(context).primaryColor,
                size: 20.0,
              ),
              shape: CircleBorder(),
              elevation: 2.0,
              fillColor: muted ? Theme.of(context).primaryColor : Colors.white,
              padding: const EdgeInsets.all(5.0),
            ),
            width: 50,
          ),
          Container(
            child:  RawMaterialButton(
              onPressed: () => _onCallEnd(context),
              child: Icon(
                Icons.call_end,
                color: Colors.white,
                size: 35.0,
              ),
              shape: CircleBorder(),
              elevation: 2.0,
              fillColor: Colors.redAccent,
              padding: const EdgeInsets.all(5.0),
            ),
            width: 50,
          )
        ],
      ),
    );
  }
  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }
  Future<void> _onToggleLoud() async {
    setState(() {
      loud_flag = !loud_flag;
    });
    await AgoraRtcEngine.setEnableSpeakerphone(loud_flag);
  }
  Future<void> _onToggleMute() async {
    setState(() {
      muted = !muted;
    });
    AgoraRtcEngine.muteLocalAudioStream(muted);
    if(muted){
      setState(() {
        loud_flag = false;
      });
      await AgoraRtcEngine.setEnableSpeakerphone(loud_flag);
    }
  }

  void _onSwitchCamera() {
    AgoraRtcEngine.switchCamera();
  }

  _disVideo() {
    setState(() {
      disable = !disable;
    });
    AgoraRtcEngine.enableLocalVideo(disable);
  }

  @override
  Widget build(BuildContext context) {

    String timetext = '00:00';
    String mintext = '';
    String sectext = '';
    int cal_min = (_start / 60).round();
    int cal_sec = _start % 60;
    if(cal_min == 0){
      mintext = '00';
    } else if(cal_min < 10){
      mintext = '0' + cal_min.toString();
    } else{
      mintext = cal_min.toString();
    }
    if(cal_sec == 0){
      sectext = '00';
    } else if(cal_sec < 10){
      sectext =  '0' + cal_sec.toString();
    } else {
      sectext = cal_sec.toString();
    }
    timetext = mintext + ':' + sectext;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        key: scaffoldKey,
        endDrawer: NavDrawer(scaffoldKey),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child:Column(
              children: [
                MainHeader('ﺍﺧﺘﺮ ﻃﺒﻴﺒﻚ ﻭﺍﺳﺘﺸﺮ', scaffoldKey),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        color: Colors.white,
                        height: Configs.calcheight(105),
                        width: double.infinity,
                        padding: EdgeInsets.only(right: Configs.calcheight(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "الطبيب " +
                                          temp_doctor.fname +
                                          ' ' +
                                          temp_doctor.lname,
                                      style: TextStyle(
                                          color: Black02,
                                          fontSize: Configs.calcheight(26)),
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Image.asset(
                                      'assets/images/ic_bright.png',
                                      width: Configs.calcheight(25),
                                      height: Configs.calcheight(25),
                                    ),
                                  ],
                                ),
                                Container(
                                  child: Text(
                                    category,
                                    style: TextStyle(
                                        fontSize: Configs.calcheight(26),
                                        color: Black02),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: Configs.calcheight(20),
                            ),
                            Stack(
                              children: [
                                Container(
                                  child: Material(
                                    child: Container(
                                      width: Configs.calcheight(79),
                                      height: Configs.calcheight(79),
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                            fit: BoxFit.cover,
                                            image: new NetworkImage(
                                              APIEndPoints.mediaurl +
                                                  temp_doctor.photo,
                                            )),
                                        border: Border.all(
                                            color: Green01,
                                            width: Configs.calcheight(1)),
                                      ),
                                    ),
                                    elevation: 10,
                                    shape: CircleBorder(),
                                  ),
                                ),
                                Positioned(
                                  child: Container(
                                    decoration: new BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    width: Configs.calcheight(15),
                                    height: Configs.calcheight(15),
                                    child: Icon(
                                      Icons.brightness_1,
                                      color: temp_doctor.active_state == 1
                                          ? Green01
                                          : Gray04,
                                      size: Configs.calcheight(15),
                                    ),
                                  ),
                                  left: Configs.calcwidth(4),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Gray01,
                          width: double.infinity,
                          child: Stack(
                            children: <Widget>[
                              widget.callType == "VideoCall"
                                  ? _viewRows()
                                  :  Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.person,
                                        size: 60,
                                        color: Theme.of(context).backgroundColor,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(timetext,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.black)),
                                    ],
                                  )
                              ),
                              // _panel(),
                              widget.callType == "VideoCall" ? _videoToolbar() : _audioToolbar()
                            ],
                          )
                        ),
                      ),
                    ],
                  ),
                ),
                Bottombar(1)
              ],
            ),
        ),
      ),
    );
  }
}
