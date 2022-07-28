import 'package:get/get.dart';

class GeneralPloc extends GetxController {
  // ZoomDrawerController zoomDrawerController = ZoomDrawerController();
  // // GetStorage box;
  // List<MenuItem> mainMenu = [];
  // Box loginHiveBox;

  void onInit() async {
    // zoomDrawerController = ZoomDrawerController();
    // mainMenu = [
    //   MenuItem("DC Site", Icons.payment, 0,
    //       () => onMenuSelected(GetRouteOf.dcSiteRoute)),
    //   MenuItem("Room", Icons.card_giftcard, 1,
    //       () => onMenuSelected(GetRouteOf.dcRoomRoute)),
    //   MenuItem("Rack", Icons.notifications, 2,
    //       () => onMenuSelected(GetRouteOf.dcRackRoute)),
    //   MenuItem("Hardware", Icons.help, 3,
    //       () => onMenuSelected(GetRouteOf.dcHwRoute)),
    // ];
    super.onInit();
    // box = GetStorage();
    // Hive.init('../db/hive/');
    // loginHiveBox = await Hive.openBox('login');
  }

  // void onMenuSelected(String route) {
  //   zoomDrawerController.close();
  //   Get.toNamed(route);
  // }
}
