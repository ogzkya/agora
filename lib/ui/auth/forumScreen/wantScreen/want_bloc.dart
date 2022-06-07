import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

part 'want_event.dart';

part 'want_state.dart';

class GiftBloc extends Bloc<GiftEvent, GiftState> {
  GiftBloc() : super(GiftInitial()) {
    ImagePicker _imagePicker = ImagePicker();

    on<RetrieveLostDataEvent>((event, emit) async {
      final LostDataResponse? response = await _imagePicker.retrieveLostData();
      if (response != null && response.file != null) {
        emit(PictureSelectedState(imageFile: File(response.file!.path)));
      }
    });

    on<ChooseImageFromGalleryEvent>((event, emit) async {
      XFile? xImage = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (xImage != null) {
        emit(PictureSelectedState(imageFile: File(xImage.path)));
      }
    });

    on<CaptureImageByCameraEvent>((event, emit) async {
      XFile? xImage = await _imagePicker.pickImage(source: ImageSource.camera);
      if (xImage != null) {
        emit(PictureSelectedState(imageFile: File(xImage.path)));
      }
    });

    on<ValidateFieldsEvent>((event, emit) async {
      if (event.key.currentState?.validate() ?? false) {
        if (event.acceptEula) {
          event.key.currentState!.save();
          emit(ValidFields());
        } else {
          emit(GiftFailureState(
              errorMessage: 'Lütfen kullanım şartlarımızı kabul edin.'));
        }
      } else {
        emit(GiftFailureState(errorMessage: 'Lütfen gerekli alanları doldurun.'));
      }
    });

    on<ToggleEulaCheckboxEvent>(
            (event, emit) => emit(EulaToggleState(event.eulaAccepted)));
  }
}
