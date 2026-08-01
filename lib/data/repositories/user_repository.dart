import '../../core/services/firestore_service.dart';
import '../../core/constants/app_constants.dart';
import '../models/user_model.dart';

class UserRepository {
  final FirestoreService _fs = FirestoreService();

  Future<UserModel?> getUser(String uid) async {
    final doc = await _fs.getById(AppConstants.usersCollection, uid);
    if (!doc.exists) return null;
    return UserModel.fromMap(doc.id, doc.data()!);
  }

  Future<void> createUser(UserModel user) {
    return _fs.set(AppConstants.usersCollection, user.id, user.toMap());
  }

  Future<void> updateRating(String uid, double newRating) {
    return _fs.update(AppConstants.usersCollection, uid, {'rating': newRating});
  }
}

