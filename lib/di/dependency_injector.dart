import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iommy/misc/mappers/identifier/identifier_mapper.dart';
import 'package:iommy/repositories/pci_repository.dart';
import 'package:pine/pine.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:iommy/blocs/configuration/configuration_bloc.dart';
import 'package:iommy/misc/mappers/net/net_mapper.dart';
import 'package:iommy/misc/mappers/nvme/nvme_mapper.dart';
import 'package:iommy/misc/mappers/pci/pci_mapper.dart';
import 'package:iommy/misc/mappers/sata/sata_mapper.dart';
import 'package:iommy/misc/mappers/usb/usb_mapper.dart';
import 'package:iommy/repositories/configuration_repository.dart';
import 'package:iommy/repositories/iommu_repository.dart';
import 'package:iommy/services/configuration_service.dart';
import 'package:iommy/services/local/iommu/iommu_service.dart';
import 'package:iommy/services/local/net/net_service.dart';
import 'package:iommy/services/local/nvme/nvme_service.dart';
import 'package:iommy/services/local/pci/pci_service.dart';
import 'package:iommy/services/local/sata/sata_service.dart';
import 'package:iommy/services/local/usb/usb_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker/talker.dart';

part 'blocs.dart';
part 'providers.dart';
part 'repositories.dart';

class DependencyInjector extends StatelessWidget {
  final Widget child;

  const DependencyInjector({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => DependencyInjectorHelper(
        blocs: _blocs,
        providers: _providers,
        repositories: _repositories,
        child: child,
      );
}
