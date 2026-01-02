import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goverment_online/features/grievance_screen/controller/grievance_screen_controller.dart';
import '../../utils/widgets/bottom_navigaton_bar/controller/bottom_navigation_controller.dart';
import '../grievance_screen/view/grievance_Screen.dart';
import '../home/view/home_screen.dart';
import '../notice_screen/view/notice_screen.dart';
import '../profile_screen/view/profile_screen.dart';
import '../ticket_screen/view/ticket_screen.dart';

class MainScreen extends StatelessWidget {
  final NavigationController navController = Get.put(NavigationController());

  MainScreen({Key? key}) : super(key: key);

  final List<Widget> pages = [
    HomeScreen(),
    GrievanceScreen(),
    NoticeScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[navController.currentIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: navController.currentIndex.value,
          onTap: (index) => navController.changePage(index),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.confirmation_number),
              label: 'Grievance',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.article),
              label: 'Notices',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
