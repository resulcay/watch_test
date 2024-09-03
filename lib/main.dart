import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wear/wear.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: WatchScreen(),
    );
  }
}

class WatchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WatchShape(
      builder: (BuildContext context, WearShape shape, Widget? child) {
        return AmbientMode(
          builder: (context, mode, child) {
            return mode == WearMode.active ? StartScreen() : AmbientWatchFace();
          },
        );
      },
    );
  }
}

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://rr4---sn-uxaxjvh5gbxoupo5-jvgr.googlevideo.com/videoplayback?expire=1725392911&ei=rxPXZqWFJ8eI1sQPzdGTeA&ip=181.88.176.137&id=o-AACDLuAs9JzFfBagmzk78y49anzCjy_YgI_5AGDKzQUw&itag=18&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&mh=qO&mm=31%2C29&mn=sn-uxaxjvh5gbxoupo5-jvgr%2Csn-x1xe7n7z&ms=au%2Crdu&mv=m&mvi=4&pl=24&initcwndbps=137500&bui=AQmm2ex56Xg14fJO7U6_YT-mModVqzIOO2IrfiIMK3zA_7qkI8vl92DqU3oAwmDItEjep02M94Ai5TP5&spc=Mv1m9m8033aI6G23dTNQvaHaWgdzXWvYdOXRU9MlpVQO6VntgPoAcHo&vprv=1&svpuc=1&mime=video%2Fmp4&ns=k5Zzh4FaMGy9pjSCSQm6Uo4Q&rqh=1&gir=yes&clen=171742697&ratebypass=yes&dur=3690.068&lmt=1715395384599475&mt=1725370888&fvip=3&c=WEB_CREATOR&sefc=1&txp=5438434&n=Ecx-UUU2SNjCtQ&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cbui%2Cspc%2Cvprv%2Csvpuc%2Cmime%2Cns%2Crqh%2Cgir%2Cclen%2Cratebypass%2Cdur%2Clmt&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=ABPmVW0wRgIhAMlfSQ7Guv16RpufryflsA8IDXU4CmvlVEUjUV4jHGpJAiEAlHpdLHdPSUgtNdObp0Sw4nopBT4dE_eTcCxpUWgXJFY%3D&sig=AJfQdSswRgIhAPTRImq_OTvXLEb3ZO_UyYuKMc8Q4tU3YCB-9ZRc4SgAAiEAv-QkqlaPtNiiq5Nq4C9zLkDjVeFAjrK5hD5YarLK1iE%3D&title=1%20Hour%20-%20Pedro-Pedro-Pedro!%20%7C%20Raffaella%20Carr%C3%A0%20%7C%20Jaxomy%20Remix%20%7C%20Pedro%20The%20Dancing%20Racoon'))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: 2,
                child: VideoPlayer(_controller),
              )
            : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}

class AmbientWatchFace extends StatelessWidget {
  const AmbientWatchFace({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: FlutterLogo(size: 100),
      ),
    ));
  }
}
