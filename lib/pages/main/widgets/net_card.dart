import 'package:flutter/material.dart';
import 'package:flutter_essentials_kit/flutter_essentials_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iommy/features/localization/extensions/build_context.dart';
import 'package:iommy/features/theme/extensions/device_extension.dart';
import 'package:iommy/models/net/net.dart';
import 'package:iommy/pages/main/widgets/capability_item.dart';

class NetCard extends StatelessWidget {
  final Net net;
  final String? name;

  const NetCard(
    this.net, {
    super.key,
    this.name,
  });

  @override
  Widget build(BuildContext context) => Card(
        color: Theme.of(context).colorScheme.surface,
        shape: Theme.of(context).deviceTheme?.networkColor?.let(
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
                    FontAwesomeIcons.ethernet,
                    size: 28.0,
                    color: Theme.of(context).deviceTheme?.networkColor,
                  ),
                  Text(
                    name ??
                        context.l10n?.labelNetworkDevice ??
                        'labelNetworkDevice',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).deviceTheme?.networkColor,
                        ),
                  ),
                ],
              ),
              CapabilityItem(
                title: net.pciId,
                subtitle: context.l10n?.labelIdentifier ?? 'labelIdentifier',
              ),
              CapabilityItem(
                title: net.vendorDeviceId,
                subtitle: context.l10n?.labelVendorIdentifier ??
                    'labelVendorIdentifier',
              ),
              CapabilityItem(
                title: net.interface,
                subtitle: context.l10n?.labelNetworkInterface ??
                    'labelNetworkInterface',
              ),
              CapabilityItem(
                title: net.mac,
                subtitle: context.l10n?.labelMacAddress ?? 'labelMacAddress',
              ),
            ],
          ),
        ),
      );
}
