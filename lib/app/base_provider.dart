import 'package:flutter/material.dart';

class BaseProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  void busy() {
    _isLoading = true;
    notifyListeners();
  }

  void idle() {
    _isLoading = false;
    notifyListeners();
  }

  void addError(String errorMessage) {
    _errorMessage = errorMessage;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  String get error => _errorMessage ?? "Unknown error";

  bool get hasError => _errorMessage != null;

  bool get isBusy => _isLoading;
}
