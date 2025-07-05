import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/theming/styles.dart';

import 'package:image_picker/image_picker.dart';

import '../../../../generated/l10n.dart';


class CircleAvatr extends StatefulWidget{
  final String user;
  const CircleAvatr({Key? key,
       required this.user, }): super(key: key);

  @override
  State<CircleAvatr> createState() => _CircleAvatrState();
}

class _CircleAvatrState extends State<CircleAvatr> {
  File? _image;




  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:  Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null
                    ? CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('images/png/no_image_found.jpg'), // Profile image URL
                )
                    : null,
              ),
            ),
            SizedBox(height: 16),
            Text(
        widget.user,
              style: TextStyles.poppinsMedium17lighterGray,
            ),
            SizedBox(height: 6),
            Text(
              S.of(context).User,
              style: TextStyles.poppinsRegular12lighterGray,
            ),
          ],
        ),
      ),
    );
  }
}