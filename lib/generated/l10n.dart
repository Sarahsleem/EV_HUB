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
