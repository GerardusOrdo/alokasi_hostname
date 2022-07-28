import 'package:get/get.dart';

import '../../features/main/bloc/homepage_ploc.dart';
import '../ploc/general_ploc.dart';

class GeneralBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<GeneralPloc>(GeneralPloc());
    Get.put<HomePagePloc>(HomePagePloc());
    // Get.put<AuthPloc>(AuthPloc());
  }
}
