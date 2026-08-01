class AppConstants {
  AppConstants._();

  static const appName = 'Lost & Found';

  // Firestore collection names
  static const usersCollection = 'users';
  static const itemsCollection = 'items';
  static const claimsCollection = 'claims';
  static const chatsCollection = 'chats';

  // Storage folders
  static const itemImagesFolder = 'item_images';

  // Pagination
  static const feedPageSize = 20;

  // Matching radius in km used for "nearby lost item" notifications
  static const nearbyRadiusKm = 15.0;
}
