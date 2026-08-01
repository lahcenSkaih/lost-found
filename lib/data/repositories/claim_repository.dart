
import '../../core/constants/app_constants.dart';
import '../../core/services/firestore_service.dart';
import '../models/claim_model.dart';

class ClaimRepository {
  final FirestoreService _fs = FirestoreService();

  Future<String> submitClaim(ClaimModel claim) async {
    final ref = await _fs.add(AppConstants.claimsCollection, claim.toMap());
    return ref.id;
  }

  Future<List<ClaimModel>> getClaimsForItem(String itemId) async {
    final snapshot = await _fs
        .collection(AppConstants.claimsCollection)
        .where('itemId', isEqualTo: itemId)
        .get();
    return snapshot.docs
        .map((d) => ClaimModel.fromMap(d.id, d.data()))
        .toList();
  }

  Future<void> updateClaimStatus(String claimId, String status) {
    return _fs.update(AppConstants.claimsCollection, claimId, {'status': status});
  }
}
