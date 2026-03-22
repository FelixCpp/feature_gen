import 'dart:io';

import 'package:file/memory.dart';

MemoryFileSystem getTestFileSystem() {
  final style = () {
    if (Platform.isWindows) return FileSystemStyle.windows;
    return FileSystemStyle.posix;
  }();

  return MemoryFileSystem.test(style: style);
}
