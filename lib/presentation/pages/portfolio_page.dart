import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_colors.dart';
import '../../data/models/project_model.dart';
import '../../utils/responsive_utils.dart';
import '../widgets/project_card.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({Key? key}) : super(key: key);

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  List<ProjectModel> _allProjects = [];
  List<ProjectModel> _filteredProjects = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _allProjects = ProjectModel.getStaticProjects();
    _filteredProjects = _allProjects;
    _searchController.addListener(_filterProjects);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _filterProjects() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredProjects = _allProjects;
      } else {
        _filteredProjects = _allProjects
            .where((project) => project.title.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildProjectTab(),
                _buildEmptyTab('Saved'),
                _buildEmptyTab('Shared'),
                _buildEmptyTab('Achievement'),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _buildFilterButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      toolbarHeight: 80.h,
      title: Text(
        'Portfolio',
        style: GoogleFonts.roboto(
          fontSize: ResponsiveUtils.font24,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      actions: [
        IconButton(
          icon: SvgPicture.asset(
            'assets/icons/shopping_bag.svg',
            width: ResponsiveUtils.iconSize24,
            height: ResponsiveUtils.iconSize24,
            color: AppColors.primary,
            placeholderBuilder: (context) => Icon(
              Icons.shopping_bag,
              size: ResponsiveUtils.iconSize24,
              color: AppColors.primary,
            ),
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: SvgPicture.asset(
            'assets/icons/notification.svg',
            width: ResponsiveUtils.iconSize24,
            height: ResponsiveUtils.iconSize24,
            color: AppColors.primary,
            placeholderBuilder: (context) => Icon(
              Icons.notifications,
              size: ResponsiveUtils.iconSize24,
              color: AppColors.primary,
            ),
          ),
          onPressed: () {},
        ),
        SizedBox(width: ResponsiveUtils.spacingHorizontal8),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: AppColors.white,
      child: TabBar(
        controller: _tabController,
        isScrollable: false,
        indicatorColor: AppColors.primary,
        indicatorWeight: 3,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textSecondary,
        labelStyle: GoogleFonts.roboto(
          fontSize: ResponsiveUtils.font14,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.roboto(
          fontSize: ResponsiveUtils.font14,
          fontWeight: FontWeight.w500,
        ),
        tabs: const [
          Tab(text: 'Project'),
          Tab(text: 'Saved'),
          Tab(text: 'Shared'),
          Tab(text: 'Achievment'),
        ],
      ),
    );
  }

  Widget _buildProjectTab() {
    return Column(
      children: [
        _buildSearchBar(),
        Expanded(
          child: _filteredProjects.isEmpty
              ? _buildEmptyState()
              : _buildProjectList(),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.spacingHorizontal20,
        vertical: ResponsiveUtils.spacing16,
      ),
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          color: AppColors.searchBackground,
          borderRadius: BorderRadius.circular(ResponsiveUtils.radius10),
          border: Border.all(color: AppColors.searchBorder, width: 1),
        ),
        child: TextField(
          controller: _searchController,
          style: GoogleFonts.roboto(
            fontSize: ResponsiveUtils.font14,
            color: AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: 'Search a project',
            hintStyle: GoogleFonts.roboto(
              fontSize: ResponsiveUtils.font14,
              color: AppColors.textGrey,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.spacingHorizontal16,
              vertical: ResponsiveUtils.spacing12,
            ),
            suffixIcon: Container(
              margin: EdgeInsets.all(ResponsiveUtils.spacing6),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(ResponsiveUtils.radius8),
              ),
              child: Icon(
                Icons.search,
                color: AppColors.white,
                size: ResponsiveUtils.iconSize20,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.spacingHorizontal20,
        vertical: ResponsiveUtils.spacing16,
      ),
      itemCount: _filteredProjects.length,
      itemBuilder: (context, index) {
        return ProjectCard(project: _filteredProjects[index]);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64.w, color: AppColors.textGrey),
          SizedBox(height: ResponsiveUtils.spacing16),
          Text(
            'No projects found',
            style: GoogleFonts.roboto(
              fontSize: ResponsiveUtils.font16,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyTab(String tabName) {
    return Container(
      color: AppColors.background,
      child: Center(
        child: Text(
          '$tabName Tab',
          style: GoogleFonts.roboto(
            fontSize: ResponsiveUtils.font18,
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButton() {
    return Container(
      margin: EdgeInsets.only(bottom: ResponsiveUtils.spacing16),
      child: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        elevation: 4,

        icon: Icon(
          Icons.tune,
          color: AppColors.white,
          size: ResponsiveUtils.iconSize20,
        ),
        label: Text(
          'Filter',
          style: GoogleFonts.roboto(
            fontSize: ResponsiveUtils.font14,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
