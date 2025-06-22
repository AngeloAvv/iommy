import 'package:flutter/material.dart';
import 'package:flutter_essentials_kit/flutter_essentials_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iommy/features/localization/extensions/build_context.dart';
import 'package:iommy/features/theme/extensions/device_extension.dart';
import 'package:iommy/models/pci/pci.dart';
import 'package:iommy/pages/main/widgets/capability_item.dart';

class PciCard extends StatelessWidget {
  final Pci pci;
  final String? name;

  const PciCard(
    this.pci, {
    super.key,
    this.name,
  });

  @override
  Widget build(BuildContext context) => Card(
        color: Theme.of(context).colorScheme.surface,
        shape: Theme.of(context).deviceTheme?.pciColor?.let(
              (color) => RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                side: BorderSide(
                  color: color,
                  width: 1.0,
                ),
              ),
            ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 8.0,
                children: [
                  FaIcon(
                    FontAwesomeIcons.microchip,
                    size: 28.0,
                    color: Theme.of(context).deviceTheme?.pciColor,
                  ),
                  Text(
                    name ?? context.l10n?.labelPci ?? 'labelPci',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).deviceTheme?.pciColor,
                        ),
                  ),
                ],
              ),
              CapabilityItem(
                title: pci.id,
                subtitle: context.l10n?.labelIdentifier ?? 'labelIdentifier',
              ),
              CapabilityItem(
                title: pci.vendorDeviceId,
                subtitle: context.l10n?.labelVendorIdentifier ??
                    'labelVendorIdentifier',
              ),
              CapabilityItem(
                title: pci.pciClass,
                subtitle: context.l10n?.labelPciClass ?? 'labelPciClass',
              ),
              CapabilityItem(
                title: switch (pci.resetCapable) {
                  true => context.l10n?.labelYes ?? 'labelYes',
                  false => context.l10n?.labelNo ?? 'labelNo',
                },
                subtitle: 'Reset Capable',
              ),
            ],
          ),
        ),
      );
}
