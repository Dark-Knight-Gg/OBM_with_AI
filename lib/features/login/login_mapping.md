# Feature Mapping — login_screen

> **Feature:** `login_screen`
> **Date:** 2026-06-25
> **Status:** Done

---

## 1. INPUTS

### 1.1 Sources

| Source | Path |
|--------|------|
| Stitch HTML | `lib/features/login/login_design_stitch/code.html` |
| CSS YAML | `lib/features/login/login_design_stitch/DESIGN.md` |
| SRS | `lib/features/login/login_srs/OBM_login_srs.docx` |
| Postman Collection | `OBM > login` |

### 1.2 Postman API

| Field | Value |
|-------|-------|
| Name | `login` |
| Method | `POST` |
| URL | `http://10.168.6.37:9080/api/v1/auth/login` |
| Headers | `Content-Type: application/json`, `accept: */*` |
| Body | `{"email": "...", "password": "..."}` |

---

## 2. DESIGN → CODE MAPPING

### 2.1 HTML Structure → Flutter Widget

| HTML Section | Flutter Widget | Class |
|-------------|---------------|-------|
| `<main class="bg-login-gradient">` | `Container + LinearGradient` | `_LoginContent` |
| `.dot-pattern` overlay | `CustomPaint(_DotPatternPainter)` | `_DotPatternPainter` |
| Atmospheric blur orbs | `Positioned` + `Container` circles | `_LoginContent` |
| Brand section (`DAS` + tagline) | `Column + Text` | `_BrandSection` |
| Card `rounded-xl card-shadow` | `Container` with `BoxDecoration` | `_LoginCard` |
| Alert `bg-[#D1E7DD]` | `_AlertBanner` | `_AlertBanner` |
| Email input `type="email"` | `TextField` with `_EmailFieldState` | `_EmailField` |
| Password input `type="password"` | `TextField` with `_PasswordFieldState` | `_PasswordField` |
| Remember checkbox | `_RememberAccountRow` | `_RememberAccountRow` |
| Submit `btn-gradient` | `AnimatedContainer` gradient | `_SubmitButton` |
| Demo credentials block | `_DemoCredentials` | `_DemoCredentials` |
| Footer `<footer>` | `_Footer + _FooterLink` | `_Footer` |

### 2.2 Color Mapping

| HTML/CSS | Hex | ColorApp | Usage |
|----------|-----|----------|-------|
| `bg-login-gradient` | `#005f9e → #0078c7 → #35d4ff` | `color005F9E`, `color35D4FF` | Background gradient |
| `text-on-primary` | `#ffffff` | inline `Colors.white` | Brand title |
| `text-on-surface` | `#191c1e` | `color191C1E` | Card title, label |
| `text-on-surface-variant` | `#404751` | `color404751` | Subtitle, footer text |
| `text-primary` | `#005f9e` | `color005F9E` | Demo credentials text |
| `bg-surface` | `#f7f9fb` | `colorF7F9FB` | Input background |
| `border-outline-variant` | `#c0c7d3` | `colorC0C7D3` | Input border |
| `bg-[#D1E7DD]` | `#d1e7dd` | `colorD1E7DD` | Alert banner |
| `text-[#0f5132]` | `#0f5132` | `color0F5132` | Alert text/icon |
| `text-outline` | `#707882` | `color707882` | Input icons |
| `border-surface-variant` | `#e0e3e5` | `colorE0E3E5` | Demo credentials divider |

### 2.3 Typography Mapping

| HTML Class | CSS | Flutter |
|-----------|-----|---------|
| `font-headline-lg font-black` | 30px, w700, -0.01em | `fontSize: 24, w700` (Stitch mobile) |
| `font-label-bold` | 14px, w700 | `fontSize: 14, w700` |
| `font-body-md` | 14px, w400 | `fontSize: 14, w400` |
| `font-label-sm` | 12px, w500 | `fontSize: 12, w500` |
| `font-mono-sm` | 12px, JetBrains Mono | `fontFamily: 'JetBrains Mono', fontSize: 12` |

