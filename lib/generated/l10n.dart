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

  /// `car Market places`
  String get carMarketplaces {
    return Intl.message(
      'car Market places',
      name: 'carMarketplaces',
      desc: '',
      args: [],
    );
  }

  /// `Your Location`
  String get YourLocation {
    return Intl.message(
      'Your Location',
      name: 'YourLocation',
      desc: '',
      args: [],
    );
  }

  /// `Battery Low?\nFind a Charger`
  String get BatteryLow {
    return Intl.message(
      'Battery Low?\nFind a Charger',
      name: 'BatteryLow',
      desc: '',
      args: [],
    );
  }

  /// `Electric Cars`
  String get ElectricCars {
    return Intl.message(
      'Electric Cars',
      name: 'ElectricCars',
      desc: '',
      args: [],
    );
  }

  /// `See all`
  String get Seeall {
    return Intl.message('See all', name: 'Seeall', desc: '', args: []);
  }

  /// `add to Fav`
  String get addtoFav {
    return Intl.message('add to Fav', name: 'addtoFav', desc: '', args: []);
  }

  /// `      Explore`
  String get Explore {
    return Intl.message('      Explore', name: 'Explore', desc: '', args: []);
  }

  /// `Car Brands`
  String get CarBrands {
    return Intl.message('Car Brands', name: 'CarBrands', desc: '', args: []);
  }

  /// `Services`
  String get Services {
    return Intl.message('Services', name: 'Services', desc: '', args: []);
  }

  /// `sell`
  String get sell {
    return Intl.message('sell', name: 'sell', desc: '', args: []);
  }

  /// `your car`
  String get yourcar {
    return Intl.message('your car', name: 'yourcar', desc: '', args: []);
  }

  /// `sell now`
  String get sellnow {
    return Intl.message('sell now', name: 'sellnow', desc: '', args: []);
  }

  /// `Contact Us`
  String get ContactUs {
    return Intl.message('Contact Us', name: 'ContactUs', desc: '', args: []);
  }

  /// `Help & FAQ`
  String get HelpFAQ {
    return Intl.message('Help & FAQ', name: 'HelpFAQ', desc: '', args: []);
  }

  /// `Favourite`
  String get Favourite {
    return Intl.message('Favourite', name: 'Favourite', desc: '', args: []);
  }

  /// `Home`
  String get Home {
    return Intl.message('Home', name: 'Home', desc: '', args: []);
  }

  // skipped getter for the 'My Cars' key

  /// `Car`
  String get Car {
    return Intl.message('Car', name: 'Car', desc: '', args: []);
  }

  /// ` Search for anything `
  String get Searchforanything {
    return Intl.message(
      ' Search for anything ',
      name: 'Searchforanything',
      desc: '',
      args: [],
    );
  }

  /// `No Cars Found`
  String get NoCarsFound {
    return Intl.message(
      'No Cars Found',
      name: 'NoCarsFound',
      desc: '',
      args: [],
    );
  }

  /// `Start From`
  String get StartFrom {
    return Intl.message('Start From', name: 'StartFrom', desc: '', args: []);
  }

  /// `Used`
  String get Used {
    return Intl.message('Used', name: 'Used', desc: '', args: []);
  }

  /// `Good Condition`
  String get GoodCondition {
    return Intl.message(
      'Good Condition',
      name: 'GoodCondition',
      desc: '',
      args: [],
    );
  }

  /// `add review`
  String get addreview {
    return Intl.message('add review', name: 'addreview', desc: '', args: []);
  }

  /// `Write a review`
  String get Writeareview {
    return Intl.message(
      'Write a review',
      name: 'Writeareview',
      desc: '',
      args: [],
    );
  }

  /// `Blogs`
  String get Blogs {
    return Intl.message('Blogs', name: 'Blogs', desc: '', args: []);
  }

  /// `No Posts`
  String get noPosts {
    return Intl.message('No Posts', name: 'noPosts', desc: '', args: []);
  }

  /// `All`
  String get All {
    return Intl.message('All', name: 'All', desc: '', args: []);
  }

  /// `Car Filter`
  String get CarFilter {
    return Intl.message('Car Filter', name: 'CarFilter', desc: '', args: []);
  }

  /// `Reset all`
  String get Resetall {
    return Intl.message('Reset all', name: 'Resetall', desc: '', args: []);
  }

  /// `Search`
  String get Search {
    return Intl.message('Search', name: 'Search', desc: '', args: []);
  }

  /// `Min price cannot be greater than Max price`
  String get Minpricecane {
    return Intl.message(
      'Min price cannot be greater than Max price',
      name: 'Minpricecane',
      desc: '',
      args: [],
    );
  }

  /// `Max`
  String get Max {
    return Intl.message('Max', name: 'Max', desc: '', args: []);
  }

  /// `Min`
  String get Min {
    return Intl.message('Min', name: 'Min', desc: '', args: []);
  }

  /// `Price range`
  String get Pricerange {
    return Intl.message('Price range', name: 'Pricerange', desc: '', args: []);
  }

  /// `Choose car model`
  String get Choosecarmodel {
    return Intl.message(
      'Choose car model',
      name: 'Choosecarmodel',
      desc: '',
      args: [],
    );
  }

  /// `Choose year`
  String get Chooseyear {
    return Intl.message('Choose year', name: 'Chooseyear', desc: '', args: []);
  }

  /// `Choose car style`
  String get Choosecarstyle {
    return Intl.message(
      'Choose car style',
      name: 'Choosecarstyle',
      desc: '',
      args: [],
    );
  }

  /// `Choose car Brand`
  String get ChoosecarBrand {
    return Intl.message(
      'Choose car Brand',
      name: 'ChoosecarBrand',
      desc: '',
      args: [],
    );
  }

  /// `Results`
  String get Results {
    return Intl.message('Results', name: 'Results', desc: '', args: []);
  }

  /// `Type`
  String get Type {
    return Intl.message('Type', name: 'Type', desc: '', args: []);
  }

  /// `New`
  String get New {
    return Intl.message('New', name: 'New', desc: '', args: []);
  }

  /// `Car Agency`
  String get caragrncy {
    return Intl.message('Car Agency', name: 'caragrncy', desc: '', args: []);
  }

  /// `New Cars`
  String get Newcars {
    return Intl.message('New Cars', name: 'Newcars', desc: '', args: []);
  }

  /// `Used Cars`
  String get Usedcars {
    return Intl.message('Used Cars', name: 'Usedcars', desc: '', args: []);
  }

  /// `LE`
  String get LE {
    return Intl.message('LE', name: 'LE', desc: '', args: []);
  }

  /// `Car Details`
  String get carDetails {
    return Intl.message('Car Details', name: 'carDetails', desc: '', args: []);
  }

  /// `Search Results`
  String get SearchResults {
    return Intl.message(
      'Search Results',
      name: 'SearchResults',
      desc: '',
      args: [],
    );
  }

  /// `Max Price`
  String get MaxPrice {
    return Intl.message('Max Price', name: 'MaxPrice', desc: '', args: []);
  }

  /// `Min Price`
  String get MinPrice {
    return Intl.message('Min Price', name: 'MinPrice', desc: '', args: []);
  }

  /// `Last Arrived`
  String get LastArrived {
    return Intl.message(
      'Last Arrived',
      name: 'LastArrived',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout?`
  String get SureuouwanttoLogout {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'SureuouwanttoLogout',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get Cancel {
    return Intl.message('Cancel', name: 'Cancel', desc: '', args: []);
  }

  /// `Insurance`
  String get insurance {
    return Intl.message('Insurance', name: 'insurance', desc: '', args: []);
  }

  /// `Charging stations`
  String get Chargingstations {
    return Intl.message(
      'Charging stations',
      name: 'Chargingstations',
      desc: '',
      args: [],
    );
  }

  /// `protection`
  String get protection {
    return Intl.message('protection', name: 'protection', desc: '', args: []);
  }

  /// `Insurance`
  String get insuranceTitle {
    return Intl.message(
      'Insurance',
      name: 'insuranceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Car insurance covers your vehicle and damages in case of accidents or theft.`
  String get insuranceDesc {
    return Intl.message(
      'Car insurance covers your vehicle and damages in case of accidents or theft.',
      name: 'insuranceDesc',
      desc: '',
      args: [],
    );
  }

  /// `Car Service`
  String get carServiceTitle {
    return Intl.message(
      'Car Service',
      name: 'carServiceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Car service keeps your vehicle running smoothly with regular maintenance and checks.`
  String get carServiceDesc {
    return Intl.message(
      'Car service keeps your vehicle running smoothly with regular maintenance and checks.',
      name: 'carServiceDesc',
      desc: '',
      args: [],
    );
  }

  /// `Car Protection Film`
  String get protectionFilmTitle {
    return Intl.message(
      'Car Protection Film',
      name: 'protectionFilmTitle',
      desc: '',
      args: [],
    );
  }

  /// `Car protection film shields your car’s paint from scratches, chips, and UV damage.`
  String get protectionFilmDesc {
    return Intl.message(
      'Car protection film shields your car’s paint from scratches, chips, and UV damage.',
      name: 'protectionFilmDesc',
      desc: '',
      args: [],
    );
  }

  /// `Establishing Charging`
  String get chargingTitle {
    return Intl.message(
      'Establishing Charging',
      name: 'chargingTitle',
      desc: '',
      args: [],
    );
  }

  /// `Establishing charging ensures safe and convenient power access for electric vehicles.`
  String get chargingDesc {
    return Intl.message(
      'Establishing charging ensures safe and convenient power access for electric vehicles.',
      name: 'chargingDesc',
      desc: '',
      args: [],
    );
  }

  /// `Car Parts`
  String get carPartsTitle {
    return Intl.message('Car Parts', name: 'carPartsTitle', desc: '', args: []);
  }

  /// `Car parts are essential components that keep your vehicle functioning properly.`
  String get carPartsDesc {
    return Intl.message(
      'Car parts are essential components that keep your vehicle functioning properly.',
      name: 'carPartsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Solar Energy`
  String get solarEnergyTitle {
    return Intl.message(
      'Solar Energy',
      name: 'solarEnergyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Solar energy powers devices and systems using clean, renewable sunlight.`
  String get solarEnergyDesc {
    return Intl.message(
      'Solar energy powers devices and systems using clean, renewable sunlight.',
      name: 'solarEnergyDesc',
      desc: '',
      args: [],
    );
  }

  /// `Car Accessories`
  String get carAccessoriesTitle {
    return Intl.message(
      'Car Accessories',
      name: 'carAccessoriesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Car accessories enhance your vehicle’s comfort, style, and functionality.`
  String get carAccessoriesDesc {
    return Intl.message(
      'Car accessories enhance your vehicle’s comfort, style, and functionality.',
      name: 'carAccessoriesDesc',
      desc: '',
      args: [],
    );
  }

  /// `Car Insurance Application`
  String get insuranceAppTitle {
    return Intl.message(
      'Car Insurance Application',
      name: 'insuranceAppTitle',
      desc: '',
      args: [],
    );
  }

  /// `Car insurance application lets you easily apply for coverage and manage your policy.`
  String get insuranceAppDesc {
    return Intl.message(
      'Car insurance application lets you easily apply for coverage and manage your policy.',
      name: 'insuranceAppDesc',
      desc: '',
      args: [],
    );
  }

  /// `Car Installment Request`
  String get installmentTitle {
    return Intl.message(
      'Car Installment Request',
      name: 'installmentTitle',
      desc: '',
      args: [],
    );
  }

  /// `Car installment request allows you to buy a vehicle through monthly payments.`
  String get installmentDesc {
    return Intl.message(
      'Car installment request allows you to buy a vehicle through monthly payments.',
      name: 'installmentDesc',
      desc: '',
      args: [],
    );
  }

  /// `Car Wash`
  String get carWashTitle {
    return Intl.message('Car Wash', name: 'carWashTitle', desc: '', args: []);
  }

  /// `Car wash cleans and refreshes your vehicle’s exterior and interior.`
  String get carWashDesc {
    return Intl.message(
      'Car wash cleans and refreshes your vehicle’s exterior and interior.',
      name: 'carWashDesc',
      desc: '',
      args: [],
    );
  }

  /// `Establishing Charging`
  String get establishingChargingTitle {
    return Intl.message(
      'Establishing Charging',
      name: 'establishingChargingTitle',
      desc: '',
      args: [],
    );
  }

  /// `Establishing charging ensures safe and convenient power access for electric vehicles.`
  String get establishingChargingDesc {
    return Intl.message(
      'Establishing charging ensures safe and convenient power access for electric vehicles.',
      name: 'establishingChargingDesc',
      desc: '',
      args: [],
    );
  }

  /// `Car protection film`
  String get Carprotectionfilm {
    return Intl.message(
      'Car protection film',
      name: 'Carprotectionfilm',
      desc: '',
      args: [],
    );
  }

  /// `Car protection film shields your car’s paint from scratches, chips, and UV damage.`
  String get CarprotectionfilmDesc {
    return Intl.message(
      'Car protection film shields your car’s paint from scratches, chips, and UV damage.',
      name: 'CarprotectionfilmDesc',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Add Your `
  String get AddYour {
    return Intl.message('Add Your ', name: 'AddYour', desc: '', args: []);
  }

  /// `New Car Details`
  String get NewCarDetails {
    return Intl.message(
      'New Car Details',
      name: 'NewCarDetails',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get Title {
    return Intl.message('Title', name: 'Title', desc: '', args: []);
  }

  /// `Description`
  String get Description {
    return Intl.message('Description', name: 'Description', desc: '', args: []);
  }

  /// `Price`
  String get Price {
    return Intl.message('Price', name: 'Price', desc: '', args: []);
  }

  /// `Submit`
  String get Submit {
    return Intl.message('Submit', name: 'Submit', desc: '', args: []);
  }

  /// `Car Insurance Application`
  String get carInsuranceAppTitle {
    return Intl.message(
      'Car Insurance Application',
      name: 'carInsuranceAppTitle',
      desc: '',
      args: [],
    );
  }

  /// `Car insurance application lets you easily apply for coverage and manage your policy.`
  String get carInsuranceAppDesc {
    return Intl.message(
      'Car insurance application lets you easily apply for coverage and manage your policy.',
      name: 'carInsuranceAppDesc',
      desc: '',
      args: [],
    );
  }

  /// `Car Installment Request`
  String get carInstallmentTitle {
    return Intl.message(
      'Car Installment Request',
      name: 'carInstallmentTitle',
      desc: '',
      args: [],
    );
  }

  /// `Car installment request allows you to buy a vehicle through monthly payments.`
  String get carInstallmentDesc {
    return Intl.message(
      'Car installment request allows you to buy a vehicle through monthly payments.',
      name: 'carInstallmentDesc',
      desc: '',
      args: [],
    );
  }

  /// `Car Model`
  String get carModel {
    return Intl.message('Car Model', name: 'carModel', desc: '', args: []);
  }

  /// `Add Your Car Images`
  String get AddYourCarImages {
    return Intl.message(
      'Add Your Car Images',
      name: 'AddYourCarImages',
      desc: '',
      args: [],
    );
  }

  /// `Add Your Main Car Image`
  String get AddYourMainCarImage {
    return Intl.message(
      'Add Your Main Car Image',
      name: 'AddYourMainCarImage',
      desc: '',
      args: [],
    );
  }

  /// `your car Description`
  String get yourcarDescription {
    return Intl.message(
      'your car Description',
      name: 'yourcarDescription',
      desc: '',
      args: [],
    );
  }

  /// `max. 8 Photos`
  String get maxPhotos {
    return Intl.message('max. 8 Photos', name: 'maxPhotos', desc: '', args: []);
  }

  /// `Used Since`
  String get usedSince {
    return Intl.message('Used Since', name: 'usedSince', desc: '', args: []);
  }

  /// `Body Style`
  String get BodyStyle {
    return Intl.message('Body Style', name: 'BodyStyle', desc: '', args: []);
  }

  /// `Charge Type`
  String get ChargeType {
    return Intl.message('Charge Type', name: 'ChargeType', desc: '', args: []);
  }

  /// `Sell your Car`
  String get sellYourCarTitle {
    return Intl.message(
      'Sell your Car',
      name: 'sellYourCarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Easily list your car for sale and reach trusted buyers near you.`
  String get sellYourCarDesc {
    return Intl.message(
      'Easily list your car for sale and reach trusted buyers near you.',
      name: 'sellYourCarDesc',
      desc: '',
      args: [],
    );
  }

  /// `Battery Capacity`
  String get BatteryCapacity {
    return Intl.message(
      'Battery Capacity',
      name: 'BatteryCapacity',
      desc: '',
      args: [],
    );
  }

  /// `Engine Power`
  String get EnginePower {
    return Intl.message(
      'Engine Power',
      name: 'EnginePower',
      desc: '',
      args: [],
    );
  }

  /// `Add Your Service`
  String get addYourServiceTitle {
    return Intl.message(
      'Add Your Service',
      name: 'addYourServiceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Offer your auto-related services to thousands of local car owners.`
  String get addYourServiceDesc {
    return Intl.message(
      'Offer your auto-related services to thousands of local car owners.',
      name: 'addYourServiceDesc',
      desc: '',
      args: [],
    );
  }

  /// `your details car title`
  String get yourdetailscartitle {
    return Intl.message(
      'your details car title',
      name: 'yourdetailscartitle',
      desc: '',
      args: [],
    );
  }

  /// `Used Car`
  String get UsedCar {
    return Intl.message('Used Car', name: 'UsedCar', desc: '', args: []);
  }

  /// `Your car added in review successfully`
  String get yourCarAddedInReviewSuccessfully {
    return Intl.message(
      'Your car added in review successfully',
      name: 'yourCarAddedInReviewSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get Ok {
    return Intl.message('Ok', name: 'Ok', desc: '', args: []);
  }

  /// `Done`
  String get Done {
    return Intl.message('Done', name: 'Done', desc: '', args: []);
  }

  /// `Price Not Available`
  String get PriceNotAvailable {
    return Intl.message(
      'Price Not Available',
      name: 'PriceNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Added to Favorites`
  String get AddedToFavorites {
    return Intl.message(
      'Added to Favorites',
      name: 'AddedToFavorites',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get User {
    return Intl.message('User', name: 'User', desc: '', args: []);
  }

  /// `Delete Your Account`
  String get DeleteYourAccount {
    return Intl.message(
      'Delete Your Account',
      name: 'DeleteYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get ResetPassword {
    return Intl.message(
      'Reset Password',
      name: 'ResetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Old Password`
  String get OldPassword {
    return Intl.message(
      'Old Password',
      name: 'OldPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get NewPassword {
    return Intl.message(
      'New Password',
      name: 'NewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a new password`
  String get Pleaseenteranewpassword {
    return Intl.message(
      'Please enter a new password',
      name: 'Pleaseenteranewpassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password`
  String get ConfirmNewPassword {
    return Intl.message(
      'Confirm New Password',
      name: 'ConfirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your new password`
  String get Pleaseconfirmyournewpassword {
    return Intl.message(
      'Please confirm your new password',
      name: 'Pleaseconfirmyournewpassword',
      desc: '',
      args: [],
    );
  }

  /// `Passwords don't match`
  String get Passwordsdonotmatch {
    return Intl.message(
      'Passwords don\'t match',
      name: 'Passwordsdonotmatch',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your old password`
  String get Pleaseenteryouroldpassword {
    return Intl.message(
      'Please enter your old password',
      name: 'Pleaseenteryouroldpassword',
      desc: '',
      args: [],
    );
  }

  /// `Attention`
  String get attention {
    return Intl.message('Attention', name: 'attention', desc: '', args: []);
  }

  /// `Password changed successfully`
  String get passwordChangedSuccessfully {
    return Intl.message(
      'Password changed successfully',
      name: 'passwordChangedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get Success {
    return Intl.message('Success', name: 'Success', desc: '', args: []);
  }

  /// `Continue`
  String get continueText {
    return Intl.message('Continue', name: 'continueText', desc: '', args: []);
  }

  /// `Start`
  String get Start {
    return Intl.message('Start', name: 'Start', desc: '', args: []);
  }

  /// `Soon`
  String get Soon {
    return Intl.message('Soon', name: 'Soon', desc: '', args: []);
  }

  /// `Choose\n`
  String get Choose {
    return Intl.message('Choose\n', name: 'Choose', desc: '', args: []);
  }

  /// `Country`
  String get Country {
    return Intl.message('Country', name: 'Country', desc: '', args: []);
  }

  /// `Profile updated successfully`
  String get profileUpdatedSuccessfully {
    return Intl.message(
      'Profile updated successfully',
      name: 'profileUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
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
