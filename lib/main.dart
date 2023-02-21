import 'dart:async';
import 'dart:ui';

import 'package:animated_background/animated_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cin',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.pink,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController controller1;
  late AnimationController controller2;

  late Animation<double> animation1;
  late Animation<double> animation2;
  late Animation<double> animation3;
  late Animation<double> animation4;

  @override
  void initState() {
    super.initState();

    controller1 = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 5,
      ),
    );
    animation1 = Tween<double>(begin: .1, end: .15).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller1.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller1.forward();
        }
      });
    animation2 = Tween<double>(begin: .02, end: .04).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        setState(() {});
      });

    controller2 = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 1,
      ),
    );
    animation3 = Tween<double>(begin: .41, end: .38).animate(CurvedAnimation(
      parent: controller2,
      curve: Curves.easeInOut,
    ))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller2.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller2.forward();
        }
      });
    animation4 = Tween<double>(begin: 150, end: 170).animate(
      CurvedAnimation(
        parent: controller2,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        setState(() {});
      });

    Timer(Duration(milliseconds: 2500), () {
      controller1.forward();
    });

    controller2.forward();
  }

  void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text(' ❤ '),
        content: const Text(
            'Happy San Valentine\'s Day...!!!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final particleOptions = ParticleOptions(
      image: Image.asset('assets/icons8-heart-suit-48.png'),
      baseColor: Colors.red,
      spawnOpacity: 0.0,
      opacityChangeRate: 0.25,
      minOpacity: 0.1,
      maxOpacity: 0.4,
      spawnMinSpeed: 30.0,
      spawnMaxSpeed: 70.0,
      spawnMinRadius: 7.0,
      spawnMaxRadius: 15.0,
      particleCount: 40,
    );

    return Scaffold(
        backgroundColor: Color(0xff192028),
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: Center(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image(
                    fit: BoxFit.cover,
                    height: double.infinity,
                    image: AssetImage(
                        'assets/photo-1521033719794-41049d18b8d4.jpeg')),
                Positioned.fill(
                    child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    color: Colors.black.withOpacity(0.1),
                  ),
                )),
                AnimatedBackground(
                    child: Text(""),
                    vsync: this,
                    behaviour:
                        RandomParticleBehaviour(options: particleOptions)),
                GestureDetector(
                  onTap: () {
                    _showAlertDialog(context);
                  },
                  child: CustomPaint(
                    size: Size(animation4.value,
                        (animation4.value * 1.5223408324350638).toDouble()),
                    painter: MyPainterHeart(animation4.value),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class MyPainterHeart extends CustomPainter {
  final double radius;

  MyPainterHeart(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(radius * 0.9273333, radius * 0.4500000);
    path_0.cubicTo(radius * 0.8493333, radius * 0.6000000, radius * 0.6406667,
        radius * 0.8040000, radius * 0.5226667, radius * 0.9126667);
    path_0.cubicTo(radius * 0.5099800, radius * 0.9241200, radius * 0.4906867,
        radius * 0.9241200, radius * 0.4780000, radius * 0.9126667);
    path_0.cubicTo(radius * 0.3593333, radius * 0.8040000, radius * 0.1506667,
        radius * 0.6000000, radius * 0.07266667, radius * 0.4500000);
    path_0.cubicTo(radius * -0.09866667, radius * 0.1200000, radius * 0.3333333,
        radius * -0.1000000, radius * 0.5000000, radius * 0.2300000);
    path_0.cubicTo(radius * 0.6666667, radius * -0.1000000, radius * 1.098667,
        radius * 0.1200000, radius * 0.9273333, radius * 0.4500000);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    //paint_0_fill.color = CupertinoColors.destructiveRed.withOpacity(1.0);
    paint_0_fill.shader = LinearGradient(
            colors: [Colors.redAccent, Colors.red],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight)
        .createShader(Rect.fromCircle(center: Offset(0, 0), radius: radius));
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class MyBehavior extends ScrollBehavior {
  Widget buildViewpportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9273333, size.height * 0.4500000);
    path_0.cubicTo(
        size.width * 0.8493333,
        size.height * 0.6000000,
        size.width * 0.6406667,
        size.height * 0.8040000,
        size.width * 0.5226667,
        size.height * 0.9126667);
    path_0.cubicTo(
        size.width * 0.5099800,
        size.height * 0.9241200,
        size.width * 0.4906867,
        size.height * 0.9241200,
        size.width * 0.4780000,
        size.height * 0.9126667);
    path_0.cubicTo(
        size.width * 0.3593333,
        size.height * 0.8040000,
        size.width * 0.1506667,
        size.height * 0.6000000,
        size.width * 0.07266667,
        size.height * 0.4500000);
    path_0.cubicTo(
        size.width * -0.09866667,
        size.height * 0.1200000,
        size.width * 0.3333333,
        size.height * -0.1000000,
        size.width * 0.5000000,
        size.height * 0.2300000);
    path_0.cubicTo(
        size.width * 0.6666667,
        size.height * -0.1000000,
        size.width * 1.098667,
        size.height * 0.1200000,
        size.width * 0.9273333,
        size.height * 0.4500000);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
