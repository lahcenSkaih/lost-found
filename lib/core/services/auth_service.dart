import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/user_repository.dart';

/// Global auth state. Put once at app startup with Get.put(permanent: true)
/// and accessed anywhere via Get.find<AuthService>().
class AuthService extends GetxService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final UserRepository _userRepository = UserRepository();

  final Rxn<UserModel> currentUser = Rxn<UserModel>();
  String? _verificationId;

  bool get isLoggedIn => _firebaseAuth.currentUser != null;

  @override
  void onInit() {
    super.onInit();
    _firebaseAuth.authStateChanges().listen((user) async {
      if (user != null) {
        currentUser.value = await _userRepository.getUser(user.uid);
      } else {
        currentUser.value = null;
      }
    });
  }

  /// Step 1: send an OTP to the given phone number (e.g. "+212600000000").
  Future<void> sendOtp({
    required String phoneNumber,
    required void Function(String verificationId) onCodeSent,
    required void Function(String error) onError,
  }) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _firebaseAuth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        onError(e.message ?? 'Verification failed');
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  /// Step 2: confirm the OTP code the user typed in.
  // Future<void> verifyOtp({
  //   required String smsCode,
  //   required String name,
  //   required String city,
  // }) async {
  //   if (_verificationId == null) {
  //     throw Exception('No verification in progress. Request a new code.');
  //   }
  //   final credential = PhoneAuthProvider.credential(
  //     verificationId: _verificationId!,
  //     smsCode: smsCode,
  //   );
  //   final result = await _firebaseAuth.signInWithCredential(credential);
  //   final uid = result.user!.uid;
  //
  //   // Create the user profile the first time they sign in.
  //   final existing = await _userRepository.getUser(uid);
  //   if (existing == null) {
  //     final newUser = UserModel(
  //       id: uid,
  //       name: name,
  //       phone: result.user!.phoneNumber ?? '',
  //       city: city,
  //       rating: 0,
  //       createdAt: DateTime.now(),
  //     );
  //     await _userRepository.createUser(newUser);
  //     currentUser.value = newUser;
  //   } else {
  //     currentUser.value = existing;
  //   }
  // }
  Future<void> verifyOtp({
    required String smsCode,
    required String name,
    required String city,
  }) async {
    if (_verificationId == null) {
      throw Exception('No verification in progress. Request a new code.');
    }

    final credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: smsCode,
    );

    final UserCredential result;
    try {
      result = await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-verification-code':
          throw Exception('Incorrect code. Please check and try again.');
        case 'session-expired':
          throw Exception('This code has expired. Request a new one.');
        default:
          throw Exception('Verification failed. Please try again.');
      }
    }

    final uid = result.user?.uid;
    if (uid == null) {
      throw Exception('Sign-in succeeded but no user was returned.');
    }

    // Retry Firestore reads/writes on transient "unavailable" errors.
    UserModel? existing;
    try {
      existing = await _getUserWithRetry(uid);
    } catch (e) {
      // User is authenticated but we couldn't load/create their profile.
      // Let them retry without forcing a fresh OTP.
      throw Exception(
        'Signed in, but could not load your profile. Check your connection and try again.',
      );
    }

    if (existing == null) {
      final newUser = UserModel(
        id: uid,
        name: name,
        phone: result.user!.phoneNumber ?? '',
        city: city,
        rating: 0,
        createdAt: DateTime.now(),
      );
      await _createUserWithRetry(newUser);
      currentUser.value = newUser;
    } else {
      currentUser.value = existing;
    }
  }

  Future<UserModel?> _getUserWithRetry(String uid, {int attempts = 3}) async {
    for (var i = 0; i < attempts; i++) {
      try {
        return await _userRepository.getUser(uid);
      } on FirebaseException catch (e) {
        if (e.code != 'unavailable' || i == attempts - 1) rethrow;
        await Future.delayed(Duration(milliseconds: 500 * (i + 1)));
      }
    }
    return null;
  }

  Future<void> _createUserWithRetry(UserModel user, {int attempts = 3}) async {
    for (var i = 0; i < attempts; i++) {
      try {
        await _userRepository.createUser(user);
        return;
      } on FirebaseException catch (e) {
        if (e.code != 'unavailable' || i == attempts - 1) rethrow;
        await Future.delayed(Duration(milliseconds: 500 * (i + 1)));
      }
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    currentUser.value = null;
  }
}
