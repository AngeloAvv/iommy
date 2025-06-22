import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_essentials_kit/extensions/iterable.dart';
import 'package:iommy/blocs/identifiers/identifiers_bloc.dart';
import 'package:iommy/blocs/iommu/iommu_bloc.dart';
import 'package:iommy/features/localization/extensions/build_context.dart';
import 'package:iommy/features/routing/app_router.dart';
import 'package:iommy/features/theme/extensions/device_extension.dart';
import 'package:iommy/models/iommu/iommu.dart';
import 'package:iommy/pages/main/widgets/buttons/collapse_all_button.dart';
import 'package:iommy/pages/main/widgets/buttons/expand_all_button.dart';
import 'package:iommy/pages/main/widgets/buttons/settings_icon_button.dart';
import 'package:iommy/pages/main/widgets/courtesy/empty_groups_courtesy.dart';
import 'package:iommy/pages/main/widgets/courtesy/error_groups_courtesy.dart';
import 'package:iommy/pages/main/widgets/fields/reactive_device_filter.dart';
import 'package:iommy/pages/main/widgets/iommu_card.dart';
import 'package:iommy/widgets/loading_widget.dart';
import 'package:reactive_forms/reactive_forms.dart';

@RoutePage()
class MainPage extends StatefulWidget implements AutoRouteWrapper {
  static const _kFormNetwork = 'network';
  static const _kFormPci = 'pci';
  static const _kFormSata = 'sata';
  static const _kFormUsb = 'usb';
  static const _kFormNvme = 'nvme';

