// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';

import 'package:auth_repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:very_good_slide_puzzle/app/app.dart';
import 'package:very_good_slide_puzzle/bootstrap.dart';
import 'package:very_good_slide_puzzle/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final authRepository = AuthRepository(
    firebaseAuth: firebase_auth.FirebaseAuth.instance,
  );

  // FlutterServicesBinding.ensureInitialized();

  // final leadersApi = LocalLeadersApi(
  //   plugin: await SharedPreferences.getInstance(),
  // );
  //
  // final leadersRepository = LeadersRepository(leadersApi: leadersApi);

  // try {
  //   unawaited(
  //     Firebase.initializeApp().then(
  //       (_) => authRepository.signInAnonymously(),
  //     ),
  //   );
  // } catch (e) {
  //   // TODO(s): remove this again
  //   print('annonymous signin failed ${e.toString()}');
  //   log('annonymous signin failed ${e.toString()}');
  // }

  await bootstrap(
    () => App(
      authRepository: authRepository,
      //leadersRepository: leadersRepository,
    ),
  );
}
