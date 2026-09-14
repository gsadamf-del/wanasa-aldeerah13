# وناسة الديرة V13 — Flutter Source
نسخة Flutter V13 محسّنة فوق V12، مهيأة للبناء من هاتف Android عبر GitHub Actions.

## أهم ما في V13
- Arabic RTL / Material 3
- Home dashboard
- City selector
- Categories
- Product cards مع حالة الصلاحية
- Cart foundation
- Orders foundation
- Profile
- API client
- Token storage
- GitHub Actions لبناء APK
- اختبارات Flutter

## بناء APK محلياً
```bash
cd mobile
flutter create .
flutter pub get
flutter analyze
flutter test
flutter build apk --release
```

## البناء من الهاتف
ارفع المشروع إلى GitHub ثم شغّل:
Actions → Build V13 Android APK → Run workflow

الناتج سيكون Artifact باسم:
wanasa-aldeerah-v13-apk

ملاحظة: هذه حزمة مصدر وليست APK موقّعاً جاهزاً.
