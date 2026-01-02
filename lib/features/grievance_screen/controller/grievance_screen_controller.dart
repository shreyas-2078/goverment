import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:goverment_online/utils/constants/app_colors.dart';
import 'package:goverment_online/utils/networks/toast_services/toast_services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../utils/themes/app_text_style.dart';

class GrievanceScreenController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final ImagePicker picker = ImagePicker();

  List<File> selectedImages = [];
  String? selectedCategory;
  String? selectedDepartment;

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  Future<void> pickImages() async {
    try {
      final List<XFile> images = await picker.pickMultiImage(imageQuality: 80);

      if (images.isNotEmpty) {
        selectedImages.addAll(images.map((img) => File(img.path)).toList());
        update();
      }
    } catch (e) {
      ToastServices.error('Error', 'Error picking images: $e');
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      final XFile? image = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (image != null) {
        selectedImages.add(File(image.path));
        update();
      }
    } catch (e) {
      ToastServices.error('Error', 'Error taking photo: $e');
    }
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
    update();
  }

  void updateCategory(String? value) {
    selectedCategory = value;
    update();
  }

  void updateDepartment(String? value) {
    selectedDepartment = value;
    update();
  }

  void showImageSourceOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.bgGrayColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.blue),
              title: Text(
                'Gallery',
                style: AppTextStyle.hintStyle.copyWith(color: AppColors.black),
              ),
              onTap: () {
                Get.back();
                pickImages();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.blue),
              title: Text(
                'Camera',
                style: AppTextStyle.hintStyle.copyWith(color: AppColors.black),
              ),
              onTap: () {
                Get.back();
                pickImageFromCamera();
              },
            ),
          ],
        ),
      ),
    );
  }

  void submitGrievance() {
    if (titleController.text.isEmpty) {
      ToastServices.error(
        'Error',
        'Please enter title',
      );
      return;
    }

    ToastServices.success('Success', 'Grievance submitted successfully!');
  }
}
