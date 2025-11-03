import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository({FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  /// Đăng ký người dùng mới với email và password
  Future<User?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Đăng nhập với email và password
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Đăng xuất
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  /// Lấy user hiện tại
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  /// Stream theo dõi trạng thái authentication
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// Gửi email reset password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Xử lý các lỗi Firebase Auth và chuyển thành thông báo dễ hiểu
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'Mật khẩu quá yếu. Vui lòng chọn mật khẩu mạnh hơn.';
      case 'email-already-in-use':
        return 'Email này đã được sử dụng. Vui lòng dùng email khác.';
      case 'invalid-email':
        return 'Email không hợp lệ. Vui lòng kiểm tra lại.';
      case 'user-not-found':
        return 'Không tìm thấy tài khoản với email này.';
      case 'wrong-password':
        return 'Mật khẩu không đúng. Vui lòng thử lại.';
      case 'user-disabled':
        return 'Tài khoản này đã bị vô hiệu hóa.';
      case 'too-many-requests':
        return 'Quá nhiều lần thử. Vui lòng thử lại sau.';
      case 'operation-not-allowed':
        return 'Phương thức đăng nhập này chưa được kích hoạt.';
      case 'network-request-failed':
        return 'Lỗi kết nối mạng. Vui lòng kiểm tra internet.';
      default:
        return 'Đã xảy ra lỗi: ${e.message ?? e.code}';
    }
  }
}
