import "dart:io";

import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import "package:vehicle_recognition/Utils/assets.dart";
import "package:vehicle_recognition/bloc/recognize_plate_bloc.dart";
import "package:vehicle_recognition/bloc/recognize_plate_events.dart";
import "package:vehicle_recognition/bloc/recognize_plate_state.dart";
import "package:vehicle_recognition/results.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  late ImagePicker _imagePicker;
  XFile? xfile;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  Future<void> _handlePickImage() async {
    final image = await _imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        xfile = image;
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'OKAY',
          textColor: Colors.yellow,
          onPressed: ScaffoldMessenger.of(context).removeCurrentSnackBar,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(100),
              ),
              image: DecorationImage(
                image: AssetImage(AssetNames.onboardingPage_2),
                fit: BoxFit.cover,
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(100),
              ),
              child: Container(
                color: Colors.purple[900]?.withOpacity(0.5),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 45, 20, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          ),
                          const CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                          )
                        ],
                      ),
                      BlocListener<RecognizePlateBloc, RecognizePlateState>(
                        listener: (_, state) {
                          state.maybeMap(
                              orElse: () {},
                              loading: (_) => _showSnackBar("loading..."),
                              success: (state) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ResultsPage(result: state.result),
                                  ),
                                );
                              },
                              error: (state) => _showSnackBar(state.message));
                        },
                        child: TextButton(
                          onPressed: () {
                            _handlePickImage().then((value) {
                              if (xfile != null) {
                                context.read<RecognizePlateBloc>().add(RecognizePlateEvent(xfile!));
                              }
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.purple[900]),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                            child: Text(
                              "Scan",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            "DETAILS OF NUMBER PLATE",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
