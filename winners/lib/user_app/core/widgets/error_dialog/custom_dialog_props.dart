import 'package:flutter/material.dart';

class CustomDialogProps {
  CustomDialogProps({
    this.isSuccess,
    this.title,
    this.message,
    this.buttonTitle,
    this.secbuttonTitle,
    this.firstTap,
    this.secTap,
  });
  final String? title;
  final String? message;
  final String? buttonTitle;
  final String? secbuttonTitle;
  bool? isSuccess;
  VoidCallback? firstTap;
  VoidCallback? secTap;
}
