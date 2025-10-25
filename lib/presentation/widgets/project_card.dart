import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_colors.dart';
import '../../data/models/project_model.dart';
import '../../utils/responsive_utils.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;

  const ProjectCard({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: ResponsiveUtils.spacing16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(ResponsiveUtils.radius12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Project Image
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(ResponsiveUtils.radius12),
              bottomLeft: Radius.circular(ResponsiveUtils.radius12),
            ),
            child: Container(
              width: ResponsiveUtils.cardImageSize,
              height: ResponsiveUtils.cardHeight,
              color: AppColors.background,
              child: Image.asset(
                project.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.background,
                    child: Icon(
                      Icons.image,
                      size: ResponsiveUtils.iconSize28,
                      color: AppColors.textGrey,
                    ),
                  );
                },
              ),
            ),
          ),

          // Project Details
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(ResponsiveUtils.spacing16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title
                  Text(
                    project.title,
                    style: GoogleFonts.roboto(
                      fontSize: ResponsiveUtils.font14,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: ResponsiveUtils.spacing8),

                  // Subject
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project.subject,
                            style: GoogleFonts.roboto(
                              fontSize: ResponsiveUtils.font10,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textPrimary,

                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(height: ResponsiveUtils.spacing4),

                          // Author
                          Text(
                            project.author,
                            style: GoogleFonts.roboto(
                              fontSize: ResponsiveUtils.font10,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: ResponsiveUtils.spacingHorizontal16,
                        ),
                        child: Container(
                          width: 40.w,
                          height: 26.h,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xffF39519), Color(0xffFFCD67)],
                            ),
                            borderRadius: BorderRadius.circular(
                              ResponsiveUtils.radius8,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              project.grade,
                              style: GoogleFonts.roboto(
                                fontSize: ResponsiveUtils.font14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Grade Badge
        ],
      ),
    );
  }
}
