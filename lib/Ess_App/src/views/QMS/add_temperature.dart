import 'dart:io';
import 'dart:typed_data';

import 'package:ess/Ess_App/src/services/local/navigation_service.dart';
import 'package:ess/Ess_App/src/services/remote/api_service.dart';
import 'package:ess/Ess_App/src/shared/bottons.dart';
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:ess/Ess_App/src/views/Loan/customtextfeild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import '../../base/utils/constants.dart';
import '../../models/api_response_models/warehouse_list_model.dart';
import '../../shared/top_app_bar.dart';
import 'package:image/image.dart' as img;  // Import the image package
import 'package:image_picker/image_picker.dart';

class TemperatureHumidityForm extends StatefulWidget {
  Warehouselist data;
  TemperatureHumidityForm({required this.data});
  @override
  _TemperatureHumidityFormState createState() => _TemperatureHumidityFormState();
}

class _TemperatureHumidityFormState extends State<TemperatureHumidityForm> {

  final TextEditingController warehouseController = TextEditingController();
  final TextEditingController roomLaneHallController = TextEditingController();
  final TextEditingController digitalThermometerController = TextEditingController();
  final TextEditingController currentTempController = TextEditingController();
  final TextEditingController maxTempController = TextEditingController();
  final TextEditingController minTempController = TextEditingController();
  final TextEditingController currentHumidityController = TextEditingController();
  final TextEditingController maxHumidityController = TextEditingController();
  final TextEditingController minHumidityController = TextEditingController();
  bool loading =false;
  String? currentTempImagePath;
  String? currentHumidityImagePath;

  void validate()

  {

    if(
    currentTempController.text.isNotEmpty &&  maxTempController.text.isNotEmpty &&
        minTempController.text.isNotEmpty &&
        currentHumidityController.text.isNotEmpty &&
        maxHumidityController.text.isNotEmpty && minHumidityController.text.isNotEmpty)
      {
        submit();
      }
      else
      {
        Constants.customWarningSnack(context, "Please fill all the feilds and images");
      }

  }



void submit()

{
  setState(() {loading =true;});
  ApiService api = ApiService();
  api.submit_temp(
      currentTempController.text,
      maxTempController.text,
      minTempController.text,
      currentHumidityController.text,
      maxHumidityController.text,
      minHumidityController.text,
      widget.data.sheetId,
      currentTempImagePath,
      currentHumidityImagePath
  ).then(   (value)
  {
    setState(() {
      loading =false;
    });
    clear();
    Constants.customSuccessSnack(context, value.toString());
  }
  ). onError((error, stackTrace)
  {
    setState(()
    {
      loading =false;
    });
    Constants.customErrorSnack(context, error.toString());
  }
  );
}

clear()

  {
  currentTempController.clear();
  maxTempController.clear();
  minTempController.clear();
  currentHumidityController.clear();
  maxHumidityController.clear();
  minHumidityController.clear();
  currentTempImagePath=null;
  currentHumidityImagePath=null;
  setState(() { });
  }

