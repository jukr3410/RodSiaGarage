import 'package:flutter/material.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';
import 'package:rodsiagarage/core/models/geo_location_model.dart';
import 'package:rodsiagarage/core/models/service_type_model.dart';
import 'package:rodsiagarage/core/models/geo_location_model.dart';
import 'package:rodsiagarage/global_widgets/hexTocolor.dart';
import 'package:rodsiagarage/notify_feature/widgets/notifyPage.dart';

//api base url
//dev localhost api
final baseUrlConstant = "http://localhost:3000/api";

// production api
//final baseUrlConstant = 'https://rodsia-api.herokuapp.com/api';
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
const RECAP_DETAIL_REQUREST_ROUTE = '/recap_detail_request';
const EDITPROFILE_ROUTE = '/edit-profile';
const SUPPORT_CENTER_ROUTE = '/support-center-route';
const SETTING_ROUTE = '/setting-route';
const NOTIFY_ROUTE = '/notify-route';

// font size
const fontSizeXXl = 20.0;
const fontSizeXl = 18.0;
const fontSizeL = 16.0;
const fontSizeM = 14.0;
const fontSizeS = 12.0;

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
const mErrorInputPhone = 'โปรดระบุเบอร์โทรศัพท์';

// src string for set widget
String tImageAsset(String imageName) {
  return 'assets/images/icon-' + imageName + '.png';
}

const tUpdateTrackingStatus = 'คุณต้องการอัพเดตใช้ไหม?';
const tOKThai = 'ตกลง';
const tInSeriveThai = 'กำลังให้บริการ';
const tNext = 'ถัดไป';
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
const tRegistration = 'สร้างบัญชี';
const tAddressThai = 'ที่อยู่: ';
const tUpdateThai = 'อัพเดต';
const tCancleThai = 'ยกเลิก';
const tAcceptThai = 'ยอมรับ';
const tSupportThai = 'ติดต่อซัพพอร์ท';
const tYesThai = 'ใช้';
const tMessage = "messages";
const tEmail = "E-mail";
const tDelete = 'ลบ';
const tEmailThai = "อีเมล";
const tEdit = 'แก้ไข';
const tPassword = "Password";
const tConfirmPassword = "ยืนยันรหัสผ่าน ";
const tPasswordThai = "รหัสผ่าน";
const tNameGarageThai = "ชื่ออู๋:";
const tNameUserThai = "ชื่อลูกค้า:";
const tLocationThai = 'ตำแหน่ง:';
const tLocationDesc = 'ตำแหน่งเพิ่มเติม:';
const tProblemThai = 'ปัญหา:';
const tEstimateDuration = 'ระยะเวลาประมาณ:';
const tServiceGarage = 'บริการของร้าน';
const tAddService = 'เพิ่มบริการ';
const tService = 'เพิ่มบริการ';
const tEditService = 'แก้ไขบริการ';
const tServiceName = 'ชื่อบริการ';
const tServiceDesc = 'คำอธิบาย';
const tServiceType = 'ประเภทบริการ';
const tHistory = 'ประวัติ';
const tSupportCenter = 'ศูนย์ช่วยเหลือ';
const tLogin = 'เข้าสู่ระบบ';

//Tracking Status
const trackingStatus = [
  'กำลังเตรียมของ',
  'กำลังเดินทาง',
  'ถึงที่หมายแล้ว',
  'งานเสร็จแล้ว'
];

const menusSetting = ['โปรไฟล์', 'การตั้งค่า', 'ออกจากระบบ'];
const menusSettingRoute = [PROFILE_ROUTE, SETTING_ROUTE];

Garage gargeMockup = Garage(
    id: '1',
    name: 'Jone Cena',
    phone: '0359887456',
    email: "email@mail.com",
    password: '1234',
    validatePhone: true,
    address: Address(addressDesc: '', geoLocation: GeoLocation()),
    images: [],
    typeCarRepairs: []);
