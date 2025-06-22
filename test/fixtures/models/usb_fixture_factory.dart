import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:iommy/models/usb/usb.dart';

extension UsbFixture on Usb {
  static UsbFixtureFactory factory() => UsbFixtureFactory();
}

class UsbFixtureFactory extends FixtureFactory<Usb> {
  @override
  FixtureDefinition<Usb> definition() => define(
        (faker, [int index = 0]) => Usb(
            name: faker.lorem.word(),
            pciId: faker.guid.guid(),
            vendorDeviceId: faker.guid.guid()),
      );
}