  const MainPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<IdentifiersBloc>(
            create: (context) => IdentifiersBloc(
              pciRepository: context.read(),
            )..fetch(),
          ),
          BlocProvider<IommuBloc>(
            create: (context) => IommuBloc(
              iommuRepository: context.read(),
            )..scan(),
          ),
        ],
        child: this,
      );

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _form = FormGroup({
    MainPage._kFormNetwork: FormControl<bool>(value: true),
    MainPage._kFormPci: FormControl<bool>(value: true),
    MainPage._kFormSata: FormControl<bool>(value: true),
    MainPage._kFormUsb: FormControl<bool>(value: true),
    MainPage._kFormNvme: FormControl<bool>(value: true),
  });

  final Set<Iommu> _expandedGroups = {};

  @override
  Widget build(BuildContext context) => ReactiveForm(
        formGroup: _form,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              SettingsIconButton(
                onPressed: () => context.pushRoute(SettingsRoute()),
              ),
            ],
          ),
          body: BlocSelector<IdentifiersBloc, IdentifiersState,
              Map<String, String>>(
            selector: (state) => switch (state) {
              FetchedIdentifiersState(:final identifiers) => identifiers
                  .groupBy((identifier) => identifier.vendorDeviceId)
                  .map(((id, items) => MapEntry(id, items.first.deviceName))),
              _ => const {},
            },
            builder: (context, mappedNames) =>
                BlocBuilder<IommuBloc, IommuState>(
              builder: (context, state) => switch (state) {
                ScanningIommuState() => const LoadingWidget(),
                ScannedIommuState(:final groups) => ReactiveFormConsumer(
                    builder: (context, form, _) =>
                        switch (groups.filterByFormGroup(form)) {
                      [] => const EmptyGroupsCourtesy(),
                      final groups => CustomScrollView(
                          slivers: groups
                              .map(
                                (group) => IommuCard(
                                  group,
                                  expanded: _expandedGroups.contains(group),
                                  mappedNames: mappedNames,
                                  onTap: () {
                                    setState(
                                      () {
                                        if (_expandedGroups.contains(group)) {
                                          _expandedGroups.remove(group);
                                        } else {
                                          _expandedGroups.add(group);
                                        }
                                      },
                                    );
                                  },
                                ),
                              )
                              .toList(growable: false),
                        ),
                    },
                  ),
                EmptyIommuState() => const EmptyGroupsCourtesy(),
                ErrorScanningIommuState() => ErrorGroupsCourtesy(
                    onPressed: () => context.iommuBloc.scan(),
                  ),
                _ => const SizedBox.shrink(),
              },
            ),
          ),
          bottomNavigationBar: Container(
            height: 80.0,
            padding: EdgeInsets.all(16.0),
            child: CustomScrollView(
              scrollDirection: Axis.horizontal,
              slivers: [
                SliverToBoxAdapter(
                  child: Row(
                    spacing: 16.0,
                    children: [
                      ReactiveDeviceFilter(
                        context.l10n?.labelPciDevice ?? 'labelPciDevice',
                        formControlName: MainPage._kFormPci,
                        color: Theme.of(context).deviceTheme?.pciColor,
                      ),
                      ReactiveDeviceFilter(
                        context.l10n?.labelNetworkDevice ??
                            'labelNetworkDevice',
                        formControlName: MainPage._kFormNetwork,
                        color: Theme.of(context).deviceTheme?.networkColor,
                      ),
                      ReactiveDeviceFilter(
                        context.l10n?.labelSataDevice ?? 'labelSataDevice',
                        formControlName: MainPage._kFormSata,
                        color: Theme.of(context).deviceTheme?.sataColor,
                      ),
                      ReactiveDeviceFilter(
                        context.l10n?.labelUsbDevice ?? 'labelUsbDevice',
                        formControlName: MainPage._kFormUsb,
                        color: Theme.of(context).deviceTheme?.usbColor,
                      ),
                      ReactiveDeviceFilter(
                        context.l10n?.labelNvmeDevice ?? 'labelNvmeDevice',
                        formControlName: MainPage._kFormNvme,
                        color: Theme.of(context).deviceTheme?.nvmeColor,
                      ),
                    ],
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      spacing: 16.0,
                      children: [
                        BlocBuilder<IommuBloc, IommuState>(
                          builder: (context, state) => switch (state) {
                            ScannedIommuState(:final groups) => ExpandAllButton(
                                onPressed: () => _expandAll(
                                  context,
                                  groups: groups,
                                ),
                              ),
                            _ => const SizedBox.shrink(),
                          },
                        ),
                        BlocBuilder<IommuBloc, IommuState>(
                          builder: (context, state) => switch (state) {
                            ScannedIommuState() => CollapseAllButton(
                                onPressed: () => _collapseAll(context),
                              ),
                            _ => const SizedBox.shrink(),
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  void _collapseAll(BuildContext context) =>
      setState(() => _expandedGroups.clear());

  void _expandAll(BuildContext context, {required List<Iommu> groups}) =>
      setState(() => _expandedGroups.addAll(groups));
}

extension on List<Iommu> {
  List<Iommu> filterByFormGroup(FormGroup formGroup) {
    final network = formGroup.control(MainPage._kFormNetwork).value as bool;
    final pci = formGroup.control(MainPage._kFormPci).value as bool;
    final sata = formGroup.control(MainPage._kFormSata).value as bool;
    final usb = formGroup.control(MainPage._kFormUsb).value as bool;
    final nvme = formGroup.control(MainPage._kFormNvme).value as bool;

    return where((iommu) {
      final hasNet = network && iommu.netDevices.isNotEmpty;
      final hasPci = pci && iommu.pciDevices.isNotEmpty;
      final hasSata = sata && iommu.sataDevices.isNotEmpty;
      final hasUsb = usb && iommu.usbDevices.isNotEmpty;
      final hasNvme = nvme && iommu.nvmeDevices.isNotEmpty;

      return hasNet || hasPci || hasSata || hasUsb || hasNvme;
    })
        .map(
          (iommu) => iommu.copyWith(
            netDevices: network ? iommu.netDevices : const [],
            pciDevices: pci ? iommu.pciDevices : const [],
            sataDevices: sata ? iommu.sataDevices : const [],
            usbDevices: usb ? iommu.usbDevices : const [],
            nvmeDevices: nvme ? iommu.nvmeDevices : const [],
          ),
        )
        .toList();
  }
}
