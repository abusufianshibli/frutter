import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frutter/common/utils/theme/custom_themes.dart';
import 'package:frutter/common/widgets/custom_button.dart';
import 'package:frutter/common/widgets/custom_card.dart';
import 'package:frutter/common/widgets/custom_text_form_filed.dart';
import 'package:image_picker/image_picker.dart';

import 'audio_player.dart';
import 'audio_recorder.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  TextEditingController _feedback=TextEditingController();

  // image piker

  List<Uint8List>? image;
  String imageName = '';
  final picker = ImagePicker();


  bool showPlayer = false;
  String? audioPath;

  @override
  void initState() {
    showPlayer = false;
    super.initState();
  }

  _openGallery(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    imageName = pickedFile.path;
    // authProvider.setProfileImg(filePath: imageName);
    setState(() {
      imageName;
    });
    Navigator.pop(context);
  }

  Future<void> _showImageDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Choose Image Source'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    key: const Key('fromFile'),
                    child: Row(
                      children: [
                        Container(
                          child: const FaIcon(FontAwesomeIcons.images),
                          width: 38,
                          alignment: Alignment.centerLeft,
                        ),
                        const Text('From file')
                      ],
                    ),
                    onTap: () => _openGallery(context),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Feedback Page"),
        centerTitle: true,
      ),
      body: CustomCard(
        margin: EdgeInsets.all(12),
        elevation: 5,
        child: Column(
          children: [
            CustomTextFormField(
              type: CustomTextFormFieldType.rounded,
              hintText: "Write your feedback",
              maxLines: 5,
             controller: _feedback,
            ),
            CustomSpacing.verticalSpace(),
            CustomCard(
                elevation: 5,
                child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    child:imageName!=''?Image.file(File(imageName),height: 100,width: 100,fit: BoxFit.cover,):Icon(Icons.image,size: 80,),
                    borderRadius: BorderRadius.all(Radius.circular(16),),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                      onPressed: (){
                        _showImageDialog(context);
                      },
                      height: 30,
                      text: "Select image",
                      type: CustomButtonType.outlined,
                    ),
                  ),
                )
              ],
            ),),

            CustomCard(
                margin: EdgeInsets.all(12),
                elevation: 5,
                child:showPlayer
                ? AudioPlayer(
                  source: audioPath!,
                  onDelete: () {
                    setState(() => showPlayer = false);
                  },
                ) : Recorder(
              onStop: (path) {
                print('Recorded file path: $path');
                setState(() {
                  audioPath = path;
                  showPlayer = true;
                });
              },
            ))
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomButton(
          text: "Submit",
          onPressed: (){},
        ),
      ),
    );
  }
}