### 2.4 Icons

| HTML | Flutter |
|------|---------|
| `<span class="material-symbols-outlined">mail</span>` | `Icons.mail_outlined` |
| `<span class="material-symbols-outlined">lock</span>` | `Icons.lock_outlined` |
| `<span class="material-symbols-outlined">visibility</span>` | `Icons.visibility` |
| `<span class="material-symbols-outlined">check_circle</span>` | `Icons.check_circle` |
| `<span class="material-symbols-outlined">login</span>` | `Icons.login` |

---

## 3. API MAPPING

### 3.1 Request / Response

```dart
// Request
class LoginRequest {
  final String email;
  final String password;
  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}

// Response
class LoginResponse {
  final String? accessToken;
  final String? tokenType;
  final int? expiresIn;
  final UserInfoModel? user;
  factory LoginResponse.fromJson(Map<String, dynamic> json) => ...
}

class UserInfoModel {
  final int? id;
  final String? email;
  final String? fullName;
  final String? avatarUrl;
  final List<String>? roles;
}
```

---

## 4. STATE MANAGEMENT

```
LoginScreen (extends BasePageStatefulWidget)
 └── _LoginScreenState (extends BaseStatefulWidgetState<LoginScreen, LoginService, LoginProvider>)
 └── BodyLoginWidget (StatelessWidget)
     └── _LoginContent → _LoginCard → _EmailField / _PasswordField / _SubmitButton
 └── LoginProvider (extends BaseProvider<LoginService>)
     ├── emailController / passwordController / FocusNodes
     ├── isRememberAccount, isPasswordVisible, isProcessing
     ├── emailError, passwordError
     └── validateEmail(), validatePassword(), submitLogin()
 └── LoginService (extends BaseService)
     └── login(LoginRequest) → POST /api/v1/auth/login
```

---

## 5. i18n STRINGS

All strings already present in all 4 JSON files:

| Key | Vietnamese | English |
|-----|-----------|---------|
| `loginTitle` | Đăng nhập | Sign in |
| `loginEmailLabel` | Email | Email |
| `loginEmailHint` | email@ttdas.vn | email@ttdas.vn |
| `loginPasswordLabel` | Mật khẩu | Password |
| `loginPasswordHint` | Nhập mật khẩu | Enter password |
| `loginRememberAccount` | Ghi nhớ tài khoản | Remember account |
| `loginButton` | Đăng nhập | Sign in |
| `loginDemoAccount` | Tài khoản demo: | Demo account: |
| `loginDemoCredentials` | admin@ttdas.vn / admin123 | admin@ttdas.vn / admin123 |
| `loginFooterSystem` | © 2024 DAS - Hệ thống... | © 2024 DAS - Business... |
| `logoutMessage` | Bạn đã đăng xuất. | You have been logged out. |
| `hoTro` | Hỗ trợ | Support |
| `chinhSachBaoMat` | Chính sách bảo mật | Privacy Policy |
| `brandName` | DAS | DAS |
| `brandTagline` | Đồng hành kiến tạo hành chính số | Digitalizing Administration Together |

---

## 6. ROUTE

| Route | Path | Screen |
|-------|------|--------|
| `/login` | `RouteGenerator.login` | `LoginScreen` (wrapped in `MultiProvider`) |

---

## 7. FILE STRUCTURE

```
lib/features/login/
├── login_screen.dart              ← Screen entry
├── login_mapping.md               ← This file
├── DEVELOPMENT_STATUS.md
├── component/
│   ├── login_provider.dart       ← LoginProvider
│   └── login_service.dart       ← LoginService
├── model/
│   └── login_model.dart         ← LoginRequest, LoginResponse, UserInfoModel
└── widget/
    └── body_login_widget.dart   ← Full UI (StatelessWidget)
```
