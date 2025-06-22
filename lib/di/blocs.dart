part of 'dependency_injector.dart';

final List<BlocProvider> _blocs = [
  BlocProvider<ConfigurationBloc>(
    create: (context) => ConfigurationBloc(
      configurationRepository: context.read(),
    )..fetch(),
  ),
];
