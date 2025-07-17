import 'package:flutter/material.dart';
import 'package:jtask_flutter/ui/homepage.dart';
import 'package:window_size/window_size.dart';



void main() {
  runApp(const JTask());
  
  //set window name
  WidgetsFlutterBinding.ensureInitialized();
  setWindowTitle("JTask");
}

class JTask extends StatelessWidget {
  const JTask({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JTask',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(title: 'JTask'),
    );
  }
}

