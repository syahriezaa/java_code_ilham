import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:magang/config/routes/app_routes.dart';
import 'package:magang/config/themes/colors.dart';
import 'package:magang/modules/features/profile/repositories/profile_repo.dart';
import 'package:magang/modules/features/profile/view/components/email_bottom_sheet.dart';
import 'package:magang/modules/features/profile/view/components/image_picker_dialog.dart';
import 'package:magang/modules/features/profile/view/components/name_bottom_sheet.dart';
import 'package:magang/modules/features/profile/view/components/phone_bottom_sheet.dart';
import 'package:magang/modules/features/profile/view/components/pin_dialog.dart';
import 'package:magang/modules/models/auth_model.dart';
import 'package:magang/shared/style/shapes.dart';
import 'package:magang/utils/extensions/date_extension.dart';
import 'package:magang/utils/services/local_db_service/local_db_service.dart';


class ProfileController extends GetxController{
  static ProfileController get to => Get.find();

///variables
///
  ///User data
Rx<User> user = Rx<User>(User.dummy);

  ///Device info
  Rx<String> deviceInfo = RxString('');

  @override
  void onInit(){
    super.onInit();
    ///Load user data
    LocalDbService.GetUser().then((value) {
      user.value = value!;
      loadData();
    });
    DeviceInfoPlugin().androidInfo.then((value) {
      deviceInfo.value = '${value.manufacturer} ${value.model}';
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

/// Utilities
  ///Logout user
  Future<void> logout() async {
    await LocalDbService.clearToken();
    await LocalDbService.clearUser();
    Get.offAllNamed(AppRoutes.LoginView);
  }

  Future<void> updateUser(
      {String? nama,
        DateTime? tgl_lahir,
        String? telepon,
        String? email,
        String? pin}) async {
    Map<String, String> data = {};
    try {
      print("update");
      if (nama != null) data['nama'] = nama;
      if (tgl_lahir != null) data['tgl_lahir'] = tgl_lahir.toDateString();
      if (telepon != null) data['telepon'] = telepon;
      if (email != null) data['email'] = email;
      if (pin != null) data['pin'] = pin;

      UserRes userRes = await ProfileRepo.update(data);

      if (userRes.status_code == 200) {
        user.value = User.dummy;
        user.value = userRes.data!;
        await LocalDbService.setUser(userRes.data!);
      }
      print(userRes.status_code);
    }catch(e,stack){
      print(e);
      print(stack);
    }
  }

  void openUpdatePhotoDialog() async {
    /// Buka dialog pilih sumber gambar
    ImageSource? imageSource = await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const ImagePickerDialog(),
    );

    /// ambil gambar sesuai sumber
    if (imageSource == null) return;
    var image = await ImagePicker().pickImage(
      source: imageSource,
      maxWidth: 300,
      maxHeight: 300,
      imageQuality: 75,
    );
    try {
      /// ambil dan crop
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
      print("suer value: "+user.value.toString());
      /// Update data user
      if (userRes.status_code == 200) {
        user.value = User.dummy;
        user.value = userRes.data!;

        await LocalDbService.setUser(userRes.data!);
      }
    }catch(e,stack){
      print(stack);
    }
  }
  ///Upload ktp
  void openVerifyIDDialog() async {
    /// Buka dialog input sumber gambar
    ImageSource? imageSource = await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const ImagePickerDialog(),
    );

    /// Jika pilih sumber gambar, buka dialog ambil gambar sesuai sumber
    if (imageSource == null) return;
    var image = await ImagePicker().pickImage(
      source: imageSource,
      maxWidth: 1500,
      maxHeight: 1500,
      imageQuality: 90,
    );

    /// Jika gambar diambil, encode gambar ke base64
    if (image == null) return;
    final base64Image = base64Encode(await image.readAsBytes());

    /// Simpan gambar melalui API
    UserRes userRes = await ProfileRepo.updateKTP(base64Image);

    /// Update data user
    if (userRes.status_code == 200) {
      user.value = User.dummy;
      user.value = userRes.data!;
      await LocalDbService.setUser(userRes.data!);
    }
  }
  /// Update nama dialog
  void openUpdateNameDialog() async {
    String? nama = await Get.bottomSheet(
      NameBottomSheet(nama: user.value.nama),
      backgroundColor: Colors.white,
      shape: CustomShape.topRoundedShape,
      isScrollControlled: true,
    );

    if (nama != null && nama.isNotEmpty) {
      await updateUser(nama: nama);
    }
  }

  /// Update tanggal lahir dialog
  void openUpdateBirthDateDialog() async {
    DateTime? tgl_lahir = await showDatePicker(
      context: Get.context!,
      initialDate: user.value.tgl_lahir ?? DateTime(DateTime.now().year - 21),
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime.now(),
    );

    if (tgl_lahir != null) {
      await updateUser(tgl_lahir: tgl_lahir);
    }
  }

  /// Update phone number dialog
  void openUpdatePhoneDialog() async {
    String? telepon = await Get.bottomSheet(
      PhoneBottomSheet(telepon: user.value.telepon ?? ''),
      backgroundColor: Colors.white,
      shape: CustomShape.topRoundedShape,
      isScrollControlled: true,
    );

    if (telepon != null && telepon.isNotEmpty) {
      await updateUser(telepon: telepon);
    }
  }

  /// Update email dialog
  void openUpdateEmailDialog() async {
    String? email = await Get.bottomSheet(
      EmailBottomSheet(email: user.value.email),
      backgroundColor: Colors.white,
      shape: CustomShape.topRoundedShape,
      isScrollControlled: true,
    );

    if (email != null && email.isNotEmpty) {
      await updateUser(email: email);
    }
  }

  void openUpdatePINDialog() async {
    String? pin = await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const PinDialog(),
    );

    if (pin != null && pin.isNotEmpty) {
      await updateUser(pin: pin);
    }
  }
}