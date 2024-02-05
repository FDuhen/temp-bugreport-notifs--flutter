# Flutter notification tuto

Flutter version v.3.16.8.

This project demonstrates how to get notifications on Android and iOS from Firebase Cloud Messaging.
Provider is used to inject the notification manager.

## Getting Started

## Pubspec.yaml - Librairies
- provider
- firebase_core
- firebase_messaging

To add all dependencies, type in your terminal: 
```shell
flutter pub add provider firebase_core firebase_messaging
```

# Firebase
After creating your Firebase project, you will need to link your app to Firebase.

## 1st method: Flutterfire et Firebase CLI (automatic)

- Install [Firebase CLI](https://firebase.google.com/docs/cli?hl=fr&authuser=1#install_the_firebase_cli)
- Login to your account with `firebase login`
- Install FlutterFire Cli with `dart pub global activate flutterfire_cli`
- Configure your app with `flutterfire configure --project=<project_id>`

Add the following in `main.dart`:
```dart
void main() async {
  // THIS
  WidgetsFlutterBinding.ensureInitialized();
  // THIS
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
```
Don't forget to add `async` to the main() function.
Now your app should be configured to use your Firebase project.

## 2st method: Manual configuration
You can manually configure apps in Firebase.

For Android, after the setup you will get a `google-services.json` file.
Place it in `android/app` folder.

For iOS, you will get an GoogleService-Info.plist.
Copy your file from XCode inside iOS/Runner folder.

Add the following in `main.dart`:
```dart
void main() async {
  // THIS
  WidgetsFlutterBinding.ensureInitialized();
  // THIS
  await Firebase.initializeApp();
  runApp(const MyApp());
}
```
Don't forget to add `async` to the main() function.
Now your app should be configured to use your Firebase project.

### Android setup
There is nothing more to do on Android.

### iOS Setup
First, go to [developper apple](https://developer.apple.com/account/). 

#### Identifier
Create a new identifier (if it's not done yet).
- Select App IDs
- Fill Bundle ID with your app package name
- Check `Push Notifications`

#### Provisioning Profile
Create a new provisioning profile.
- Select the type you want and choose the App ID you've just created above.
- Download the `.mobileprovision`.

You can create a profile for debug and for your release.

Open your iOS project in Xcode (`ios/Runner.xcworkspace`).
In `Runner > Signing & Capabilities`:
- debug: import your development provisioning profile
- release: import your release provisioning profile

#### Capabilites
In `Runner > Signing & Capabilities`:
- Check `All` beside `+ Capabilities`
- Now click on `+ Capabilities`, add `Push Notifications`
- Click again on `+ Capabilities`, add `Background Modes`
- Check the `Background fetch` and `Remote notifications`

#### Key
Back to [developper apple](https://developer.apple.com/account/).
If you don't have a Key, create it and select `Apple Push Notifications service`.
- Follow the steps to create the key.
- Download your key. SAVE IT! The key cannot be re-downloaded after, by anyone.

Now that you have a key, go to your Firebase project panel.
Go to `Settings > Cloud Messaging`.
In iOS Configuration: 
- click on import inside the `Authentication Key APNs` part
- Team ID : your team ID, [can be found here](https://developer.apple.com/account), in `Subscription details`.
- Key ID : your key ID that you created recently, [key list](https://developer.apple.com/account/resources/authkeys/list)(`Keys > <your_key> > Key ID`).

