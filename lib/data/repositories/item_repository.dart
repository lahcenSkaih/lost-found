
import '../../core/constants/app_constants.dart';
import '../../core/constants/item_categories.dart';
import '../../core/services/firestore_service.dart';
import '../models/item_model.dart';

class ItemRepository {
  final FirestoreService _fs = FirestoreService();

  Future<String> createItem(ItemModel item) async {
    final ref = await _fs.add(AppConstants.itemsCollection, item.toMap());
    return ref.id;
  }

  /// Basic feed query: filter by city and, optionally, category.
  /// For a bigger dataset you'd move this to a proper geo-query
  /// (e.g. geoflutterfire2) instead of a flat "city" string match.
  Future<List<ItemModel>> getItemsByCityAndCategory({
    required String city,
    ItemCategory? category,
    int limit = AppConstants.feedPageSize,
  }) async {
    var query = _fs
        .collection(AppConstants.itemsCollection)
        .where('city', isEqualTo: city)
        .orderBy('createdAt', descending: true)
        .limit(limit);

    if (category != null) {
      query = query.where('category', isEqualTo: category.name);
    }

    final snapshot = await query.get();
    return snapshot.docs
        .map((d) => ItemModel.fromMap(d.id, d.data()))
        .toList();
  }

  Future<ItemModel?> getItemById(String itemId) async {
    final doc = await _fs.getById(AppConstants.itemsCollection, itemId);
    if (!doc.exists) return null;
    return ItemModel.fromMap(doc.id, doc.data()!);
  }

  Future<void> updateStatus(String itemId, String status) {
    return _fs.update(AppConstants.itemsCollection, itemId, {'status': status});
  }
}