  Future<void> pickTemperatureImage() async
  {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      File file = File(pickedFile.path);
      List<int> imageBytes = await file.readAsBytes();
      img.Image? image = img.decodeImage(Uint8List.fromList(imageBytes));

      if (image != null)
      {
        img.Image compressedImage = img.copyResize(image, width: 800);
        List<int> compressedBytes = img.encodeJpg(compressedImage, quality: 80);
        final Directory tempDir = Directory.systemTemp;
        String compressedImagePath = '${tempDir.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg';
        File compressedFile = File(compressedImagePath)..writeAsBytesSync(compressedBytes);
        setState(() { currentTempImagePath = compressedFile.path;});}

      else { print("Failed to decode the image."); }
    }
  }



  Future<void> pickHumidityImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      File file = File(pickedFile.path);
      List<int> imageBytes = await file.readAsBytes();


      img.Image? image = img.decodeImage(Uint8List.fromList(imageBytes));

      if (image != null) {
        // Compress the image
        img.Image compressedImage = img.copyResize(image, width: 800);  // Resize (optional)
        List<int> compressedBytes = img.encodeJpg(compressedImage, quality: 80); // Compress with 80% quality

        // Save the compressed image to a new file
        final Directory tempDir = Directory.systemTemp;
        String compressedImagePath = '${tempDir.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg';
        File compressedFile = File(compressedImagePath)..writeAsBytesSync(compressedBytes);

        setState(() {
          currentHumidityImagePath = compressedFile.path; // Update the path with the compressed image
        });
      } else {
        // Handle the case where image could not be decoded
        print("Failed to decode the image.");
      }
    }
  }






  @override
  Widget build(BuildContext context)
  {
    return Scaffold(

      body:


          loading ?
          Center(child: CircularProgressIndicator(color: AppColors.primary,),)
          :
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 35,),
            AppBarwidget
                (
                title: widget.data.warehouseName,
                onMenuTap: ()
                {
                  Scaffold.of(context).openDrawer();
                },
                onNotificationTap: ()
                {
                }
                ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [







                    Text('Temperature in C', style: TextStyle(fontSize: 20,   fontWeight: FontWeight.bold, color: Colors.black)),
                    SizedBox(height: 10,),
                    CustomTextField(controller: currentTempController, labelText: "Current Temperature", inputType: TextInputType.number,),
                    SizedBox(height: 10,),
                    CustomTextField(controller: maxTempController, labelText: 'Max Temperature', inputType: TextInputType.number),
                    SizedBox(height: 10,),
                    CustomTextField(controller: minTempController, labelText: 'Min Temperature', inputType: TextInputType.number),
                    SizedBox(height: 20),
                    Text('Humidity in %', style: TextStyle(fontSize: 20,   fontWeight: FontWeight.bold , color: Colors.black)),
                    SizedBox(height: 10,),
                    CustomTextField(controller: currentHumidityController, labelText: "Current Humidity" , inputType: TextInputType.number),
                    SizedBox(height: 10,),
                    CustomTextField(controller: maxHumidityController, labelText: 'Max Humidity', inputType: TextInputType.number),
                    SizedBox(height: 10,),
                    CustomTextField(controller: minHumidityController, labelText: 'Min Humidity', inputType: TextInputType.number),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.primary, // Change this to your desired background color
                          ),
                          onPressed: pickTemperatureImage,
                          child: Row(
                            mainAxisSize: MainAxisSize.min, // Ensures the button size fits its content
                            children: [
                              Icon(
                                Icons.thermostat,  // Temperature icon (you can choose another icon)
                                color: Colors.white, // Icon color
                              ),
                              // Adds some space between the icon and the text
                              Text(
                                currentTempImagePath == null
                                    ? 'Take Temperature Image'
                                    : 'Change Temperature Image',
                                style: TextStyle(color: AppColors.white),
                              ),
                            ],
                          ),
                        ),
                        if (currentTempImagePath != null)
                          Icon(Icons.check_circle, color: Colors.green),
                      ],
                    ),


                    SizedBox(height: 20),
                    Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.primary, // Change this to your desired background color
                          ),
                          onPressed: pickHumidityImage,
                          child: Row(
                            children: [
                              Icon(
                                Icons.water_drop,  // Temperature icon (you can choose another icon)
                                color: Colors.white, // Icon color
                              ),
                              Text(currentHumidityImagePath == null ? 'Take Humidity Image' : 'Change Humidity Image'
                                ,
                                style: TextStyle(color: AppColors.white),
                              ),
                            ],
                          ),
                        ),
                        if (currentHumidityImagePath != null)
                          Icon(Icons.check_circle, color: Colors.green),
                      ],
                    ),


                    SizedBox(height: 30),
                   MainButton(
                       text: "Submit", onTap: (){
                     validate();
                   })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
