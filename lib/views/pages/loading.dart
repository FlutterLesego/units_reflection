import 'dart:async';
import 'package:flutter/material.dart';
import '../../init.dart';
import '../widgets/app_progress_indicator.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      WidgetsFlutterBinding.ensureInitialized();
      InitApp.initializeApp(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.note_alt,
              size: 100,
              color: Colors.white,
            ),
            SizedBox(
              height: 30,
            ),
            Container(
                child: AppProgressIndicator(color: Colors.white, text: ''))
          ],
        ),
      ),
    );
  }
}
