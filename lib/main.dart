import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tutonotif/base_component.dart';
import 'package:tutonotif/core/notification_manager.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BaseComponent(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Center(
          child: Consumer<NotificationManager>(
            builder: (context, manager, _) => Column(
              children: [
                OutlinedButton(
                  onPressed: () {
                    manager.askNotifificationPermission();
                  },
                  child: const Text('Ask notification permissions'),
                ),
                Text(manager.deviceToken ?? ''),
                if (manager.deviceToken != null)
                  IconButton(
                    onPressed: () async {
                      await Clipboard.setData(
                        ClipboardData(text: manager.deviceToken!),
                      );
                    },
                    icon: const Icon(Icons.copy),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
