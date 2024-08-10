# AI Photo Scavenger Hunt

A fun photo scavenger hunt game implemented using [Flutter](https://flutter.dev) and [Google AI Dart SDK](https://pub.dev/packages/google_generative_ai). Generative AI model used for the project: [Google Gemini Pro Vision](https://cloud.google.com/vertex-ai/docs/generative-ai/multimodal/overview).

<p float="left">
    <img src="./images/screenshot_1.png" alt="Scavenger hunt location selection" width="250">
	<img src="./images/screenshot_2.png" alt="Scavenger hunt view" width="250">
	<img src="./images/screenshot_3.png" alt="Results view" width="250">
</p>

## Getting Started

You can follow these instructions to build the app and install it onto your device.

### Prerequisites

If you are new to Flutter, please first follow the [Flutter Setup](https://flutter.dev/setup/) guide.

### Building and installing the app (with fake data)

```bash
git clone git@github.com:mkobuolys/ai-photo-scavenger-hunt.git
cd ai-photo-scavenger-hunt
flutter pub get
flutter run --dart-define USE_FAKE_DATA=true
```

The `flutter run` command both builds and installs the Flutter app to your device or emulator.

Notice the `--dart-define USE_FAKE_DATA=true` flag. This flag is used to enable the fake data mode. In this mode, the app uses fake data instead of the Gemini API. This is useful for testing the app without access to the real generative AI model.

### Building and installing the app (with real data)

Create a new Firebase project and connect it to the Flutter app by running the following command (replace `<project_id>` with your Firebase project ID):

```
flutterfire configure -p <project_id> -o lib/firebase_options.dart
```

Then, build and install the app:

```bash
flutter pub get
flutter run
```

For more information on how to set up Firebase for Flutter, see the [Get started with the Gemini API using the Vertex AI in Firebase SDKs](https://firebase.google.com/docs/vertex-ai/get-started?platform=flutter) guide.
