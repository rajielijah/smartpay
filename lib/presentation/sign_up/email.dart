import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../app/di.dart';
import '../../app/function.dart';
import '../../app/navigation_services.dart';
import '../reuseables/WidgetUtils.dart';

class EmailView extends StatefulWidget {
  const EmailView({Key? key}) : super(key: key);

  @override
  State<EmailView> createState() => _EmailViewState();
}

class _EmailViewState extends State<EmailView> {
  double sHeight = WidgetUtils.screenHeight;
  double sWidth = WidgetUtils.screenWidth;
  final Connectivity _connectivity = Connectivity();
  late ValueNotifier<bool> _isEnabled;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
    final NavigationService _navigationService = instance<NavigationService>();

  final TextEditingController _emailController = TextEditingController();

  _bind() async {
    
  }

  @override
  void initState() {
    _bind();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(updateConnectionStatus);
    // checkInternetConnectivity2();
    super.initState();
    _isEnabled = ValueNotifier<bool>(true);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}