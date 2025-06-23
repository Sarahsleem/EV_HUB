// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Connection to server failed`
  String get connectionToServerFailed {
    return Intl.message(
      'Connection to server failed',
      name: 'connectionToServerFailed',
      desc: '',
      args: [],
    );
  }

  /// `requestToTheServerWasCancelled`
  String get requestToTheServerWasCancelled {
    return Intl.message(
      'requestToTheServerWasCancelled',
      name: 'requestToTheServerWasCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Connection timeout with the server`
  String get connectionTimeoutWithTheServer {
    return Intl.message(
      'Connection timeout with the server',
      name: 'connectionTimeoutWithTheServer',
      desc: '',
      args: [],
    );
  }

  /// `Connection to the server failed due to internet connection`
  String get connectionToTheServerFailedDueToInternetConnection {
    return Intl.message(
      'Connection to the server failed due to internet connection',
      name: 'connectionToTheServerFailedDueToInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Receive timeout in connection with the server`
  String get receiveTimeOutInConnectionWithTheServer {
    return Intl.message(
      'Receive timeout in connection with the server',
      name: 'receiveTimeOutInConnectionWithTheServer',
      desc: '',
      args: [],
    );
  }

  /// `Send timeout in connection with the server`
  String get sendTimeoutInConnectionWithTheServer {
    return Intl.message(
      'Send timeout in connection with the server',
      name: 'sendTimeoutInConnectionWithTheServer',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected error occurred`
  String get UnexpectedErrorOccurred {
    return Intl.message(
      'Unexpected error occurred',
      name: 'UnexpectedErrorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `Card`
  String get Card {
    return Intl.message('Card', name: 'Card', desc: '', args: []);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Enter your mobile number`
  String get enteryourmobilenumber {
    return Intl.message(
      'Enter your mobile number',
      name: 'enteryourmobilenumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get enteryourpassword {
    return Intl.message(
      'Enter your password',
      name: 'enteryourpassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password`
  String get forgotpassword {
    return Intl.message(
      'Forgot password',
      name: 'forgotpassword',
      desc: '',
      args: [],
    );
  }

  /// `Login with Facebook`
  String get loginwithfacebook {
    return Intl.message(
      'Login with Facebook',
      name: 'loginwithfacebook',
      desc: '',
      args: [],
    );
  }

  /// `Login with Google`
  String get loginwithgoogle {
    return Intl.message(
      'Login with Google',
      name: 'loginwithgoogle',
      desc: '',
      args: [],
    );
  }

  /// `Login with Apple`
  String get loginwithapple {
    return Intl.message(
      'Login with Apple',
      name: 'loginwithapple',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Phone`
  String get phone {
    return Intl.message('Phone', name: 'phone', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Sign up`
  String get signup {
    return Intl.message('Sign up', name: 'signup', desc: '', args: []);
  }

  /// `Log In`
  String get signin {
    return Intl.message('Log In', name: 'signin', desc: '', args: []);
  }

  /// `Don't have an account?`
  String get donthaveaccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'donthaveaccount',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyhaveaccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyhaveaccount',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Name`
  String get enteryourname {
    return Intl.message(
      'Enter Your Name',
      name: 'enteryourname',
      desc: '',
      args: [],
    );
  }

  /// `Name can't be empty`
  String get namecannotbeempty {
    return Intl.message(
      'Name can\'t be empty',
      name: 'namecannotbeempty',
      desc: '',
      args: [],
    );
  }

  /// `Email can't be empty`
  String get emailcannotbeempty {
    return Intl.message(
      'Email can\'t be empty',
      name: 'emailcannotbeempty',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Email`
  String get EnterEmail {
    return Intl.message(
      'Enter your Email',
      name: 'EnterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email address`
  String get Enteravalidemailaddress {
    return Intl.message(
      'Enter a valid email address',
      name: 'Enteravalidemailaddress',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get tryagain {
    return Intl.message('Try again', name: 'tryagain', desc: '', args: []);
  }

  /// `New Cars`
  String get newcars {
    return Intl.message('New Cars', name: 'newcars', desc: '', args: []);
  }

  /// `Used Cars`
  String get usedcars {
    return Intl.message('Used Cars', name: 'usedcars', desc: '', args: []);
  }

  /// `Trucks`
  String get trucks {
    return Intl.message('Trucks', name: 'trucks', desc: '', args: []);
  }

  /// `Motorcycles`
  String get motorcycles {
    return Intl.message('Motorcycles', name: 'motorcycles', desc: '', args: []);
  }

  /// `Bikes`
  String get bikes {
    return Intl.message('Bikes', name: 'bikes', desc: '', args: []);
  }

  /// `Scooters`
  String get scooters {
    return Intl.message('Scooters', name: 'scooters', desc: '', args: []);
  }

  /// `Cars`
  String get cars {
    return Intl.message('Cars', name: 'cars', desc: '', args: []);
  }

  /// `Showrooms`
  String get showrooms {
    return Intl.message('Showrooms', name: 'showrooms', desc: '', args: []);
  }

  /// `Brands`
  String get brands {
    return Intl.message('Brands', name: 'brands', desc: '', args: []);
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Filter`
  String get filter {
    return Intl.message('Filter', name: 'filter', desc: '', args: []);
  }

  /// `Sort by`
  String get sortby {
    return Intl.message('Sort by', name: 'sortby', desc: '', args: []);
  }

  /// `Price`
  String get price {
    return Intl.message('Price', name: 'price', desc: '', args: []);
  }

  /// `Mileage`
  String get mileage {
    return Intl.message('Mileage', name: 'mileage', desc: '', args: []);
  }

  /// `Year`
  String get year {
    return Intl.message('Year', name: 'year', desc: '', args: []);
  }

  /// `Battery`
  String get Battery {
    return Intl.message('Battery', name: 'Battery', desc: '', args: []);
  }

  /// `Engine`
  String get Engine {
    return Intl.message('Engine', name: 'Engine', desc: '', args: []);
  }

  /// `Transmission`
  String get transmission {
    return Intl.message(
      'Transmission',
      name: 'transmission',
      desc: '',
      args: [],
    );
  }

  /// `Color`
  String get color {
    return Intl.message('Color', name: 'color', desc: '', args: []);
  }

  /// `Interior`
  String get interior {
    return Intl.message('Interior', name: 'interior', desc: '', args: []);
  }

  /// `Exterior`
  String get exterior {
    return Intl.message('Exterior', name: 'exterior', desc: '', args: []);
  }

  /// `Features`
  String get features {
    return Intl.message('Features', name: 'features', desc: '', args: []);
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `Motor Power`
  String get MotorPower {
    return Intl.message('Motor Power', name: 'MotorPower', desc: '', args: []);
  }

  /// `Engine Capacity`
  String get Engineapacity {
    return Intl.message(
      'Engine Capacity',
      name: 'Engineapacity',
      desc: '',
      args: [],
    );
  }

  /// `Charge Info`
  String get ChargeInfo {
    return Intl.message('Charge Info', name: 'ChargeInfo', desc: '', args: []);
  }

  /// `Motor Speed`
  String get MotorSpeed {
    return Intl.message('Motor Speed', name: 'MotorSpeed', desc: '', args: []);
  }

  /// `Seats`
  String get Seats {
    return Intl.message('Seats', name: 'Seats', desc: '', args: []);
  }

  /// `Status`
  String get status {
    return Intl.message('Status', name: 'status', desc: '', args: []);
  }

  /// `Logout`
  String get Logout {
    return Intl.message('Logout', name: 'Logout', desc: '', args: []);
  }

  /// `Settings`
  String get Settings {
    return Intl.message('Settings', name: 'Settings', desc: '', args: []);
  }

  /// `Language`
  String get Language {
    return Intl.message('Language', name: 'Language', desc: '', args: []);
  }

  /// `Theme`
  String get Theme {
    return Intl.message('Theme', name: 'Theme', desc: '', args: []);
  }

  /// `Dark Mode`
  String get DarkMode {
    return Intl.message('Dark Mode', name: 'DarkMode', desc: '', args: []);
  }

  /// `Light Mode`
  String get LightMode {
    return Intl.message('Light Mode', name: 'LightMode', desc: '', args: []);
  }

  /// `Arabic`
  String get Arabic {
    return Intl.message('Arabic', name: 'Arabic', desc: '', args: []);
  }

  /// `English`
  String get English {
    return Intl.message('English', name: 'English', desc: '', args: []);
  }

  /// `Dark`
  String get Dark {
    return Intl.message('Dark', name: 'Dark', desc: '', args: []);
  }

  /// `Light`
  String get Light {
    return Intl.message('Light', name: 'Light', desc: '', args: []);
  }

  /// `Save`
  String get Save {
    return Intl.message('Save', name: 'Save', desc: '', args: []);
  }

  /// `Language Changed`
  String get LanguageChanged {
    return Intl.message(
      'Language Changed',
      name: 'LanguageChanged',
      desc: '',
      args: [],
    );
  }

  /// `Your Email`
  String get YourEmail {
    return Intl.message('Your Email', name: 'YourEmail', desc: '', args: []);
  }

  /// `Phone Number`
  String get phonenumber {
    return Intl.message(
      'Phone Number',
      name: 'phonenumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid password`
  String get Enteravalidpassword {
    return Intl.message(
      'Enter a valid password',
      name: 'Enteravalidpassword',
      desc: '',
      args: [],
    );
  }

  /// `Continue as guest`
  String get continueasguest {
    return Intl.message(
      'Continue as guest',
      name: 'continueasguest',
      desc: '',
      args: [],
    );
  }

  /// `Nice to meet you`
  String get Nicetomeetyou {
    return Intl.message(
      'Nice to meet you',
      name: 'Nicetomeetyou',
      desc: '',
      args: [],
    );
  }

  /// `Login/Signup`
  String get LoginSignup {
    return Intl.message(
      'Login/Signup',
      name: 'LoginSignup',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `My Cars`
  String get myCars {
    return Intl.message('My Cars', name: 'myCars', desc: '', args: []);
  }

  /// `Favourite`
  String get favourite {
    return Intl.message('Favourite', name: 'favourite', desc: '', args: []);
  }

  /// `Help & FAQ`
  String get helpFaq {
    return Intl.message('Help & FAQ', name: 'helpFaq', desc: '', args: []);
  }

  /// `Contact Us`
  String get contactUs {
    return Intl.message('Contact Us', name: 'contactUs', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `العربية`
  String get arabic {
    return Intl.message('العربية', name: 'arabic', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'en')];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
