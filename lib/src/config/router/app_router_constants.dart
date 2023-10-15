class _AppRoutModel {
  final String name;
  final String path;

  _AppRoutModel({required this.name, required this.path});
}

class AppRoutConstants {
  static final home = _AppRoutModel(name: 'home', path: '/');
  static final destinationDetails =
      _AppRoutModel(name: 'destinationDetails', path: '/destinationDetails');
  static final wishlistView =
      _AppRoutModel(name: 'wishlistView', path: '/wishlistView');
}
