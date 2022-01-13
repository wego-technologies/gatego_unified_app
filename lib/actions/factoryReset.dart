import 'dart:io';

import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:gatego_unified_app/molecules/console.dart';
import 'package:gatego_unified_app/providers/serialProvider.dart';
import 'package:heroicons/heroicons.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:process_run/shell.dart';

final resetActions = [
  ActionItem(
    doOnAction: (context, ref, commandProvider) async {
      ref
          .watch(commandProvider.state)
          .state
          .add('Starting firmware download...');
      try {
        var client = http.Client();
        var req = await client
            .get(Uri.parse('https://firmware.gatego.io/firmware.bin'));
        var bytes = req.bodyBytes;
        if (req.statusCode != 200) {
          ref.read(commandProvider.state).state = [
            'Error downloading file. Code ' +
                req.statusCode.toString() +
                '\n\nDetails: ' +
                req.reasonPhrase!
          ];
          return false;
        }
        ref.read(commandProvider.state).state = [
          ...ref.read(commandProvider.state).state,
          'Saving file...'
        ];
        var dir = (await getApplicationSupportDirectory()).path;
        var file = File('$dir${Platform.pathSeparator}firmware.bin');
        ref.read(commandProvider.state).state = [
          ...ref.read(commandProvider.state).state,
          'Saved in ${file.path}'
        ];
        await file.writeAsBytes(bytes);
        ref.read(commandProvider.state).state = [
          ...ref.read(commandProvider.state).state,
          'Starting boot partition download...'
        ];
        req = await client.get(
            Uri.parse('https://firmware.gatego.io/bootloaders/boot_app0.bin'));
        bytes = req.bodyBytes;
        if (req.statusCode != 200) {
          ref.read(commandProvider.state).state = [
            'Error downloading file. Code ' +
                req.statusCode.toString() +
                '\n\nDetails: ' +
                req.reasonPhrase!
          ];
          return false;
        }
        ref.read(commandProvider.state).state = [
          ...ref.read(commandProvider.state).state,
          'Saving file...'
        ];
        file = File('$dir${Platform.pathSeparator}boot_app0.bin');
        ref.read(commandProvider.state).state = [
          ...ref.read(commandProvider.state).state,
          'Saved in ${file.path}'
        ];
        await file.writeAsBytes(bytes);
        ref.read(commandProvider.state).state = [
          ...ref.read(commandProvider.state).state,
          'Starting bootloader download...'
        ];
        req = await client.get(Uri.parse(
            'https://firmware.gatego.io/bootloaders/bootloader_dio_40m.bin'));
        bytes = req.bodyBytes;
        if (req.statusCode != 200) {
          ref.read(commandProvider.state).state = [
            'Error downloading file. Code ' +
                req.statusCode.toString() +
                '\n\nDetails: ' +
                req.reasonPhrase!
          ];
          return false;
        }
        ref.read(commandProvider.state).state = [
          ...ref.read(commandProvider.state).state,
          'Saving file...'
        ];
        file = File('$dir${Platform.pathSeparator}bootloader_dio_40m.bin');
        ref.read(commandProvider.state).state = [
          ...ref.read(commandProvider.state).state,
          'Saved in ${file.path}'
        ];
        await file.writeAsBytes(bytes);
        ref.read(commandProvider.state).state = [
          ...ref.read(commandProvider.state).state,
          'Starting partitions download...'
        ];
        req = await client.get(
            Uri.parse('https://firmware.gatego.io/bootloaders/partitions.bin'));
        bytes = req.bodyBytes;
        if (req.statusCode != 200) {
          ref.read(commandProvider.state).state = [
            'Error downloading file. Code ' +
                req.statusCode.toString() +
                '\n\nDetails: ' +
                req.reasonPhrase!
          ];
          return false;
        }
        ref.read(commandProvider.state).state = [
          ...ref.read(commandProvider.state).state,
          'Saving file...'
        ];
        file = File('$dir${Platform.pathSeparator}partitions.bin');
        ref.read(commandProvider.state).state = [
          ...ref.read(commandProvider.state).state,
          'Saved in ${file.path}'
        ];
        await file.writeAsBytes(bytes);
      } catch (e) {
        return false;
      }
      return true;
    },
    icon: HeroIcons.download,
    title: 'Download Files',
  ),
  ActionItem(
    doOnAction: (context, ref, commandProvider) async {
      ref.watch(commandProvider.state).state.add('Starting download...');
      try {
        var client = http.Client();
        var fileName = 'flasher';
        var url =
            'https://firmware.gatego.io/utils/${Platform.operatingSystem.toLowerCase()}/$fileName';
        if (Platform.isWindows) {
          url += '.exe';
          fileName += '.exe';
        }
        var req = await client.get(Uri.parse(url));
        var bytes = req.bodyBytes;
        if (req.statusCode != 200) {
          ref.read(commandProvider.state).state = [
            'Error downloading file. Code ' +
                req.statusCode.toString() +
                '\n\nDetails: ' +
                req.reasonPhrase!
          ];
          return false;
        }
        ref.read(commandProvider.state).state = [
          ...ref.read(commandProvider.state).state,
          'Saving file...'
        ];
        var dir = (await getApplicationSupportDirectory()).path;
        var file = File('$dir${Platform.pathSeparator}$fileName');
        ref.read(commandProvider.state).state = [
          ...ref.read(commandProvider.state).state,
          'Saved in ${file.path}'
        ];
        await file.writeAsBytes(bytes);
      } catch (e) {
        return false;
      }
      return true;
    },
    icon: HeroIcons.folderDownload,
    title: 'Download Tools',
  ),
  ActionItem(
    doOnAction: (context, ref, commandProvider) async {
      var dir = (await getApplicationSupportDirectory()).path;
      var file = File('$dir${Platform.pathSeparator}flasher').absolute.path;
      var serial = ref.watch(serialProvider.state).state;
      if (Platform.isWindows) {
        file += '.exe';
      }
      SerialPort(serial!).close();

      var controller = ShellLinesController();
      var shell = Shell(stdout: controller.sink, verbose: false);
      controller.stream.listen((event) {
        ref.read(commandProvider.state).state = [
          ...ref.read(commandProvider.state).state,
          event
        ];
        print(event);
      });
      try {
        await shell.run('"$file" erase_flash');
      } on ShellException catch (_) {
        shell.kill();
      }

      var result = ref
          .watch(commandProvider.state)
          .state
          .where((element) => element.contains('Chip erase completed'))
          .toList();

      shell.kill();
      if (result.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    },
    icon: HeroIcons.trash,
    title: 'Erase Chip',
  ),
  ActionItem(
    doOnAction: (context, ref, commandProvider) async {
      var dir = (await getApplicationSupportDirectory()).absolute.path;
      var file = File('$dir${Platform.pathSeparator}flasher').absolute.path;
      var serial = ref.watch(serialProvider.state).state;
      if (Platform.isWindows) {
        file += '.exe';
      }
      SerialPort(serial!).close();

      var controller = ShellLinesController();
      var shell = Shell(stdout: controller.sink, verbose: false);
      controller.stream.listen((event) {
        ref.read(commandProvider.state).state = [
          ...ref.read(commandProvider.state).state,
          event
        ];
        print(event);
      });
      try {
        await shell.run(
          '"$file" --chip esp32 --port $serial --baud 2000000 --before default_reset --after hard_reset write_flash -z --flash_mode dio --flash_freq 40m --flash_size detect 0x1000 '
          ' "${'$dir${Platform.pathSeparator}bootloader_dio_40m.bin'}"'
          ' 0x8000 "$dir${Platform.pathSeparator}partitions.bin"'
          ' 0xe000 "$dir${Platform.pathSeparator}boot_app0.bin" 0x10000 "$dir${Platform.pathSeparator}firmware.bin"',
        );
      } on ShellException catch (_) {
        shell.kill();
        return false;
      }

      var result = ref
          .watch(commandProvider.state)
          .state
          .where((element) => element.contains('Hash of data verified'))
          .toList();

      shell.kill();
      if (result.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    },
    icon: HeroIcons.upload,
    title: 'Install Firmware',
  ),
];
