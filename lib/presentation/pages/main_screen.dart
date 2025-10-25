import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_colors.dart';
import '../../utils/responsive_utils.dart';
import 'custom_bottom_nav_bar.dart';
import 'portfolio_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 1; // Start with Portfolio selected

  final List<Widget> _pages = [
    const _EmptyPage(title: 'Home'),
    const PortfolioPage(),
    const _EmptyPage(title: 'Input'),
    const _EmptyPage(title: 'Profile'),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}

class _EmptyPage extends StatelessWidget {
  final String title;

  const _EmptyPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          title,
          style: GoogleFonts.roboto(
            fontSize: ResponsiveUtils.font24,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: Center(
        child: Text(
          '$title Page',
          style: GoogleFonts.roboto(
            fontSize: ResponsiveUtils.font18,
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
