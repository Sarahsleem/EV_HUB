class ApiConstants {
  static const String baseUrl = 'https://evhubtl.com/wp-json/';
  static const String login = 'custom-api/v1/login';
  static const String registeration = 'custom-api/v1/register';

  static const String otp = 'custom-api/v1/verify-registration';

  static const String ads2 = 'wp/v2/ads2';
  static const String ads1 = 'wp/v2/ads';
  static const String cars = 'wp/v2/cars';

  static const String forgetPassword = 'custom-api/v1/forgot-password';

  static String verifyOtp = 'custom-api/v1/verify-otp';

  static String resetPassword = 'custom-api/v1/reset-password';

  static String carServices = 'wp/v2/service-centers';

  static String profile = "custom-api/v1/profile";

}

// Future<ProfileResponseModel?> fetchUserProfile() async {
//   try {
//     final String? token = await CashHelper.getStringSecured(key: Keys.token);
//     print('token: $token'); // إضافة await هنا
//     if (token == null || token.isEmpty) {
//       throw Exception("No token found, user must log in.");
//     }

//     Dio dio = Dio();
//     final response = await dio.get(
//       "https://evhubtl.com/wp-json/custom-api/v1/profile",
//       options: Options(
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       ),
//     );

//     if (response.statusCode == 200) {
//       final data = response.data;
//       return ProfileResponseModel.fromJson(data);
//     } else {
//       throw Exception("Failed to fetch profile: ${response.statusCode}");
//     }
//   } catch (error) {
//     print("Error fetching profile: $error");
//     return null;
//   }
// }
