import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:obm_gen_with_ai/core/constants/app_strings.dart';
import 'package:obm_gen_with_ai/core/constants/color_app.dart';
import 'package:obm_gen_with_ai/features/login/component/login_provider.dart';

class BodyLoginWidget extends StatelessWidget {
  const BodyLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<LoginProvider>();
    return _LoginContent(provider: provider);
  }
}

class _LoginContent extends StatelessWidget {
  final LoginProvider provider;

  const _LoginContent({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF005f9e),
            Color(0xFF0078c7),
            Color(0xFF35D4FF),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(painter: _DotPatternPainter()),
          ),
          // Atmospheric blur orbs (from Stitch design)
          Positioned(
            top: -120,
            right: -120,
            child: Container(
              width: 256,
              height: 256,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -160,
            left: -160,
            child: Container(
              width: 384,
              height: 384,
              decoration: BoxDecoration(
                color: const Color(0xFF0078c7).withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  _BrandSection(),
                  const SizedBox(height: 24),
                  _LoginCard(provider: provider),
                  const SizedBox(height: 24),
                  _Footer(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BrandSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.brandName,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 48,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.96,
            height: 1.2,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppStrings.brandTagline,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 12,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }
}

class _LoginCard extends StatelessWidget {
  final LoginProvider provider;

  const _LoginCard({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 480),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 40,
            offset: Offset(0, 10),
          ),
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              AppStrings.loginTitle,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 24,
                fontWeight: FontWeight.w700,
                height: 1.3,
                color: ColorApp.color191C1E,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              AppStrings.loginSubtitle,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.5,
                color: ColorApp.color404751,
              ),
            ),
          ),
          const SizedBox(height: 24),
          _AlertBanner(
            message: AppStrings.logoutMessage,
            icon: Icons.check_circle,
            iconColor: ColorApp.color0F5132,
            backgroundColor: ColorApp.colorD1E7DD,
            textColor: ColorApp.color0F5132,
          ),
          const SizedBox(height: 24),
          _EmailField(provider: provider),
          const SizedBox(height: 24),
          _PasswordField(),
          const SizedBox(height: 4),
          _RememberAccountRow(),
          const SizedBox(height: 24),
          _SubmitButton(provider: provider),
          const SizedBox(height: 24),
          const _DemoCredentials(),
        ],
      ),
    );
  }
}

class _AlertBanner extends StatelessWidget {
  final String message;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final Color textColor;

  const _AlertBanner({
    required this.message,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: iconColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                height: 1.2,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmailField extends StatefulWidget {
  final LoginProvider provider;

  const _EmailField({required this.provider});

  @override
  State<_EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<_EmailField> {
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    widget.provider.emailFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = widget.provider.emailFocusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    widget.provider.emailFocusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  Color get _borderColor {
    if (widget.provider.emailError != null) {
      return ColorApp.colorBA1A1A;
    }
    if (_isFocused) {
      return ColorApp.color005F9E;
    }
    return ColorApp.colorC0C7D3;
  }

  Color get _iconColor {
    if (_isFocused) {
      return ColorApp.color005F9E;
    }
    return ColorApp.color707882;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.loginEmailLabel,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            height: 1.2,
            color: ColorApp.color191C1E,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: ColorApp.colorF7F9FB,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _borderColor, width: 1),
          ),
          child: TextField(
            controller: widget.provider.emailController,
            focusNode: widget.provider.emailFocusNode,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.5,
              color: ColorApp.color191C1E,
            ),
            decoration: InputDecoration(
              hintText: AppStrings.loginEmailHint,
              hintStyle: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: ColorApp.colorADB5BE,
              ),
              prefixIcon: Icon(
                Icons.mail_outlined,
                size: 20,
                color: _iconColor,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
            onChanged: (_) {
              if (widget.provider.emailError != null) {
                widget.provider.clearErrors();
              }
            },
          ),
        ),
        if (widget.provider.emailError != null) ...[
          const SizedBox(height: 6),
          Text(
            widget.provider.emailError!,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: ColorApp.colorBA1A1A,
            ),
          ),
        ],
      ],
    );
  }
}

