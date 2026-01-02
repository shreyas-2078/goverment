import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:goverment_online/utils/constants/app_images.dart';
import 'package:goverment_online/utils/extension/sized_box_extension.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/themes/app_text_style.dart';
import '../../../utils/widgets/custom_text_fieldform_widget/custom_text_fieldform_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'dart:io';

import '../controller/grievance_screen_controller.dart';

class GrievanceScreen extends StatelessWidget {
  const GrievanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GrievanceScreenController());

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.bgColor,
        leading: const BackButton(color: Colors.black),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.location_on_outlined, color: AppColors.blue, size: 20),
            5.width,
            Text(
              "New Delhi, India",
              style: AppTextStyle.hintStyle.copyWith(
                fontSize: 14,
                color: AppColors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          SvgPicture.asset(AppImages.bellIcon, height: 35, width: 35),
          10.width,
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Report an Issue",
              style: AppTextStyle.hintStyle.copyWith(
                fontSize: 24,
                color: AppColors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            4.height,
            Text(
              "Make your city better 🏙️",
              style: AppTextStyle.hintStyle.copyWith(
                fontSize: 24,
                color: AppColors.blue,
                fontWeight: FontWeight.w600,
              ),
            ),

            20.height,

            Text(
              "Grievance Title",
              style: AppTextStyle.hintStyle.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            6.height,
            CustomTextField(
              hintText: "Enter Title",
              controller: controller.titleController,
            ),

            16.height,

            /// Category
            Text(
              "Select Category",
              style: AppTextStyle.hintStyle.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            6.height,
            GetBuilder<GrievanceScreenController>(
              builder: (ctrl) => DropdownButtonFormField<String>(
                decoration: _dropdownDecoration(),
                value: ctrl.selectedCategory,
                items: const [
                  DropdownMenuItem(value: "Road", child: Text("Road")),
                  DropdownMenuItem(value: "Water", child: Text("Water")),
                  DropdownMenuItem(
                    value: "Electricity",
                    child: Text("Electricity"),
                  ),
                ],
                onChanged: ctrl.updateCategory,
              ),
            ),

            16.height,

            /// Department
            Text(
              "Select Department",
              style: AppTextStyle.hintStyle.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            6.height,
            GetBuilder<GrievanceScreenController>(
              builder: (ctrl) => DropdownButtonFormField<String>(
                decoration: _dropdownDecoration(),
                value: ctrl.selectedDepartment,
                items: const [
                  DropdownMenuItem(value: "PWD", child: Text("PWD")),
                  DropdownMenuItem(
                    value: "Municipal",
                    child: Text("Municipal"),
                  ),
                ],
                onChanged: ctrl.updateDepartment,
              ),
            ),

            16.height,

            Text(
              "Description",
              style: AppTextStyle.hintStyle.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            6.height,
            TextFormField(
              controller: controller.descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Describe the issue insel detail...",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            20.height,

            Text(
              "Evidence (Optional)",
              style: AppTextStyle.hintStyle.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),

            10.height,

            GetBuilder<GrievanceScreenController>(
              builder: (ctrl) => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...ctrl.selectedImages.asMap().entries.map((entry) {
                      int index = entry.key;
                      File image = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: _uploadedImageWidget(image, index, ctrl),
                      );
                    }).toList(),

                    // Add image button
                    _addImageBox(context, ctrl),
                  ],
                ),
              ),
            ),

            30.height,

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: controller.submitGrievance,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Submit Grievance",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.send, color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _uploadedImageWidget(
    File image,
    int index,
    GrievanceScreenController ctrl,
  ) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Image.file(image, fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: -5,
          right: -5,
          child: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 16),
            ),
            onPressed: () => ctrl.removeImage(index),
          ),
        ),
      ],
    );
  }

  Widget _addImageBox(BuildContext context, GrievanceScreenController ctrl) {
    return GestureDetector(
      onTap: () => ctrl.showImageSourceOptions(context),
      child: DottedBorder(
        color: Colors.blue,
        strokeWidth: 1,
        dashPattern: const [6, 4],
        borderType: BorderType.RRect,
        radius: const Radius.circular(15),
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, size: 28, color: Colors.blue),
              SizedBox(height: 4),
              Text(
                'Add',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _dropdownDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
