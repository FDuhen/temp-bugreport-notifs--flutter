import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutonotif/core/notification_manager.dart';

class BaseComponent extends StatelessWidget {
  const BaseComponent({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NotificationManager(),
        ),
      ],
      child: child,
    );
  }
}
