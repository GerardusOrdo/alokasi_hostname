import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/bindings/dc_brand_bindings.dart';
import 'core/bindings/dc_containment_bindings.dart';
import 'core/bindings/dc_hardware_bindings.dart';
import 'core/bindings/dc_hw_model_bindings.dart';
import 'core/bindings/dc_hw_type_bindings.dart';
import 'core/bindings/dc_mounted_form_bindings.dart';
import 'core/bindings/dc_owner_bindings.dart';
import 'core/bindings/dc_rack_bindings.dart';
import 'core/bindings/dc_room_bindings.dart';
import 'core/bindings/dc_room_type_bindings.dart';
import 'core/bindings/dc_site_bindings.dart';
import 'core/bindings/email_schedule_bindings.dart';
import 'core/bindings/general_binding.dart';
import 'core/bindings/login_bindings.dart';
import 'core/bindings/owner_bindings.dart';
import 'core/bindings/server_bindings.dart';
import 'core/helper/helper.dart';
import 'features/dc_brand/presentation/pages/dc_brand_mainpage.dart';
import 'features/dc_containment/presentation/pages/dc_containment_mainpage.dart';
import 'features/dc_hardware/presentation/pages/dc_hardware_mainpage.dart';
import 'features/dc_hw_model/presentation/pages/dc_hw_model_mainpage.dart';
import 'features/dc_hw_type/presentation/pages/dc_hw_type_mainpage.dart';
import 'features/dc_mounted_form/presentation/pages/dc_mounted_form_mainpage.dart';
import 'features/dc_rack/presentation/pages/dc_rack_mainpage.dart';
import 'features/dc_room/presentation/pages/dc_room_mainpage.dart';
import 'features/dc_room_type/presentation/pages/dc_room_type_mainpage.dart';
import 'features/dc_site/presentation/pages/dc_site_mainpage.dart';
import 'features/email_schedule/presentation/pages/email_schedule_mainpage.dart';
import 'features/login/presentation/pages/login_page.dart';
import 'features/main/pages/homepage.dart';
import 'features/owner/presentation/pages/owner_mainpage.dart';
import 'features/server/presentation/pages/server_mainpage.dart';

