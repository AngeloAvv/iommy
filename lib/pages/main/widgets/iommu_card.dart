import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iommy/features/localization/extensions/build_context.dart';
import 'package:iommy/features/theme/extensions/device_extension.dart';
import 'package:iommy/models/iommu/iommu.dart';
import 'package:iommy/pages/main/widgets/device_badge.dart';
import 'package:iommy/pages/main/widgets/net_card.dart';
import 'package:iommy/pages/main/widgets/pci_card.dart';
import 'package:iommy/pages/main/widgets/sata_card.dart';
import 'package:iommy/pages/main/widgets/usb_card.dart';

import 'nvme_card.dart';

class IommuCard extends StatelessWidget {
  final Iommu iommu;
  final bool expanded;
  final Map<String, String> mappedNames;
  final GestureTapCallback? onTap;

  const IommuCard(
    this.iommu, {
    super.key,
    this.expanded = false,
    this.mappedNames = const {},
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        sliver: SliverToBoxAdapter(
          child: Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.layerGroup,
                        size: 48.0,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Wrap(
                        spacing: 4.0,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              context.l10n?.labelGroup(iommu.id) ??
                                  'labelGroup(${iommu.id})',
                            ),
                          ),
                          if (iommu.pciDevices.isNotEmpty)
                            DeviceBadge(
                              context.l10n?.labelPci ?? 'labelPci',
                              color: Theme.of(context).deviceTheme?.pciColor,
                            ),
                          if (iommu.netDevices.isNotEmpty)
                            DeviceBadge(
                              context.l10n?.labelNetwork ?? 'labelNetwork',
                              color:
                                  Theme.of(context).deviceTheme?.networkColor,
                            ),
                          if (iommu.sataDevices.isNotEmpty)
                            DeviceBadge(
                              context.l10n?.labelSata ?? 'labelSata',
                              color: Theme.of(context).deviceTheme?.sataColor,
                            ),
                          if (iommu.usbDevices.isNotEmpty)
                            DeviceBadge(
                              context.l10n?.labelUsb ?? 'labelUsb',
                              color: Theme.of(context).deviceTheme?.usbColor,
                            ),
                          if (iommu.nvmeDevices.isNotEmpty)
                            DeviceBadge(
                              context.l10n?.labelNvme ?? 'labelNvme',
                              color: Theme.of(context).deviceTheme?.nvmeColor,
                            ),
                        ],
                      ),
                      subtitle: Text(
                        context.l10n?.labelDevices(iommu.length) ??
                            'labelDevices(${iommu.length})',
                      ),
                      trailing: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          border: Border.all(
                              color: Theme.of(context).colorScheme.secondary),
                          color: expanded
                              ? Theme.of(context).colorScheme.secondary
                              : null,
                        ),
                        child: Icon(
                          expanded ? Icons.remove : Icons.add,
                          color: expanded
                              ? Colors.white
                              : Theme.of(context).colorScheme.secondary,
                          size: 48.0,
                        ),
                      ),
                    ),
                    AnimatedSize(
                      duration: Duration(milliseconds: 250),
                      curve: Curves.fastOutSlowIn,
                      child: switch (expanded) {
                        true => Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.only(
                              left: 16.0,
                              right: 16.0,
                              bottom: 16.0,
                            ),
                            child: Column(
                              spacing: 8.0,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  spacing: 8.0,
                                  runSpacing: 8.0,
                                  children: iommu.pciDevices.map(
                                    (device) {
                                      final name =
                                          mappedNames[device.vendorDeviceId];

                                      return PciCard(
                                        device,
                                        name: name,
                                      );
                                    },
                                  ).toList(growable: false),
                                ),
                                Wrap(
                                  spacing: 8.0,
                                  runSpacing: 8.0,
                                  children: iommu.netDevices.map(
                                    (device) {
                                      final name =
                                          mappedNames[device.vendorDeviceId];

                                      return NetCard(
                                        device,
                                        name: name,
                                      );
                                    },
                                  ).toList(growable: false),
                                ),
                                Wrap(
                                  spacing: 8.0,
                                  runSpacing: 8.0,
                                  children: iommu.sataDevices.map(
                                    (device) {
                                      final name =
                                          mappedNames[device.vendorDeviceId];

                                      return SataCard(
                                        device,
                                        name: name,
                                      );
                                    },
                                  ).toList(growable: false),
                                ),
                                Wrap(
                                  spacing: 8.0,
                                  runSpacing: 8.0,
                                  children: iommu.usbDevices.map(
                                    (device) {
                                      final name =
                                          mappedNames[device.vendorDeviceId];

                                      return UsbCard(
                                        device,
                                        name: name,
                                      );
                                    },
                                  ).toList(growable: false),
                                ),
                                Wrap(
                                  spacing: 8.0,
                                  runSpacing: 8.0,
                                  children: iommu.nvmeDevices.map(
                                    (device) {
                                      final name =
                                          mappedNames[device.vendorDeviceId];

                                      return NvmeCard(
                                        device,
                                        name: name,
                                      );
                                    },
                                  ).toList(growable: false),
                                ),
                              ],
                            ),
                          ),
                        false => SizedBox(
                            width: double.maxFinite,
                          ),
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
