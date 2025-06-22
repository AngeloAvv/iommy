import 'package:flutter/material.dart';
import 'package:flutter_essentials_kit/flutter_essentials_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iommy/features/localization/extensions/build_context.dart';
import 'package:iommy/features/theme/extensions/device_extension.dart';
import 'package:iommy/models/usb/usb.dart';
import 'package:iommy/pages/main/widgets/capability_item.dart';

class UsbCard extends StatelessWidget {
  final Usb usb;
  final String? name;

  const UsbCard(
    this.usb, {
    super.key,
    this.name,
  });

  @override
  Widget build(BuildContext context) => Card(
        color: Theme.of(context).colorScheme.surface,
        shape: Theme.of(context).deviceTheme?.usbColor?.let(
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
                    FontAwesomeIcons.usb,
                    size: 28.0,
                    color: Theme.of(context).deviceTheme?.usbColor,
                  ),
                  Text(
                    name ?? usb.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).deviceTheme?.usbColor,
                        ),
                  ),
                ],
              ),
              CapabilityItem(
                title: usb.pciId,
                subtitle: context.l10n?.labelIdentifier ?? 'labelIdentifier',
              ),
              CapabilityItem(
                title: usb.vendorDeviceId,
                subtitle: context.l10n?.labelVendorIdentifier ??
                    'labelVendorIdentifier',
              ),
            ],
          ),
        ),
      );
}
