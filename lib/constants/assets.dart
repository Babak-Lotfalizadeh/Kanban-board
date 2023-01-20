enum Assets {
  darkLightSwitch,
  userMan,
}

extension AssetsValue on Assets {
  String get value {
    switch (this) {
      case Assets.darkLightSwitch:
        return "assets/rive/dark_light_switch.riv";
      case Assets.userMan:
        return "assets/image/man_user.svg";
    }
  }
}
