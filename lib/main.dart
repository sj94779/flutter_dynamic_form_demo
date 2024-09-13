import 'package:flutter/material.dart';
import 'package:flutter_dynamic_form_demo/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'dynamic_form_one/screen/dynamic_form_one_screen.dart';
import 'dynamic_form_one/view_model/dynamic_form_one_view_model.dart';
import 'dynamic_form_two/dynamic_form_two_screen.dart';
import 'dynamic_form_two/view_model/dynamic_form_two_view_model.dart';


void main() {
  runApp(MultiProvider( providers: [

    ChangeNotifierProvider(create: (context) => DynamicFormOneViewModel()),
    ChangeNotifierProvider(create: (context) => DynamicFormTwoViewModel()),
  ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dynamic Form Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Chart Demo'),

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const DynamicFormOneScreen()));
                },
                child: const Text(
                  "Dynamic form one",
                  style: TextStyle(color: AppColors.darkBlue),
                )),
            const SizedBox(height: 20,),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>  DynamicFormTwoScreen()));
                },
                child: const Text(
                  "Dynamic form two",
                  style: TextStyle(color: AppColors.darkBlue),
                )),

          ],
        ),
      ),
    );

  }
}


