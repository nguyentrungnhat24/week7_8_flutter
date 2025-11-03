# Hướng dẫn Cài đặt Firebase cho LoginApp

## Bước 1: Tạo Firebase Project

1. Truy cập [Firebase Console](https://console.firebase.google.com/)
2. Click **"Add project"** (Thêm dự án)
3. Đặt tên project (vd: "LoginApp")
4. Bật/tắt Google Analytics (tùy chọn)
5. Click **"Create project"**

## Bước 2: Cấu hình Android

### 2.1. Thêm Android App vào Firebase

1. Trong Firebase Console, click biểu tượng Android
2. Điền **Android package name**: Tìm trong `android/app/build.gradle`
   ```
   applicationId "com.example.fl_week01"  // Đây là package name của bạn
   ```
3. Nhập **App nickname** (tùy chọn): "LoginApp Android"
4. Click **"Register app"**

### 2.2. Tải xuống google-services.json

1. Click **"Download google-services.json"**
2. Copy file `google-services.json` vào thư mục:
   ```
   LoginApp/android/app/google-services.json
   ```

### 2.3. Cập nhật build.gradle

**File: `android/build.gradle`** (project-level)
```gradle
buildscript {
    dependencies {
        // Thêm dòng này
        classpath 'com.google.gms:google-services:4.4.0'
    }
}
```

**File: `android/app/build.gradle`** (app-level)
```gradle
// Thêm ở cuối file
apply plugin: 'com.google.gms.google-services'
```

## Bước 3: Cấu hình iOS

### 3.1. Thêm iOS App vào Firebase

1. Trong Firebase Console, click biểu tượng iOS
2. Điền **iOS bundle ID**: Tìm trong `ios/Runner.xcodeproj/project.pbxproj`
   Hoặc mở Xcode → chọn Runner → General → Bundle Identifier
3. Nhập **App nickname** (tùy chọn): "LoginApp iOS"
4. Click **"Register app"**

### 3.2. Tải xuống GoogleService-Info.plist

1. Click **"Download GoogleService-Info.plist"**
2. Mở Xcode
3. Kéo thả file `GoogleService-Info.plist` vào thư mục `Runner` trong Xcode
4. Đảm bảo chọn **"Copy items if needed"**

## Bước 4: Kích hoạt Firebase Authentication

1. Trong Firebase Console, vào **"Build" → "Authentication"**
2. Click **"Get started"**
3. Chọn tab **"Sign-in method"**
4. Kích hoạt **"Email/Password"**
   - Click vào "Email/Password"
   - Bật toggle **"Enable"**
   - Click **"Save"**

## Bước 5: Cài đặt Dependencies

Chạy lệnh:
```bash
cd /home/trungnhat24/Documents/HocFlutter/LoginApp
flutter pub get
```

## Bước 6: Clean và Build lại

```bash
flutter clean
flutter pub get
```

### Chạy trên Android:
```bash
flutter run -d <android-device-id>
```

### Chạy trên iOS (chỉ trên macOS):
```bash
cd ios
pod install
cd ..
flutter run -d <ios-device-id>
```

## Bước 7: Kiểm tra

1. Mở app và đăng ký tài khoản mới
2. Kiểm tra Firebase Console → Authentication → Users
3. Bạn sẽ thấy user vừa đăng ký hiện ra

## Lưu ý quan trọng

### 🔴 Lỗi thường gặp:

**1. "A Firebase App named '[DEFAULT]' already exists"**
- Nguyên nhân: `Firebase.initializeApp()` được gọi nhiều lần
- Giải pháp: Đã xử lý trong code bằng `WidgetsFlutterBinding.ensureInitialized()`

**2. "Please register the file via the AppDelegate"** (iOS)
- Nguyên nhân: Chưa add `GoogleService-Info.plist` vào Xcode
- Giải pháp: Thêm file qua Xcode, không copy thủ công vào Finder

**3. "Default FirebaseApp is not initialized"**
- Nguyên nhân: Chưa gọi `Firebase.initializeApp()`
- Giải pháp: Đã xử lý trong `lib/main.dart`

**4. CMake Error khi build**
- Giải pháp: 
  ```bash
  flutter clean
  rm -rf build/
  flutter pub get
  flutter run
  ```

### 🟢 Các tính năng đã triển khai:

✅ Đăng ký với Email/Password  
✅ Đăng nhập với Email/Password  
✅ Validation email và password  
✅ Hiển thị lỗi từ Firebase  
✅ BLoC pattern với Repository  
✅ Chuyển màn hình sau khi đăng nhập thành công

### 📦 Các file đã tạo/sửa:

- ✅ `lib/main.dart` - Khởi tạo Firebase
- ✅ `lib/src/repositories/auth_repository.dart` - Repository xử lý Firebase Auth
- ✅ `lib/src/blocs/login_bloc.dart` - BLoC cho đăng nhập
- ✅ `lib/src/blocs/signup_bloc.dart` - BLoC cho đăng ký
- ✅ `lib/src/resources/signIn.dart` - UI đăng nhập
- ✅ `lib/src/resources/signUp.dart` - UI đăng ký
- ✅ `pubspec.yaml` - Thêm dependencies

## Bước tiếp theo (Tùy chọn)

1. **Thêm Reset Password**: Sử dụng `authRepository.sendPasswordResetEmail()`
2. **Lưu trạng thái đăng nhập**: Dùng `authRepository.authStateChanges`
3. **Google Sign-In**: Thêm plugin `google_sign_in`
4. **Facebook Login**: Thêm plugin `flutter_facebook_auth`
5. **Email Verification**: Gọi `user.sendEmailVerification()`

## Liên hệ & Hỗ trợ

Nếu gặp vấn đề, check:
- Firebase Console → Project Settings
- `android/app/google-services.json` đã tồn tại
- `ios/Runner/GoogleService-Info.plist` đã được add vào Xcode
- Dependencies đã được cài đúng trong `pubspec.yaml`
