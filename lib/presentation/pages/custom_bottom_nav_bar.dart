import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_colors.dart';
import '../../utils/responsive_utils.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: 65.h,
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.spacingHorizontal16,
            vertical: ResponsiveUtils.spacing6,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                index: 0,
                iconPath: 'assets/icons/home.svg',
                label: 'Home',
              ),
              _buildNavItem(
                index: 1,
                iconPath: 'assets/icons/portfolio.svg',
                label: 'Portfolio',
              ),
              _buildNavItem(
                index: 2,
                iconPath: 'assets/icons/input.svg',
                label: 'Input',
              ),
              _buildNavItem(
                index: 3,
                iconPath: 'assets/icons/profile.svg',
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String iconPath,
    required String label,
  }) {
    final isSelected = currentIndex == index;
    final color = isSelected
        ? AppColors.bottomNavSelected
        : AppColors.bottomNavUnselected;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveUtils.spacingHorizontal12,
          // vertical: ResponsiveUtils.spacing4,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Indicator
            Container(
              height: 3.h,
              width: 24.w,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.bottomNavSelected
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: ResponsiveUtils.spacing4),

            // Icon
            SvgPicture.asset(
              iconPath,
              width: ResponsiveUtils.iconSize24,
              height: ResponsiveUtils.iconSize24,
              color: color,
              // Fallback to Icon if SVG fails
              placeholderBuilder: (context) => Icon(
                _getIconData(label),
                size: ResponsiveUtils.iconSize24,
                color: color,
              ),
            ),
            SizedBox(height: ResponsiveUtils.spacing4),

            // Label
            Text(
              label,
              style: GoogleFonts.roboto(
                fontSize: ResponsiveUtils.font11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconData(String label) {
    switch (label) {
      case 'Home':
        return Icons.home;
      case 'Portfolio':
        return Icons.work;
      case 'Input':
        return Icons.add_box;
      case 'Profile':
        return Icons.person;
      default:
        return Icons.home;
    }
  }
}