class _PasswordField extends StatefulWidget {
  const _PasswordField();

  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  bool _isFocused = false;
  late final FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode =
        context.read<LoginProvider>().passwordFocusNode;
    _passwordFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (mounted) {
      setState(() {
        _isFocused = _passwordFocusNode.hasFocus;
      });
    }
  }

  @override
  void dispose() {
    _passwordFocusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  Color _borderColor(BuildContext context) {
    final provider = context.watch<LoginProvider>();
    if (provider.passwordError != null) {
      return ColorApp.colorBA1A1A;
    }
    if (_isFocused) {
      return ColorApp.color005F9E;
    }
    return ColorApp.colorC0C7D3;
  }

  Color _iconColor(BuildContext context) {
    if (_isFocused) {
      return ColorApp.color005F9E;
    }
    return ColorApp.color707882;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LoginProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.loginPasswordLabel,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            height: 1.2,
            color: ColorApp.color191C1E,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: ColorApp.colorF7F9FB,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _borderColor(context), width: 1),
          ),
          child: TextField(
            controller: provider.passwordController,
            focusNode: _passwordFocusNode,
            obscureText: !provider.isPasswordVisible,
            textInputAction: TextInputAction.done,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.5,
              color: ColorApp.color191C1E,
            ),
            decoration: InputDecoration(
              hintText: AppStrings.loginPasswordHint,
              hintStyle: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: ColorApp.colorADB5BE,
              ),
              prefixIcon: Icon(
                Icons.lock_outlined,
                size: 20,
                color: _iconColor(context),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  provider.isPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility,
                  size: 20,
                  color: ColorApp.color707882,
                ),
                onPressed: () {
                  context.read<LoginProvider>().togglePasswordVisibility();
                },
              ),
            ),
            onChanged: (_) {
              if (provider.passwordError != null) {
                provider.clearErrors();
              }
            },
            onSubmitted: (_) {
              context.read<LoginProvider>().submitLogin();
            },
          ),
        ),
        if (provider.passwordError != null) ...[
          const SizedBox(height: 6),
          Text(
            provider.passwordError!,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: ColorApp.colorBA1A1A,
            ),
          ),
        ],
      ],
    );
  }
}

class _RememberAccountRow extends StatelessWidget {
  const _RememberAccountRow();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LoginProvider>();
    return InkWell(
      onTap: provider.toggleRememberAccount,
      borderRadius: BorderRadius.circular(4),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: Checkbox(
              value: provider.isRememberAccount,
              onChanged: (_) => provider.toggleRememberAccount(),
              activeColor: ColorApp.color005F9E,
              side: const BorderSide(
                color: ColorApp.colorC0C7D3,
                width: 1.5,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            AppStrings.loginRememberAccount,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.5,
              color: ColorApp.color404751,
            ),
          ),
        ],
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final LoginProvider provider;

  const _SubmitButton({required this.provider});

  @override
  Widget build(BuildContext context) {
    final isProcessing = provider.isProcessing;
    return GestureDetector(
      onTap: isProcessing ? null : () => provider.submitLogin(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [ColorApp.color005F9E, ColorApp.color35D4FF],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: isProcessing
              ? []
              : [
                  BoxShadow(
                    color: ColorApp.color005F9E.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: isProcessing
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    AppStrings.loginProcessing,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.login,
                    size: 20,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    AppStrings.loginButton,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _DemoCredentials extends StatelessWidget {
  const _DemoCredentials();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(color: ColorApp.colorE0E3E5),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            children: [
              Text(
                AppStrings.loginDemoAccount,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                  color: ColorApp.color404751,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: ColorApp.colorF2F4F6,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  AppStrings.loginDemoCredentials,
                  style: const TextStyle(
                    fontFamily: 'JetBrains Mono',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                    color: ColorApp.color005F9E,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.loginFooterSystem,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.5,
            color: Colors.white.withValues(alpha: 0.6),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _FooterLink(text: AppStrings.hoTro),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                '|',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.2),
                ),
              ),
            ),
            _FooterLink(text: AppStrings.chinhSachBaoMat),
          ],
        ),
      ],
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String text;

  const _FooterLink({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Inter',
        fontSize: 12,
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: Colors.white.withValues(alpha: 0.8),
      ),
    );
  }
}

class _DotPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;

    const dotRadius = 1.0;
    const spacing = 20.0;

    final cols = (size.width / spacing).ceil();
    final rows = (size.height / spacing).ceil();

    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        canvas.drawCircle(
          Offset(col * spacing, row * spacing),
          dotRadius,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
