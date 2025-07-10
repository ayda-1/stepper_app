import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MyStepperApp());
  }
}

class MyStepperApp extends StatefulWidget {
  const MyStepperApp({super.key});

  @override
  State<MyStepperApp> createState() => _MyStepperAppState();
}

class _MyStepperAppState extends State<MyStepperApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stepper Uygulaması"),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(child: Stepper(steps: _tumStepler())),
    );
  }

  List<Step> _tumStepler() {
    List<Step> stepler = [
      Step(
        title: Text("Username Baslik"),
        content: TextFormField(
          decoration: InputDecoration(
            labelText: "Username",
            hintText: "Kullanici Adı",
            border: OutlineInputBorder(),
          ),
        ),
        subtitle: Text("Username Altbaslik"),
        state: StepState.indexed,
        isActive: true,
      ),
    ];
    return stepler;
  }
}
