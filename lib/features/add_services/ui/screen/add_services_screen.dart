import 'dart:io';

import 'package:evhub/features/add_services/ui/widget/service_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class AddNewServiceScreen extends StatelessWidget {
  const AddNewServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset('images/png/background.png', fit: BoxFit.cover),
          ),
          // Content
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 16),
                // Header
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
                // Insurance Card
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: InsuranceHeaderCard(
                    iconPath: 'images/png/insurance.png',
                  ),
                ),
                const SizedBox(height: 20),
                // Form container
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xF6F7F7F7), // 96% opacity
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
                        const CompanyLogoPicker(label: "company logo",),
    const CompanyLogoPicker(label: "company cover",),
                        const SizedBox(height: 24),
                        _buildInput("Company Name", "add company name", 60),
                        _buildInput(
                          "Company Description",
                          "add short Description name",
                          300,
                          maxLines: 3,
                        ),
                        _buildPhoneInput("Company Phone Number"),
                        _buildPhoneInput("Company Whatsapp Number"),
                        _buildLocationInput(),
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
                        _buildInput("Your Name", "add Your name", 60),
                        _buildPhoneInput("Your Phone Number"),
                        const SizedBox(height: 24),
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {},
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

  Widget _buildInput(
    String label,
    String hint,
    int maxLength, {
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 22.7.sp,
            fontWeight: FontWeight.w500, // Medium = w500
            letterSpacing: -0.67,
            height: 1.0,
            color: const Color(0xFF3C3C3C),
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          maxLines: maxLines,
          maxLength: maxLength,
          decoration: InputDecoration(
            hintText: hint,
            counterText: "",
            hintStyle: GoogleFonts.lato(color: const Color(0xFFD0D0D0)),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
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

  Widget _buildPhoneInput(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.lato(
            color: const Color(0xFF9B9B9B),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          keyboardType: TextInputType.phone,
          maxLength: 10,
          decoration: InputDecoration(
            prefixText: "+20 ",
            counterText: "",
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
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

  Widget _buildLocationInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Company Location",
          style: GoogleFonts.lato(
            color: const Color(0xFF9B9B9B),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          decoration: InputDecoration(
            hintText: "add location",
            hintStyle: GoogleFonts.lato(color: const Color(0xFFD0D0D0)),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            suffixIcon: TextButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.location_on_outlined,
                size: 18,
                color: Colors.black,
              ),
              label: Text(
                "open map",
                style: GoogleFonts.lato(fontSize: 12.sp, color: Colors.black),
              ),
            ),
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
}

class CompanyLogoPicker extends StatefulWidget {
  final String label;
  const CompanyLogoPicker({super.key, required this.label});

  @override
  State<CompanyLogoPicker> createState() => _CompanyLogoPickerState();
}

class _CompanyLogoPickerState extends State<CompanyLogoPicker> {
  File? _imageFile;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Row(
        children: [
          CircleAvatar(
            radius:15,
            backgroundColor: Colors.black,
            backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
            child:
                _imageFile == null
                    ? const Icon(Icons.camera_alt, color: Colors.white)
                    : null,
          ),
          const SizedBox(width: 12),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Add ',
                  style: GoogleFonts.lato(
                    color: const Color(0xFF9B9B9B),
                    fontSize: 14.sp,
                  ),
                ),
                TextSpan(
                  text: widget.label,
                  style: GoogleFonts.lato(
                    color: const Color(0xFF333333),
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
