import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';
import 'font_weight.dart';

class TextStyles {
  static TextStyle font24BlackBold =  GoogleFonts.poppins(
    fontSize: 24.sp,
    fontWeight: FontWeightHelper.bold,
    color: Colors.black,
  );

  static TextStyle font32BlueBold = GoogleFonts.poppins(
    fontSize: 32.sp,
    fontWeight: FontWeightHelper.bold,
    color: ColorsManager.mainBlue,
  );
    
    static TextStyle font18WhiteSemiBold = GoogleFonts.poppins(
    fontSize: 18.sp,
    fontWeight: FontWeightHelper.semiBold,
  );

  static TextStyle font30WhiteSemiBold = GoogleFonts.poppins(
    fontSize: 30.sp,
    fontWeight: FontWeightHelper.semiBold,
  );

  static TextStyle font22WhiteMedium = GoogleFonts.poppins(
    fontSize: 22.sp,
    fontWeight: FontWeightHelper.medium,
  );

  static TextStyle font15WhiteRegular = GoogleFonts.poppins(
    fontSize: 15.sp,
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle font18WhiteMedium = GoogleFonts.poppins(
    fontSize: 18.sp,
    fontWeight: FontWeightHelper.medium,
  );
  static TextStyle font16WhiteRegular = GoogleFonts.poppins(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.regular,
  );
  static TextStyle font16KprimaryRegular = GoogleFonts.poppins(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.kPrimaryColor,
  );
  static TextStyle font15KprimaryRegular = GoogleFonts.poppins(
    fontSize: 15.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.kPrimaryColor,
  );
  static TextStyle font20BlackMedium = GoogleFonts.poppins(
    fontSize: 20.sp,
    fontWeight: FontWeightHelper.medium,
    color: Colors.black,
  );
  static TextStyle font15DarkGreyRegular = GoogleFonts.poppins(
    fontSize: 15.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.lightGrey,
  );
  static TextStyle font12PurpleRegular = GoogleFonts.poppins(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.purple,
  );
  static TextStyle font24KprimaryMedium = GoogleFonts.poppins(
    fontSize: 24.sp,
    fontWeight: FontWeightHelper.medium,
    color: ColorsManager.kPrimaryColor,
  );
  static TextStyle font12WhiteRegular = GoogleFonts.poppins(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.regular,

  );
  static TextStyle font16BlackRegular  = GoogleFonts.poppins(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.regular,
    color: Colors.black,
  );
  static TextStyle font12MoreLightGrey = GoogleFonts.poppins(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.moreLightGray,
  );
  static TextStyle font28WhiteMedium = GoogleFonts.poppins(
    fontSize: 28.sp,
    fontWeight: FontWeightHelper.medium,
    //color: Colors.white,
  );
  static TextStyle font14WhiteRegular = GoogleFonts.poppins(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
    //color: Colors.white,
  );
  static TextStyle font18PurpleMedium = GoogleFonts.poppins(
    fontSize: 18.sp,
    fontWeight: FontWeightHelper.medium,
    color: ColorsManager.purple,
  );
  static TextStyle font30PurpleBold = GoogleFonts.poppins(
    fontSize: 30.sp,
    fontWeight: FontWeightHelper.bold,
    color: ColorsManager.purple,
  );

  static TextStyle font16RegularNoneYEllow=GoogleFonts.poppins(fontSize: 16.sp,color: ColorsManager.kPrimaryColor);

  static TextStyle font24WhiteMedium= GoogleFonts.poppins(
    fontSize: 24.sp,
    fontWeight: FontWeightHelper.medium,
    color: Colors.white,
  );

  static TextStyle font48PurpleSemiBold=GoogleFonts.poppins(fontSize: 48.sp,color: ColorsManager.purple,fontWeight: FontWeightHelper.semiBold);

  static TextStyle font60kprimaryMedium=GoogleFonts.poppins(fontWeight: FontWeightHelper.medium,fontSize: 60.sp,color: ColorsManager.kPrimaryColor);

  static TextStyle font21SemiBoldsecondPurple=GoogleFonts.poppins(fontWeight: FontWeightHelper.semiBold,fontSize: 21.sp,color: ColorsManager.secondaryPurple);

  static TextStyle font16SemiBoldRed=GoogleFonts.poppins(fontWeight: FontWeightHelper.semiBold,fontSize: 16.sp,color: Color(0xffD34657));
}
