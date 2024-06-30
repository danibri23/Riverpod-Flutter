import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'states_providers.g.dart';

@Riverpod(keepAlive: true)
class Counter extends _$Counter {
  @override
  int build() {
    return 0;
  }

  void increment() {
    state++;
  }
}

@riverpod
class DarkMode extends _$DarkMode {
  @override
  bool build() {
    return false;
  }

  void toggleDarkMode() {
    state = !state;
  }
}

@Riverpod(keepAlive: true)
class Username extends _$Username {
  @override
  String build() {
    return "Rogelio Miraflores";
  }

  void changeUsername(String name) {
    state = name;
  }
}
