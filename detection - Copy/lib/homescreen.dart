import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Variables
  File? imageFile;
  late File _image;
  late List _results = [];
  bool imageSelect = false;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future loadModel() async {
    Tflite.close();
    String res;
    res = (await Tflite.loadModel(
        model: "assets/model_unquant.tflite", labels: "assets/labels.txt"))!;
    print('Model Loading Status: $res');
  }

  Future imageClassification(File image) async {
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _results = recognitions!;
      _image = image;
      imageSelect = true;
    });
  }

  /// Widget
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(false), //<-- SEE HERE
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => exit(0),
                // Navigator.of(context).pop(true), // <-- SEE HERE
                child: const Text('Yes'),
              ),
            ],
          ),
        );
        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(false);
        }
      },
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.red,
          textTheme: const TextTheme(
            headline1: TextStyle(color: Colors.deepPurpleAccent),
            headline2: TextStyle(color: Colors.deepPurpleAccent),
            bodyText2: TextStyle(color: Colors.deepPurpleAccent),
            subtitle1: TextStyle(color: Colors.pinkAccent),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(32),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://images.pexels.com/photos/5946083/pexels-photo-5946083.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                  fit: BoxFit.cover,
                ),
              ),
              child: imageFile == null
                  ? Container(
                      alignment: Alignment.topCenter,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: sort_child_properties_last
                        children: [
                          Center(
                            child: Image.asset(
                              'assets/images/applogo.png',
                              scale: 6,
                            ),
                          ),
                        ],

                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    )
                  : Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 320),
                            child: Image.file(
                              imageFile!,
                              fit: BoxFit.cover,
                              height: 200,
                              width: 200,
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: _results.map((results) {
                              return Card(
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  child: Text(
                                      "${results['label']} - ${results['confidence'].toStringAsFixed(2)}"),
                                ),
                              );
                            }).toList(),
                          ),
                        )
                      ],
                    ),
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    heroTag: "tag",
                    onPressed: () {
                      _getFromGallery();
                    },
                    child: const Icon(Icons.drive_file_move_rtl),
                  ),
                  Expanded(child: Container()),
                  FloatingActionButton(
                    heroTag: "abc",
                    onPressed: () {
                      _getFromCamera();
                    },
                    child: const Icon(Icons.camera_alt_rounded),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  /// Get from gallery
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      imageClassification(imageFile!);
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      imageClassification(imageFile!);
    }
  }
}
