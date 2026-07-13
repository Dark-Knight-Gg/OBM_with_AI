import 'package:flutter/material.dart';
import 'package:obm_gen_with_ai/core/constants/app_strings.dart';
import 'package:obm_gen_with_ai/core/constants/color_app.dart';

class AppMainBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final VoidCallback? onMenuTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;
  final bool hasUnreadNotification;

  const AppMainBar({
    super.key,
    this.title,
    this.onMenuTap,
    this.onNotificationTap,
    this.onProfileTap,
    this.hasUnreadNotification = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.8),
          border: Border(bottom: BorderSide(color: ColorApp.colorC0C7D3.withValues(alpha: 0.3))),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              children: [
                _ActionButton(icon: Icons.menu, onTap: onMenuTap ?? () => Scaffold.of(context).openDrawer()),
                const SizedBox(width: 12),
                Expanded(child: title != null ? _TitleText(title: title!) : const _BrandLogo()),
                _ActionButton(
                  icon: Icons.notifications_outlined,
                  hasUnread: hasUnreadNotification,
                  onTap: onNotificationTap ?? () {},
                ),
                const SizedBox(width: 8),
                const _ProfileAvatar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool hasUnread;

  const _ActionButton({required this.icon, required this.onTap, this.hasUnread = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, size: 24, color: ColorApp.color191C1E),
          ),
          if (hasUnread)
            Positioned(
              top: 6,
              right: 6,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: ColorApp.colorF04438,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _TitleText extends StatelessWidget {
  final String title;

  const _TitleText({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontFamily: 'Inter', fontSize: 18, fontWeight: FontWeight.w700, color: ColorApp.color191C1E),
    );
  }
}

class _BrandLogo extends StatelessWidget {
  const _BrandLogo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppStrings.dasObm,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.02,
            color: ColorApp.color005F9E,
          ),
        ),
        SizedBox(
          width: 200,
          child: Text(
            AppStrings.heThongQuanTriCoHoiDieuHanhKinhDoanh.toUpperCase(),
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 10,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.05,
              color: ColorApp.color404751,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: ColorApp.colorC0C7D3.withValues(alpha: 0.3)),
        boxShadow: [BoxShadow(color: ColorApp.colorD1E4FF.withValues(alpha: 0.3), blurRadius: 8, spreadRadius: 2)],
      ),
      child: ClipOval(
        child: Container(color: ColorApp.colorECEEF0, child: Icon(Icons.person, size: 24, color: ColorApp.color707882)),
      ),
    );
  }
}
