import 'package:flutter/material.dart';
import 'package:flutter_essentials_kit/flutter_essentials_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iommy/features/localization/extensions/build_context.dart';
import 'package:iommy/features/theme/extensions/device_extension.dart';
import 'package:iommy/models/sata/sata.dart';
import 'package:iommy/pages/main/widgets/capability_item.dart';

class SataCard extends StatelessWidget {
  final Sata sata;
  final String? name;

  const SataCard(this.sata, {super.key, this.name});

  @override
  Widget build(BuildContext context) => Card(
        color: Theme.of(context).colorScheme.surface,
        shape: Theme.of(context).deviceTheme?.sataColor?.let(
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
                    FontAwesomeIcons.hardDrive,
                    size: 28.0,
                    color: Theme.of(context).deviceTheme?.sataColor,
                  ),
                  Text(
                    name ?? context.l10n?.labelSata ?? 'labelSata',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).deviceTheme?.sataColor,
                        ),
                  ),
                ],
              ),
              CapabilityItem(
                title: sata.device,
                subtitle: context.l10n?.labelDeviceName ?? 'labelDeviceName',
              ),
              CapabilityItem(
                title: sata.vendor,
                subtitle: context.l10n?.labelDeviceVendor ?? 'labelDeviceVendor',
              ),
              CapabilityItem(
                title: sata.vendorDeviceId,
                subtitle: context.l10n?.labelVendorIdentifier ??
                    'labelVendorIdentifier',
              ),
              CapabilityItem(
                title: sata.model,
                subtitle: context.l10n?.labelDeviceModel ?? 'labelDeviceModel',
              ),
            ],
          ),
        ),
      );
}
