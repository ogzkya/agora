part of 'gift_bloc.dart';



abstract class GiftEvent {}

class RetrieveLostDataEvent extends GiftEvent {}

class ChooseImageFromGalleryEvent extends GiftEvent {
  ChooseImageFromGalleryEvent();
}

class CaptureImageByCameraEvent extends GiftEvent {
  CaptureImageByCameraEvent();
}
class giftscreen extends GiftEvent {
  giftscreen();
}
class ValidateFieldsEvent extends GiftEvent {
  GlobalKey<FormState> key;
  bool acceptEula;

  ValidateFieldsEvent(this.key, {required this.acceptEula});
}

class ToggleEulaCheckboxEvent extends GiftEvent {
  bool eulaAccepted;

  ToggleEulaCheckboxEvent({required this.eulaAccepted});
}


