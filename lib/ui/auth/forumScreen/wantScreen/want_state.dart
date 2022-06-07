part of 'want_bloc.dart';

abstract class GiftState {}

class GiftInitial extends GiftState {}

class PictureSelectedState extends GiftState {
  File? imageFile;

  PictureSelectedState({required this.imageFile});
}

class GiftFailureState extends GiftState {
  String errorMessage;

  GiftFailureState({required this.errorMessage});
}

class ValidFields extends GiftState {}

class EulaToggleState extends GiftState {
  bool eulaAccepted;

  EulaToggleState(this.eulaAccepted);
}
