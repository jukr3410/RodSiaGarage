import 'package:flutter/material.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';
import 'package:rodsiagarage/global_widgets/hexTocolor.dart';

//api base url
//dev localhost api
final baseUrlConstant = "http://localhost:3000/api";

// production api
//final baseUrlConstant = '';
// router path
const LOGIN_ROUTE = "/login";
const ADD_NUMBER_ROUTE = "/add_number";
const OTP_ROUTE = "/otp";
const REGISTER_ROUTE = "/register";
const EDIT_GARAGE_ROUTE = "/edit_garage";
const SERVICE_LIST_ROUTE = "/service_list";
const ADD_SERVICE_ROUTE = "/add_service";
const EDIT_SERVICE_ROUTE = "/edit_service";
const HISTORY_ROUTE = "/history";
const HISTORY_INFO_ROUTE = "/history_info";
const MAIN_ROUTE = "/app";
const TRACKING_REQUEST_ROUTE = "/tracking";
const HOMEPAGE_ROUTE = "/homepage";
const PROFILE_ROUTE = "/profile";

// font size
const fontSizeLarge = 20.0;
const fontSizeSemiLarge = 18.0;
const fontSizeMedium = 16.0;
const fontSizeLow = 14.0;

// color that use in app
const textColorBlack = Color(0xff38454C);
const codeColorBlack = "#38454C";
const codeColorGray = '#C4C4C4';
const codeColorRed = '#DA5B49';
const textColorWhite = Colors.white;
const textColorRed = Color(0xffDA5B49);

const primaryColor = Color(0xffFECE2F);
const colorGray = Color(0xffC4C4C4);
const colorGreen = Color(0x2ECC71);
const bgColor = Color(0xffF2F4F6);
const bgColorRed = Color(0xffDA5B49);
const bgCodeColor = '#F2F4F6';
const primaryCodeColor = '#FECE2F';

const iconColorBlack = Color(0xff38454C);
const iconColorWhite = Colors.white;
const iconColorRed = Color(0xffDA5B49);

const cardColor = Colors.white;

// color status
const redStatus = Colors.red;
const greenStatus = Colors.green;

// Style
const boxShadow = BoxShadow(
  color: Color.fromRGBO(0, 0, 0, 0.25),
  blurRadius: 6,
  offset: Offset(0, 2),
);
const borderRadiusHight = BorderRadius.all(Radius.circular(25));
const borderRadiusMedium = BorderRadius.all(Radius.circular(10));
const borderRadiusLow = BorderRadius.all(Radius.circular(5));

// borderRadiusOnlyBottom
const borderRadiusLowOnlyBottom = BorderRadius.only(
    bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5));
const borderRadiusMediumOnlyBottom = BorderRadius.only(
    bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10));
const borderRadiusHightOnlyBottom = BorderRadius.only(
    bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25));

// borderRadiusOnlyTop
const borderRadiusLowOnlyTop = BorderRadius.only(
    topLeft: Radius.circular(5), topRight: Radius.circular(5));
const borderRadiusMediumOnlyTop = BorderRadius.only(
    topLeft: Radius.circular(10), topRight: Radius.circular(10));
const borderRadiusHightOnlyTop = BorderRadius.only(
    topLeft: Radius.circular(25), topRight: Radius.circular(25));

// card stlye
const cardWidthMedium = 320.0;
const cardWidthLow = 290.0;
const cardWidthLarge = 350.0;

// button Stlye
const buttonWidthSmall = 100.0;
const buttonHeightSmall = 40.0;

const buttonHeightMedium = 50.0;
const buttonWidthMedium = 250.0;

const buttonHeightLarge = 50.0;
const buttonWidthLarge = 350.0;

ButtonStyle flatButtonStyle(Color bgColor, Color textColor) {
  return TextButton.styleFrom(
    backgroundColor: bgColor,
    primary: textColor,
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: borderRadiusMedium,
    ),
  );
}

// margin, padding
const defualtPaddingMedium = 20.0;
const defualtPaddingHight = 30.0;
const defualtPaddingLow = 10.0;

// message, wording
const mError = "เกิดข้อผิดพลาด, โปรลองอีกครั้ง";
const mNoGarages = "ไม่พบร้าน";
const mNoMoreGarages = "no more garages";
const mLoading = "กำลังโหลด";
const mNotFound = "ไม่พบ!";
const mServiceAdded = "เพิ่มบริการเรียบร้อย";

// src string for set widget
String tImageAsset(String imageName) {
  return 'assets/images/icon-' + imageName + '.png';
}

const tUpdateTrackingStatus = 'คุณต้องการอัพเดตใช้ไหม?';
const tOKThai = 'ตกลง';
const tInSeriveThai = 'กำลังให้บริการ';
const tBackToHomePage = 'กลับสู่หน้าหลัก';
const tServiceThai = 'บริการ';
const tFinishProvideService = 'การให้บริการเสร็จสิ้นแล้ว!';
const tMoreInfoThai = 'ดูรายละเอียดเพิ่มเติม';
const tConfirmSuccessThai = 'ยืนยันเสร็จสิ้นการบริการ';
const tServiceOfGarageThai = 'บริการของร้าน';
const tCallbackForMoreInfo = 'ติดต่อกลับเพื่อสอบถามรายละเอียด';
const tYouWantCancleThai = 'ท่านต้องการยกเลิกหรือไม่';
const tWaitForGarageThai = 'กำลังรออู่ติดต่อกลับเพื่อสอบถามรายละเอียดเพิ่มเติม';
const tAlertRequestService = 'มีคนต้องการความช่วยเหลือ!';
const tRequestServiceThai = 'รับให้บริการเลย';
const tDeclineThai = 'ปฏิเสธิ';
const tPhone = 'โทรศัพท์';

const tAddressThai = 'ที่อยู่: ';
const tUpdateThai = 'อัพเดต';
const tCancleThai = 'ยกเลิก';
const tAcceptThai = 'ยอมรับ';
const tSupportThai = 'ติดต่อซัพพอร์ท';
const tYesThai = 'ใช้';
const tMessage = "messages";
const tEmail = "E-mail";
const tPassword = "Password";
const tNameGarageThai = "ชื่ออู๋:";
const tNameUserThai = "ชื่อลูกค้า:";
const tLocationThai = 'ตำแหน่ง:';
const tProblemThai = 'ปัญหา:';
const tEstimateDuration = 'ระยะเวลาประมาณ:';
const tServiceGarage = 'บริการของร้าน';
const tAddService = 'เพิ่มบริการ';
const tEditService = 'แก้ไขบริการ';
const tServiceName = 'ชื่อบริการ';
const tServiceDesc = 'คำอธิบาย';
const tServiceType = 'ประเภทบริการ';
const tHistory = 'ประวัติ';
const tSupportCenter = 'ศูนย์ช่วยเหลือ';

//Tracking Status
const trackingStatus = [
  'กำลังเตรียมของ',
  'กำลังเดินทาง',
  'ถึงที่หมายแล้ว',
  'งานเสร็จแล้ว'
];

const menusSetting = [
  'โปรไฟล์',
  'ประวัติการใช้งาน',
  'การตั้งค่า',
  'ออกจากระบบ'
];

Garage gargeMockup = Garage(
    id: '1',
    name: 'Jone Cena',
    phone: '0359887456',
    email: "email@mail.com",
    password: '1234',
    validatePhone: true);
