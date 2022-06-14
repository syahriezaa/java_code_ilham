import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:magang/config/routes/app_routes.dart';
import 'package:magang/config/themes/colors.dart';
import 'package:magang/modules/features/profile/repositories/profile_repo.dart';
import 'package:magang/modules/features/profile/view/components/image_picker_dialog.dart';
import 'package:magang/modules/models/auth_model.dart';
import 'package:magang/utils/services/local_db_service/local_db_service.dart';


class ProfileController extends GetxController{
  static ProfileController get to => Get.find();

///variables
///
  ///User data
Rx<User> user = Rx<User>(User.dummy);

  ///Device info
  Rx<String> deviceInfo = RxString('');

  void onInit(){
    super.onInit();
    ///Load user data
    LocalDbService.GetUser().then((value) {
      user.value = value!;
      loadData();
    });
  }

///Geter
  ///Load user data
  Future<void> loadData() async {
    ///Fetch data user dari API
    UserRes userRes = await ProfileRepo.get();

    if (userRes.status_code == 200) {
      ///Jika berhasil, simpan data
      user.value = User.dummy;
      user.value = userRes.data!;
      await LocalDbService.setUser(userRes.data!);
    }
  }

/// ///Logout user
  Future<void> logout() async {
    await LocalDbService.clearToken();
    await LocalDbService.clearUser();
    Get.offAllNamed(AppRoutes.LoginView);
  }

  void openUpdatePhotoDialog() async {
    /// Buka dialog pilih sumber gambar
    ImageSource? imageSource = await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const ImagePickerDialog(),
    );

    /// Jika pilih sumber gambar, buka dialog ambil gambar sesuai sumber
    if (imageSource == null) return;
    var image = await ImagePicker().pickImage(
      source: imageSource,
      maxWidth: 300,
      maxHeight: 300,
      imageQuality: 75,
    );

    /// Jika gambar diambil, buka dialog crop gambar
    if (image == null) return;
    final CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [CropAspectRatioPreset.square],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper'.tr,
          toolbarColor: AppColor.blueColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
      ],
    );

    /// Jika gambar dicrop, encode gambar ke base64
    if (croppedFile == null) return;
    final base64Image = base64Encode(await croppedFile.readAsBytes());

    /// Simpan gambar melalui API
    UserRes userRes = await ProfileRepo.updatePhoto(base64Image);

    /// Update data user
    if (userRes.status_code == 200) {
      user.value = User.dummy;
      user.value = userRes.data!;
      await LocalDbService.setUser(userRes.data!);
    }
  }

}