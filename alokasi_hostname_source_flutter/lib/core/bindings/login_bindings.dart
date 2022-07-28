import 'package:get/get.dart';

import '../../features/login/presentation/bloc/login_ploc.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginPloc>(() => LoginPloc());
  }
}