void main() {
  /// STEP 1. Create catcher configuration.
  /// Debug configuration with dialog report mode and console handler.
  /// It will show dialog and once user accepts it, error will be shown in console.
  // CatcherOptions debugOptions =
  //     CatcherOptions(DialogReportMode(), [ConsoleHandler()]);

  /// Release configuration. Same as above, but once user accepts dialog,
  /// user will be prompted to send email with crash to support.
  // CatcherOptions releaseOptions = CatcherOptions(DialogReportMode(), [
  //   EmailManualHandler(["gerardus.ordo@gmail.com"])
  // ]);

  /// STEP 2. Pass your root widget (MyApp) along with Catcher configuration:
  // Catcher(MyApp(), debugConfig: debugOptions, releaseConfig: releaseOptions);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final box = Get.put<GeneralPloc>(GeneralPloc()).loginHiveBox;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      /// STEP 3. Add navigator key from Catcher. It will be used to navigate user to report page or to show dialog.
      // navigatorKey: Catcher.navigatorKey,
      title: 'Alokasi Hostname',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: GetRouteOf.loginRoute,
      initialBinding: GeneralBinding(),
      getPages: [
        GetPage(
          name: GetRouteOf.loginRoute,
          page: () {
            return LoginPage();
          },
          bindings: [LoginBindings(), GeneralBinding()],
        ),
        GetPage(
            name: GetRouteOf.homepageRoute,
            page: () {
              // if (!box.isBlank && !box.get('login')) {
              // return LoginPage();
              // } else
              return HomePage();
            },
            bindings: [
              GeneralBinding(),
            ]),
        // GetPage(
        //   name: GetRouteOf.loginRoute,
        //   page: () => LoginPage(),
        // ),
        GetPage(
          name: GetRouteOf.ownerRoute,
          page: () => OwnerMainPage(),
          binding: OwnerBindings(),
        ),
        GetPage(
          name: GetRouteOf.serverRoute,
          page: () => ServerMainPage(),
          bindings: [
            ServerBindings(),
            OwnerBindings(),
          ],
        ),
        GetPage(
          name: GetRouteOf.emailScheduleRoute,
          page: () => EmailScheduleMainPage(),
          bindings: [
            EmailScheduleBindings(),
            ServerBindings(),
            OwnerBindings(),
          ],
        ),
        // GetPage(
        //   name: GetRouteOf.ownerRouteInput,
        //   page: () => DcOwnerMainPage(),
        //   // binding: DcOwnerBindings(),
        // ),
        GetPage(
          name: GetRouteOf.dcSiteRoute,
          page: () => DcSiteMainPage(),
          bindings: [
            DcSiteBindings(),
            DcOwnerBindings(),
          ],
        ),
        GetPage(
          name: GetRouteOf.dcRoomTypeRoute,
          page: () => DcRoomTypeMainPage(),
          bindings: [
            DcRoomTypeBindings(),
          ],
        ),
        GetPage(
          name: GetRouteOf.dcRoomRoute,
          page: () => DcRoomMainPage(),
          bindings: [
            DcOwnerBindings(),
            DcSiteBindings(),
            DcRoomTypeBindings(),
            DcRoomBindings(),
          ],
        ),
        GetPage(
          name: GetRouteOf.dcContainmentRoute,
          page: () => DcContainmentMainPage(),
          bindings: [
            DcOwnerBindings(),
            DcRoomBindings(),
            DcContainmentBindings(),
          ],
        ),
        GetPage(
          name: GetRouteOf.dcRackRoute,
          page: () => DcRackMainPage(),
          bindings: [
            DcOwnerBindings(),
            DcSiteBindings(),
            DcRoomBindings(),
            DcRoomTypeBindings(),
            DcContainmentBindings(),
            DcRackBindings(),
          ],
        ),
        GetPage(
          name: GetRouteOf.dcHwTypeRoute,
          page: () => DcHwTypeMainPage(),
          bindings: [
            DcHwTypeBindings(),
          ],
        ),
        GetPage(
          name: GetRouteOf.dcMountedFormRoute,
          page: () => DcMountedFormMainPage(),
          bindings: [
            DcMountedFormBindings(),
          ],
        ),
        GetPage(
          name: GetRouteOf.dcBrandRoute,
          page: () => DcBrandMainPage(),
          bindings: [
            DcBrandBindings(),
          ],
        ),
        GetPage(
          name: GetRouteOf.dcHwModelRoute,
          page: () => DcHwModelMainPage(),
          bindings: [
            DcHwModelBindings(),
          ],
        ),
        GetPage(
          name: GetRouteOf.dcHwRoute,
          page: () => DcHardwareMainPage(),
          bindings: [
            DcOwnerBindings(),
            DcSiteBindings(),
            DcRoomBindings(),
            DcRoomTypeBindings(),
            DcContainmentBindings(),
            DcRackBindings(),
            DcBrandBindings(),
            DcHwModelBindings(),
            DcHwTypeBindings(),
            DcMountedFormBindings(),
            DcHardwareBindings(),
          ],
        ),
        // GetPage(
        //   name: GetRouteOf.dcHwRoute,
        //   page: () => DcHardwareMainPage(),
        //   bindings: [
        //     DcOwnerBindings(),
        //     DcRackBindings(),
        //     DcBrandBindings(),
        //     DcHwModelBindings(),
        //     DcHardwareBindings(),
        //   ],
        // ),
        // GetPage(
        //   name: GetRouteOf.zoomCoba,
        //   page: () => ZoomCoba(),
        //   bindings: [
        //     ZoomBindings(),
        //   ],
        // ),
        // GetPage(
        //   name: GetRouteOf.visualDc,
        //   page: () => VisualDcMain(),
        //   bindings: [],
        // ),
        // GetPage(
        //   name: GetRouteOf.visualDcRack,
        //   page: () => VisualDcRack(),
        //   bindings: [
        //     VisualDcBindings(),
        //   ],
        // ),
        // GetPage(
        //   name: GetRouteOf.visualDcHardware,
        //   page: () => DcHardwareInputPageTab(),
        //   bindings: [
        //     VisualDcBindings(),
        //     DcHardwareBindings(),
        //   ],
        // ),
      ],
    );
  }
}
