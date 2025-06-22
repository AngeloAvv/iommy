import 'package:bloc_test/bloc_test.dart';
import 'package:iommy/blocs/configuration/configuration_bloc.dart';

class MockConfigurationBloc
    extends MockBloc<ConfigurationEvent, ConfigurationState>
    implements ConfigurationBloc {}
