import 'package:flutter/material.dart';

// api base url
// dev localhost api
final baseUrlConstant = "http://localhost:3000/api";

// production api
// final baseUrlConstant = '';

// router path
const REGISTER_ROUTE = "/register";
const LOGIN_ROUTE = "/login";
const EDIT_GARAGE_ROUTE = "/edit_garage";
const ADD_SERVICE_ROUTE = "/add_service";

// color that use in app
const textColorBlack = Color(0xff38454C);
const textColorWhite = Colors.white;
const textColorRed = Color(0xffDA5B49);

const primaryColor = Color(0xffFECE2F);
const colorGray = Color(0xffC4C4C4);
const bgColor = Color(0xffF2F4F6);

const cardColor = Colors.white;

// message, wording
const mError = "Service unvalidable, please try agian.";
const mLoading = "loading";
const mNotFound = "not found!";

// src string for set widget
const tOKThai = 'ตกลง';
const tServiceOfGarage = 'บริการของร้าน';
const tAlertRequestService = 'มีคนต้องการความช่วยเหลือ!';
const tRequestServiceThai = 'ขอรับบริการ';
const tDeclineThai = 'ปฏิเสธิ';
const tAddressThai = 'ที่อยู่: ';
const tUpdateThai = 'อัพเดต';
const tCancleThai = 'ยกเลิก';
const tAcceptThai = 'ยอมรับ';
const tYesThai = 'ใช้';
const tMessage = "messages";
const tEmail = "E-mail";
const tPassword = "Password";
const tNameGarageThai = "ชื่ออู๋:";
const tNameUserThai = "ชื่อลูกค้า:";
const tLocationThai = 'ตำแหน่ง:';
const tProblemThai = 'ปัญหา:';
