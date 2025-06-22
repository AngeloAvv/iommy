import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iommy/app.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = TalkerBlocObserver();

  runApp(App());
}
