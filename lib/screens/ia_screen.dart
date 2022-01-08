import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class IAscreen extends StatefulWidget {
  const IAscreen({Key? key}) : super(key: key);

  @override
  _IAscreenState createState() => _IAscreenState();
}

class _IAscreenState extends State<IAscreen> {
  List<CameraDescription>? cameras;

  Future<void>main()async{
    WidgetsFlutterBinding.ensureInitialized();
    cameras= await availableCameras();
    runApp(IAscreen());
  }

  bool isWorking=false;
  String result="";
  CameraController? cameraController;
  CameraImage? imgCamera;

  initCamera(){
    cameraController=CameraController(cameras![0],ResolutionPreset.medium);
    cameraController!.initialize().then((value) {
      if(!mounted){
        return;
      }
      setState(() {
        cameraController!.startImageStream((imageFromStream) =>
        {
          if(!isWorking){
            isWorking=true,
            imgCamera=imageFromStream,
            runModelOnStreamFrames(),
          }
        });
      });
    });
  }

  Future loadImageModel() async {
    var result = await Tflite.loadModel(
      model: "assets/mobilenet_v1_1.0_224_quant.tflite",
      labels: "assets/labels_mobilenet_quant_v1_224.txt",
    );
    print("result: $result");
}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadImageModel();
  }

  runModelOnStreamFrames()async{
    if(imgCamera!=null){
      var recognitions = await Tflite.runModelOnFrame(
        bytesList: imgCamera!.planes.map((plane) {
          return plane.bytes;
        }).toList(),

        imageHeight: imgCamera!.height,
        imageWidth: imgCamera!.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 2,
        threshold: 0.1,
        asynch: true,
      );
      result="";

      recognitions!.forEach((response) {
        result+=response["label"] + "  " + (response["confidence"] as double).toStringAsFixed(2)+ "\n\n";
      });
      setState(() {
        result;
      });
      isWorking=false;
    }
  }

  @override
  void dispose()async {
    // TODO: implement dispose
    super.dispose();
    await Tflite.close();
    cameraController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text("Riconoscimento cani"),
            centerTitle: true,
            elevation: 4,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/icons/back.jpg"),
            ),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Center(
                    child: Container(
                      height: 320.0,
                      width: 360.0,
                      child: Image.asset("assets/icons/frame.jpg"),
                    ),
                  ),
                  Center(
                    child: TextButton(
                      onPressed: (){
                        initCamera();
                      },
                      child: Container(
                        margin: EdgeInsets.only(top:35),
                        height: 270,
                        width: 360,
                        child: imgCamera==null ?
                        Container(
                          height: 270,
                          width: 360,
                          child: Icon(Icons.photo_camera_front),
                        ): AspectRatio(aspectRatio: cameraController!.value.aspectRatio,
                          child: CameraPreview(cameraController!),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Center(child: Container(
                margin: const EdgeInsets.only(top: 55),
                child: SingleChildScrollView(
                  child: Text(result,
                    style: const TextStyle(
                      backgroundColor: Colors.white54,
                      fontSize: 25,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),)
            ],
          ),
        )
    ),
    );
  }
}
