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
  static TextStyle poppinsRegular16ContantGray= GoogleFonts.poppins(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.contantGray,
  );
  static TextStyle latoRegular14lightBlack = GoogleFonts.lato(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.lightBlack,
  );

  static TextStyle poppinsMedium11ContantGray= GoogleFonts.poppins(
    fontSize: 11.sp,
    fontWeight: FontWeightHelper.medium,
    color: ColorsManager.contantGray,
  );
  static TextStyle poppinsSemiBold12White= GoogleFonts.poppins(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: Colors.white,
  );
  static TextStyle poppinsMedium17lighterGray= GoogleFonts.poppins(
    fontSize: 17.5.sp,
    fontWeight: FontWeightHelper.medium,
    color: ColorsManager.maGray,
  );
  static TextStyle poppinsRegular12lighterGray= GoogleFonts.poppins(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.contantGray,
  );
  static TextStyle  latoBold12red=GoogleFonts.lato(
    fontSize: 12.sp, // Responsive font size (assuming screen_util is used)
    fontWeight:  FontWeightHelper.bold, // Custom font weight or directly use FontWeight.bold
    color: ColorsManager.red, // Custom color
  );

  static TextStyle poppinsMedium12contantGray= GoogleFonts.poppins(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.contantGray,
  );
  static TextStyle poppinsRegular16Gray= GoogleFonts.poppins(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.daGray,
  );
  static TextStyle poppinsRegular16LightGray= GoogleFonts.poppins(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.LigGthGray,
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
    color: Colors.white,
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

  static  TextStyle latoKprimary28Bold=GoogleFonts.lato(fontSize: 28.sp,color: ColorsManager.kPrimaryColor,fontWeight: FontWeight.bold);

  static TextStyle inter19BlackBold=GoogleFonts.inter(fontWeight: FontWeight.bold,fontSize: 19.5.sp,color: ColorsManager.darkBlack);
  static TextStyle inter16greyMedium=GoogleFonts.inter(fontWeight: FontWeightHelper.medium,fontSize: 16.sp,color: ColorsManager.lighterGray);

  static TextStyle latoWhite16Bold=GoogleFonts.lato(fontSize: 16.sp,color: Colors.white,fontWeight: FontWeight.bold);

  static TextStyle inter20greyBold=GoogleFonts.inter(fontWeight: FontWeight.bold,fontSize: 20.sp,color: ColorsManager.lightGrey);

  static TextStyle inter14WhiteSemiBold=GoogleFonts.inter(fontWeight: FontWeightHelper.semiBold,fontSize: 14.sp,color: Colors.white);

  static TextStyle latoGrey16SemiBold=GoogleFonts.lato(fontSize: 16.sp,fontWeight: FontWeightHelper.semiBold,color: ColorsManager.gry);

  static TextStyle latoWhite12Bold=GoogleFonts.lato(fontSize: 12.sp,fontWeight: FontWeight.bold,color: Colors.white);

  static TextStyle inter12WhiteRegular=GoogleFonts.inter(fontSize: 12.sp,color: Colors.white,fontWeight: FontWeightHelper.regular);

  static TextStyle lato15RegularLightgray=GoogleFonts.lato(fontSize: 15.sp,fontWeight: FontWeightHelper.regular,color: ColorsManager.lightGrey);

  static TextStyle lato16BoldBlack=GoogleFonts.lato(fontSize: 16.sp,fontWeight: FontWeight.bold,color: Colors.black);

  static TextStyle lato16SemiBoldLight=GoogleFonts.lato(fontSize: 16.sp,fontWeight: FontWeightHelper.semiBold,color: ColorsManager.lightGrey);

  static TextStyle lato14RegularDark=GoogleFonts.lato(fontSize: 14.sp,fontWeight: FontWeightHelper.regular,color: ColorsManager.lightGrey);

  static TextStyle lato28BoldGreen=GoogleFonts.lato(fontSize: 28.sp,fontWeight: FontWeightHelper.bold,color: ColorsManager.kPrimaryColor);

  static TextStyle lato16RegularhintGray=GoogleFonts.lato(fontSize: 16.sp,fontWeight: FontWeightHelper.regular,color: Color(0xff696969));

  static TextStyle lato15SemiBoldBlack=GoogleFonts.lato(fontSize: 15.sp,fontWeight: FontWeightHelper.semiBold,color: Colors.black);
  static TextStyle workSans15RegularBlack=GoogleFonts.workSans(fontSize: 15.sp,fontWeight: FontWeightHelper.regular,color: Colors.black);

  static TextStyle lato13RegularGrey=GoogleFonts.lato(fontSize: 13.sp,fontWeight: FontWeightHelper.regular,color: ColorsManager.lightGrey);

  static TextStyle lato17BoldDarkBlue=GoogleFonts.lato(fontSize: 17.sp,fontWeight: FontWeight.bold,color: Color(0xff263F4D));

  static TextStyle lato12MediumDarkBlue=GoogleFonts.lato(fontSize: 12.sp,fontWeight: FontWeightHelper.medium,color: Color(0xff263F4D));

  static TextStyle latogrey12Medium=GoogleFonts.lato(fontSize: 12.sp,fontWeight: FontWeightHelper.medium,color: Color(0xff4C4C4C));

  static TextStyle lato21Regulargrey=GoogleFonts.lato(fontSize: 21.sp,fontWeight: FontWeightHelper.regular,color: ColorsManager.lightGrey);

  static TextStyle lato21SemiBoldDarkBlue=GoogleFonts.lato(fontSize: 21.sp,fontWeight: FontWeightHelper.semiBold,color: Color(0xff263F4D));

  static TextStyle inter18WhiteMedium=GoogleFonts.inter(fontSize: 18.sp,color: Colors.white,fontWeight: FontWeightHelper.medium);

  static TextStyle inter13greyRegular=GoogleFonts.inter(fontSize: 13.sp,fontWeight: FontWeightHelper.regular,color: Color(
      0xbaffffff));

  static TextStyle lato9SemiBoldWhite=GoogleFonts.lato(fontSize: 9.sp,color: Colors.white,fontWeight: FontWeightHelper.semiBold);

  static TextStyle inter10GreySemiBold=GoogleFonts.inter(fontSize: 10.sp,color: Color(
      0xc2ffffff),fontWeight: FontWeightHelper.semiBold);
      static final TextStyle latoWhite21SemiBold = GoogleFonts.lato(
  fontSize: 21.sp,
  fontWeight: FontWeight.w600, // SemiBold
  height: 29.8 / 21,
  letterSpacing: -0.88,
  color: Colors.white,
);
static final TextStyle latoWhite9SemiBold = GoogleFonts.lato(
  fontSize: 9.sp,
  fontWeight: FontWeight.w600,
  height: 10 / 9,
  letterSpacing: 0.0,
  color: Colors.white,
);

  static TextStyle latoBold40Green=GoogleFonts.lato(fontSize: 40.sp,fontWeight: FontWeight.bold,color: Color(0xff68A850));

}
