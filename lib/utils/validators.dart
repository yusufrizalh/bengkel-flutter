import 'dart:io';
import 'package:mime/mime.dart';

class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 6) {
      return 'Name must be at least 6 characters';
    }
    return null;
  }

  //====================================================

  static String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Title is required';
    }
    if (value.length > 100) {
      return 'Title cannot be longer than 100 characters';
    }
    return null;
  }

  static String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Description is required';
    }
    if (value.length > 500) {
      return 'Description cannot be longer than 500 characters';
    }
    return null;
  }

  static String? validateFile(File? file, {int maxSizeMB = 8}) {
    if (file == null) {
      return 'File is required';
    }

    // Check file size (8MB limit)
    final fileSizeInMB = file.lengthSync() / (1024 * 1024);
    if (fileSizeInMB > maxSizeMB) {
      return 'File size must be less than $maxSizeMB MB';
    }

    // Check file type
    final mimeType = lookupMimeType(file.path);
    if (mimeType == null ||
        (!mimeType.startsWith('image/') && mimeType != 'application/pdf')) {
      return 'Only images and PDF files are allowed';
    }

    return null;
  }
}
