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
  int _aktifStep = 0;
  String kullaniciIsmi = "", mail = "", sifre = "";
  late List<Step> tumStepler;
  var keyName = GlobalKey<FormFieldState>();
  var keyMail = GlobalKey<FormFieldState>();
  var keyPassword = GlobalKey<FormFieldState>();
  bool hata = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    tumStepler = _tumStepler();
    return Scaffold(
      appBar: AppBar(
        title: Text("Stepper Uygulaması"),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Stepper(
          currentStep: _aktifStep,
          /*
          onStepTapped: (tiklananStepIndex) {
            setState(() {
              _aktifStep = tiklananStepIndex;
            });
          },*/
          onStepContinue: () {
            setState(() {
              _ileriButonuKontrolu();
            });
          },
          onStepCancel: () {
            setState(() {});
            if (_aktifStep > 0) {
              _aktifStep--;
            } else {
              _aktifStep = 0;
            }
          },
          steps: tumStepler,
        ),
      ),
    );
  }

  List<Step> _tumStepler() {
    List<Step> stepler = [
      Step(
        title: Text("Username Baslik"),
        content: TextFormField(
          key: keyName,
          onSaved: (gelenName) {
            kullaniciIsmi = gelenName!;
          },
          validator: (girilenUserName) {
            if (girilenUserName!.length < 6) {
              return "en az 6 karakter olabilir";
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            labelText: "Username",
            hintText: "Kullanici Adı",
            border: OutlineInputBorder(),
          ),
        ),
        subtitle: Text("Username Altbaslik"),
        state: statelerAyarla(0),
        isActive: true,
      ),
      Step(
        title: Text("Mail Başlık"),
        subtitle: Text("Mail Alt Başlık"),
        state: statelerAyarla(1),
        isActive: true,
        content: TextFormField(
          onSaved: (gelenMail) {
            mail = gelenMail!;
          },
          key: keyMail,
          validator: (girilenMail) {
            if (!girilenMail!.contains("@")) {
              return "en az 6 karakter olabilir";
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Email",
            hintText: "Mail girin",
          ),
        ),
      ),
      Step(
        title: Text("Şifre Başilık"),
        subtitle: Text("Şifre Alt Başlık"),
        state: statelerAyarla(2),

        isActive: true,
        content: TextFormField(
          onSaved: (gelenSifre) {
            sifre = gelenSifre!;
          },
          key: keyPassword,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Password",
            hintText: "Şifre girin",
          ),
        ),
      ),
    ];
    return stepler;
  }

  StepState statelerAyarla(int oAnkiStep) {
    if (_aktifStep == oAnkiStep) {
      if (hata) {
        return StepState.error;
      } else {
        return StepState.editing;
      }
    } else {
      return StepState.complete;
    }
  }

  void _ileriButonuKontrolu() {
    switch (_aktifStep) {
      //0. indx baslangıcı
      case 0:
        if (keyName.currentState!.validate()) {
          keyName.currentState!.save();
          hata = false;
          _aktifStep = 1;
        } else {
          hata = true;
        }
        break;
      case 1:
        if (keyMail.currentState!.validate()) {
          keyMail.currentState!.save();
          hata = false;
          _aktifStep = 2;
        } else {
          hata = true;
        }
        break;
      case 2:
        if (keyPassword.currentState!.validate()) {
          keyPassword.currentState!.save();
          hata = false;
          _aktifStep = 2;
          formTamamlandi();
        } else {
          hata = true;
        }
        break;
    }
  }

  void formTamamlandi() {
    String result =
        "Girilen değerler: isim => $kullaniciIsmi, email => $mail, sifre => $sifre";
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          result,
          style: TextStyle(color: Colors.white, fontSize: 38),
        ),
        backgroundColor: Colors.indigoAccent,
      ),
    );
  }
}