List<String> serviceType = [
  'fuel',
  'battery',
  'break',
  'tire',
  'rickshaw',
  'engine-oil'
];
List<String> serviceTypeName = [
  'น้ำมัน',
  'แบตเตอรี่',
  'เบรค',
  'ยางรถ',
  'รถลาก',
  'น้ำมันเครื่อง'
];

List<ServiceType> mockupServiceType = [
  ServiceType(id: '1', name: 'น้ำมัน', description: 'description'),
  ServiceType(id: '2', name: 'แบตเตอรี่', description: 'description'),
  ServiceType(id: '3', name: 'เบรค', description: 'description'),
  ServiceType(id: '4', name: 'ยางรถ', description: 'description'),
  ServiceType(id: '5', name: 'รถลาก', description: 'description'),
  ServiceType(id: '6', name: 'น้ำมันเครื่อง', description: 'description'),
];

List<NotifyInfo> mockupNotify = [
  NotifyInfo(
      typeNotify: 'โปรโมชั่น',
      title: 'ส่วนลดพิเศษประจำสัปดาห์',
      desc: [
        'เพียงใส่โค้ดส่วนลด RODSIANEW ท่านก็จะได้รับส่วนลด 20% สำหรับ ลูกค้าใหม่และ RODSIAAPP สำหรับลูกค้าเก่าจะได้รับส่วนลด 10%',
      ],
      image:
          'https://hoonhoonbeauty.com/wp-content/uploads/2017/04/AdobeStock_262035364_Promotion-1024x382.jpeg',
      startDate: DateTime(2021, 10, 1),
      endDate: DateTime(2021, 10, 15),
      condition: [
        'เงื่อนไปเป็นไปตามที่บริษัทกำหนด',
        'ต้องขอบริการเป็นประเภทยาง'
      ]),
  NotifyInfo(
      typeNotify: 'อัพเดต',
      title: 'อัพเดตเวอร์ชั้นล่าสุด',
      desc: [
        'เป็นเวอร์ชั้นที่มีการพัฒนาเรื่องความปลอดภัย เพิ่มความแม่นยำให้การหาอู๋ซ้อมรถ เพื่อให้ลูกค้าสบายใจได้เลย',
        'อัปเดตแอป Android ด้วยตนเอง\n  1.วิธีอัปเดตแอปทีละรายการหรือหลายรายการโดยใช้แอป Google Play Store บนอุปกรณ์เคลื่อนที่มีดังนี้\n  2.เปิดแอป Google Play Store Google Play\n  3.แตะไอคอนโปรไฟล์ที่ด้านบนขวา \n  4.แตะจัดการแอปและอุปกรณ์ แอปที่พร้อมอัปเดตจะมีป้าย "มีเวอร์ชันอัปเดต"\n  5.แตะอัปเดต'
      ],
      image:
          'https://www.thrillogyproductions.com/wp-content/uploads/2018/12/Update.jpg',
      startDate: DateTime(2021, 10, 30),
      endDate: null,
      condition: [
        'คุณสามารถอัปเดต iPhone, iPad หรือ iPod touch ของคุณเป็น iOS หรือ iPadOS เวอร์ชั่นล่าสุดแบบไร้สายได้',
        'หากคุณใช้ iOS หรือ iPadOS เวอร์ชั่น 14.5 หรือใหม่กว่า คุณอาจเห็นตัวเลือกให้เลือกระหว่างการอัพเดทซอฟต์แวร์สองเวอร์ชั่น ตัวเลือกนี้ช่วยให้คุณสามารถเลือกระหว่างการอัพเดทเป็นเวอร์ชั่นล่าสุดของ iOS หรือ iPadOS 15 ทันทีที่เปิดตัว หรือใช้เป็น iOS หรือ iPadOS 14 ต่อไปในขณะที่ยังคงได้รับรายการอัพเดทความปลอดภัยที่สําคัญเป็นระยะเวลาหนึ่ง',
        'หากคุณไม่เห็นรายการอัปเดตในอุปกรณ์ คุณสามารถอัปเดตด้วยตนเองได้โดยใช้คอมพิวเตอร์ ดูวิธีอัปเดตอุปกรณ์ของคุณด้วยตนเอง หากคุณใช้ Mac ที่มี macOS Catalina หรือใหม่กว่า หรือหากคุณใช้ Mac ที่มี macOS Mojave หรือรุ่นก่อนหน้า หรือใช้ PC ที่ใช้ Windows'
      ]),
  NotifyInfo(
      typeNotify: 'โปรโมชั่น',
      title: 'ส่วนลดพิเศษประจำสัปดาห์',
      desc: [
        'เพียงใส่โค้ดส่วนลด RODSIANEW ท่านก็จะได้รับส่วนลด 20% สำหรับ ลูกค้าใหม่และ RODSIAAPP สำหรับลูกค้าเก่าจะได้รับส่วนลด 10%'
      ],
      image:
          'https://hoonhoonbeauty.com/wp-content/uploads/2017/04/AdobeStock_262035364_Promotion-1024x382.jpeg',
      startDate: DateTime(2021, 10, 1),
      endDate: DateTime(2021, 10, 15),
      condition: [
        'เงื่อนไปเป็นไปตามที่บริษัทกำหนด',
        'ต้องขอบริการเป็นประเภทยาง'
      ]),
  NotifyInfo(
      typeNotify: 'อัพเดต',
      title: 'อัพเดตเวอร์ชั้นล่าสุด',
      desc: [
        'เป็นเวอร์ชั้นที่มีการพัฒนาเรื่องความปลอดภัย เพิ่มความแม่นยำให้การหาอู๋ซ้อมรถ เพื่อให้ลูกค้าสบายใจได้เลย',
        'อัปเดตแอป Android ด้วยตนเอง\n  1.วิธีอัปเดตแอปทีละรายการหรือหลายรายการโดยใช้แอป Google Play Store บนอุปกรณ์เคลื่อนที่มีดังนี้\n  2.เปิดแอป Google Play Store Google Play\n  3.แตะไอคอนโปรไฟล์ที่ด้านบนขวา \n  4.แตะจัดการแอปและอุปกรณ์ แอปที่พร้อมอัปเดตจะมีป้าย "มีเวอร์ชันอัปเดต"\n  5.แตะอัปเดต'
      ],
      image:
          'https://www.thrillogyproductions.com/wp-content/uploads/2018/12/Update.jpg',
      startDate: DateTime(2021, 10, 30),
      endDate: null,
      condition: [
        'คุณสามารถอัปเดต iPhone, iPad หรือ iPod touch ของคุณเป็น iOS หรือ iPadOS เวอร์ชั่นล่าสุดแบบไร้สายได้',
        'หากคุณใช้ iOS หรือ iPadOS เวอร์ชั่น 14.5 หรือใหม่กว่า คุณอาจเห็นตัวเลือกให้เลือกระหว่างการอัพเดทซอฟต์แวร์สองเวอร์ชั่น ตัวเลือกนี้ช่วยให้คุณสามารถเลือกระหว่างการอัพเดทเป็นเวอร์ชั่นล่าสุดของ iOS หรือ iPadOS 15 ทันทีที่เปิดตัว หรือใช้เป็น iOS หรือ iPadOS 14 ต่อไปในขณะที่ยังคงได้รับรายการอัพเดทความปลอดภัยที่สําคัญเป็นระยะเวลาหนึ่ง',
        'หากคุณไม่เห็นรายการอัปเดตในอุปกรณ์ คุณสามารถอัปเดตด้วยตนเองได้โดยใช้คอมพิวเตอร์ ดูวิธีอัปเดตอุปกรณ์ของคุณด้วยตนเอง หากคุณใช้ Mac ที่มี macOS Catalina หรือใหม่กว่า หรือหากคุณใช้ Mac ที่มี macOS Mojave หรือรุ่นก่อนหน้า หรือใช้ PC ที่ใช้ Windows'
      ]),
];
