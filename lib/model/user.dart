import 'dart:io';

class User {
  String email;

  String firstName;

  String lastName;

  String userID;

  String profilePictureURL;

  String appIdentifier;

  String donor;

  String donorphone;

  User(
      {this.email = '',
      this.firstName = '',
      this.lastName = '',
      this.userID = '',
      this.donor ='',
        this.donorphone ='',
      this.profilePictureURL = ''})
      : appIdentifier = 'Flutter Giriş Ekranı ${Platform.operatingSystem}';

  String fullName() => '$firstName $lastName';

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
        email: parsedJson['email'] ?? '',
        firstName: parsedJson['firstName'] ?? '',
        lastName: parsedJson['lastName'] ?? '',
        userID: parsedJson['id'] ?? parsedJson['userID'] ?? '',
        profilePictureURL: parsedJson['profilePictureURL'] ?? '',
        donor: parsedJson['gift'] ??'',
        donorphone: parsedJson['donorphone']??'');
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'id': userID,
      'profilePictureURL': profilePictureURL,
      'appIdentifier': appIdentifier,
      'donorname' : donor,
      'donorphone' : donorphone
    };
  }
}

class giftuser{

  String email;

  String firstName;

  String lastName;

  String donationtype;

  String donationcontent;

  String userID;

  String PictureURL;

  String appIdentifier;

  String city;

  String donorphone;

  giftuser({
    this.email = '',
    this.firstName = '',
    this.lastName = '',
    this.donationtype ='',
    this.donationcontent ='',
    this.userID = '',
    this.city='',

    this.donorphone ='',
    this.PictureURL = ''})
    : appIdentifier = 'kutsal bağışçı ${Platform.operatingSystem}';
     String fullName() => '$firstName $lastName';

     factory giftuser.fromJson(Map<String, dynamic> parsedJson) {
    return giftuser(
        email: parsedJson['email'] ?? '',
        firstName: parsedJson['firstName'] ?? '',
        lastName: parsedJson['lastName'] ?? '',
        donationtype: parsedJson['donationtype'] ?? '',
        donationcontent: parsedJson['donationcontent'] ?? '',
        userID: parsedJson['id'] ?? parsedJson['userID'] ?? '',
        PictureURL: parsedJson['PictureURL'] ?? '',
        city: parsedJson['city']??'',
        donorphone: parsedJson['donorphone']??'');
  }
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'id': userID,
      'PictureURL': PictureURL,
      'appIdentifier': appIdentifier,
      'donationtype' : donationtype,
      'donationcontent' : donationcontent,
      'donorphone' : donorphone,
      'city' : city
    };
  }


}
