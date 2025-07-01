import 'dart:io';

import 'package:evhub/features/add_services/data/models/service_model.dart';
import 'package:evhub/features/add_services/ui/widget/service_widget.dart';
import 'package:evhub/features/services/logic/services_cubit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';


class AddNewServiceScreen extends StatefulWidget {
  final String icon;
  final String title;

  const AddNewServiceScreen({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  State<AddNewServiceScreen> createState() => _AddNewServiceScreenState();
}

class _AddNewServiceScreenState extends State<AddNewServiceScreen> {
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final phoneController = TextEditingController();
  final whatsappController = TextEditingController();
  final locationController = TextEditingController();
  final personalNameController = TextEditingController();
  final personalPhoneController = TextEditingController();

  File? logoImage;
  File? coverImage;
  double? lat = 30.0444;
  double? lng = 31.2357;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('images/png/background.png', fit: BoxFit.cover),
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const BackButton(color: Colors.white),
                      const SizedBox(width: 8),
                      Text(
                        "Add New Service",
                        style: GoogleFonts.lato(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Image.asset(widget.icon, width: 30),
                      const SizedBox(width: 12),
                      Text(
                        widget.title,
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xF6F7F7F7),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          offset: const Offset(0, 4),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                    child: ListView(
                      children: [
                        CompanyLogoPicker(
                          label: "company logo",
                          onImageSelected: (file) => logoImage = file,
                        ),
                        CompanyLogoPicker(
                          label: "company cover",
                          onImageSelected: (file) => coverImage = file,
                        ),
                        const SizedBox(height: 24),
                        _buildInput("Company Name", "add company name", 60, nameController),
                        _buildInput("Company Description", "add short description", 300, descController, maxLines: 3),
                        _buildPhoneInput("Company Phone Number", phoneController),
                        _buildPhoneInput("Company Whatsapp Number", whatsappController),
                        _buildInput("Company Location", "add location", 60, locationController),
                        const Divider(height: 32),
                        Text(
                          "Personal Details",
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                            color: const Color(0xFF9B9B9B),
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildInput("Your Name", "add your name", 60, personalNameController),
                        _buildPhoneInput("Your Phone Number", personalPhoneController),
                        const SizedBox(height: 24),
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1D1D1D),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              "Submit",
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInput(String label, String hint, int maxLength, TextEditingController controller, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.lato(fontWeight: FontWeight.w600, fontSize: 14.sp)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          maxLength: maxLength,
          decoration: InputDecoration(
            hintText: hint,
            counterText: "",
            hintStyle: GoogleFonts.lato(color: const Color(0xFFD0D0D0)),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildPhoneInput(String label, TextEditingController controller) {
    return _buildInput(label, "", 10, controller);
  }

  void _submit() {
    if (logoImage == null || coverImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please upload both logo and cover.")));
      return;
    }

    final insuranceData = CompanyInfo(
      phoneNumber: "+20${phoneController.text}",
      whatsapp: "+20${whatsappController.text}",
      address: locationController.text,
      addressLocation: Location(lat: lat ?? 0.0, lng: lng ?? 0.0),
      companyImage: logoImage!.path,
      cover: coverImage!.path,
      website: "", // optional
    );

    context.read<ServicesCubit>().createInsurance(insuranceData);
  }
}
class CompanyLogoPicker extends StatefulWidget {
  final String label;
  final Function(File) onImageSelected;

  const CompanyLogoPicker({
    super.key,
    required this.label,
    required this.onImageSelected,
  });

  @override
  State<CompanyLogoPicker> createState() => _CompanyLogoPickerState();
}

class _CompanyLogoPickerState extends State<CompanyLogoPicker> {
  File? _imageFile;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 75);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      setState(() => _imageFile = file);
      widget.onImageSelected(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Row(
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: Colors.black,
            backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
            child: _imageFile == null
                ? ClipOval(
                    child: Image.asset(
                      'images/png/image (2).png',
                      fit: BoxFit.cover,
                      width: 30,
                      height: 30,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Text(
            'Add ${widget.label}',
            style: GoogleFonts.lato(fontSize: 14.sp, color: const Color(0xFF333333), fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
