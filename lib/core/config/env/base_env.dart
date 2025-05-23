abstract class BaseEnv {
  String get baseUrl;
}

enum Flavor {
  prod('Doi Prod'),
  dev('Doi Dev'),
  staging('Doi Staging');

  const Flavor(this.title);
  final String title;
}

class F {
  static Flavor appFlavor = Flavor.dev;
}
