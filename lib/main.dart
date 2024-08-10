import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scavenger_hunt_repository/scavenger_hunt_repository.dart';

import 'app/app.dart';
import 'firebase_options.dart';
import 'photo/photo_picker.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = const _AppBlocObserver();

  final photoPicker = PhotoPicker(imagePicker: ImagePicker());

  late final ScavengerHuntRepository repository;

  const useFakeData = bool.fromEnvironment(
    'USE_FAKE_DATA',
    defaultValue: false,
  );

  if (useFakeData) {
    repository = const FakeScavengerHuntRepository();
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    final client = ScavengerHuntClient();

    repository = ScavengerHuntRepository(client: client);
  }

  runApp(App(photoPicker: photoPicker, repository: repository));
}

class _AppBlocObserver extends BlocObserver {
  const _AppBlocObserver();

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    debugPrint(transition.toString());
  }
}
