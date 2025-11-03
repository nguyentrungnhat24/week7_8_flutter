Nguyễn Trung Nhật 22IT206

# 🛒 LoginApp - Flutter E-commerce Authentication

Ứng dụng Flutter với hệ thống đăng nhập/đăng ký hoàn chỉnh sử dụng **Firebase Authentication** và **BLoC Pattern**.

## ✨ Tính năng

### 🔐 Authentication
- ✅ Đăng ký tài khoản mới với Email/Password
- ✅ Đăng nhập với Email/Password
- ✅ Validation form (email format, password strength)
- ✅ Hiển thị lỗi từ Firebase bằng tiếng Việt
- ✅ Loading state khi xử lý
- ✅ Chuyển màn hình tự động sau khi đăng nhập thành công

### 🏗️ Kiến trúc
- ✅ **BLoC Pattern** (Business Logic Component)
- ✅ **Repository Pattern** để tách biệt logic và UI
- ✅ **State Management** với flutter_bloc
- ✅ Clean Architecture với separation of concerns

### 🎨 UI/UX
- ✅ Material Design
- ✅ Responsive layout
- ✅ Form validation realtime
- ✅ Password visibility toggle
- ✅ Loading indicators
- ✅ Error messages

## 🚀 Cài đặt

### Yêu cầu hệ thống
- Flutter SDK >= 3.9.0
- Dart SDK >= 3.9.0
- Android Studio / VS Code
- Firebase Account (miễn phí)

### Bước 1: Clone project
```bash
git clone <repository-url>
cd LoginApp
```

### Bước 2: Cài đặt dependencies
```bash
flutter pub get
```

### Bước 3: Cấu hình Firebase
Xem hướng dẫn chi tiết trong file [FIREBASE_SETUP_GUIDE.md](FIREBASE_SETUP_GUIDE.md)

**Tóm tắt:**
1. Tạo Firebase project tại [Firebase Console](https://console.firebase.google.com/)
2. Thêm app cho các platforms:
   - **Android**: Download `google-services.json` → đặt vào `android/app/`
   - **iOS**: Download `GoogleService-Info.plist` → add vào Xcode project
   - **Web**: Copy Firebase config → cập nhật `lib/firebase_options.dart`
3. Kích hoạt **Email/Password** trong **Authentication → Sign-in method**

### Bước 4: Chạy app
```bash
# Android
flutter run

# iOS (chỉ trên macOS)
flutter run -d ios

# Web
flutter run -d chrome

# Linux
flutter run -d linux
```

## 📁 Cấu trúc Project

```
lib/
├── main.dart                          # Entry point, khởi tạo Firebase
├── firebase_options.dart              # Firebase config cho các platforms
├── data/
│   └── data.dart                      # Mock data cho products/categories
└── src/
    ├── blocs/
    │   ├── login_bloc.dart           # BLoC xử lý đăng nhập
    │   ├── signup_bloc.dart          # BLoC xử lý đăng ký
    │   └── homepage_bloc.dart        # BLoC cho homepage
    ├── repositories/
    │   └── auth_repository.dart      # Repository Firebase Auth
    ├── resources/
    │   ├── signIn.dart               # Màn hình đăng nhập
    │   ├── signUp.dart               # Màn hình đăng ký
    │   ├── home_screen.dart          # Màn hình chính
    │   ├── account_screen.dart       # Màn hình tài khoản
    │   ├── cart_screen.dart          # Màn hình giỏ hàng
    │   ├── favourite_screen.dart     # Màn hình yêu thích
    │   └── ProductDetail.dart        # Màn hình chi tiết sản phẩm
    ├── validators/
    │   └── validation.dart           # Validation helpers
    └── widgets/
        └── custom_bottom_bar.dart    # Bottom navigation bar
```

## 🔧 Dependencies chính

```yaml
dependencies:
  flutter_bloc: ^8.1.6      # State management
  equatable: ^2.0.5         # Value equality
  firebase_core: ^3.8.1     # Firebase core
  firebase_auth: ^5.3.3     # Firebase Authentication
  cupertino_icons: ^1.0.8   # iOS icons
```

## 🎯 Sử dụng

### Đăng ký tài khoản mới
1. Mở app → Click "Sign Up"
2. Điền thông tin:
   - First Name
   - Last Name
   - Username
   - Email (phải đúng format)
   - Password (ít nhất 6 ký tự, có chữ hoa, chữ thường, số)
3. Click "Sign Up"
4. User được tạo trên Firebase và tự động chuyển về màn hình đăng nhập

### Đăng nhập
1. Nhập Email và Password đã đăng ký
2. Click "Login"
3. Chuyển vào màn hình Home khi thành công

### Kiểm tra users đã đăng ký
Firebase Console → Authentication → Users

## 🛠️ Troubleshooting

### Màn hình trắng khi chạy Web
**Nguyên nhân:** Chưa cấu hình Firebase cho Web

**Giải pháp:**
1. Mở `lib/firebase_options.dart`
2. Thay các giá trị `YOUR_*` bằng config từ Firebase Console
3. Chạy lại `flutter run -d chrome`

### CMake Error khi build
```bash
flutter clean
rm -rf build/
flutter pub get
flutter run
```

### "FirebaseError: Firebase: Error (auth/invalid-api-key)"
Kiểm tra `firebase_options.dart` đã điền đúng API key chưa

### "Default FirebaseApp is not initialized"
Đảm bảo đã gọi `Firebase.initializeApp()` trong `main.dart`

## 📚 Tài liệu tham khảo

- [Flutter Documentation](https://docs.flutter.dev/)
- [Firebase Authentication](https://firebase.google.com/docs/auth)
- [BLoC Pattern](https://bloclibrary.dev/)
- [Flutter BLoC Package](https://pub.dev/packages/flutter_bloc)

## 🤝 Contributing

Contributions, issues, và feature requests đều được chào đón!

## 📝 License

This project is [MIT](LICENSE) licensed.

## 👨‍💻 Author

**Trung Nhat**
- GitHub: [@nguyentrungnhat24](https://github.com/nguyentrungnhat24)

## 📸 Screenshots

_Coming soon..._

---

**Lưu ý:** Đây là project học tập. Trong môi trường production, cần thêm:
- Email verification
- Password reset
- Remember me functionality
- Biometric authentication
- Token refresh
- Error logging
- Analytics
