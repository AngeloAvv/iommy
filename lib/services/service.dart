import 'package:talker/talker.dart';

/// Abstract class of a Service
abstract class Service {
  final Talker logger;

  const Service({
    required this.logger,
  });
}
