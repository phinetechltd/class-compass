import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:class_compass/feature/profile/domain/model/profile_model.dart';
import 'package:class_compass/feature/profile/logic/profile_controller.dart';
import 'package:class_compass/util/styles.dart';

class DashboardHeadingSectionWidget extends StatelessWidget {
  const DashboardHeadingSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (profileController) {
        ProfileModel? profileModel = profileController.profileModel;
        final String name = profileModel?.data?.name ?? '';
        final String today = DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF0F172A), Color(0xFF1E3A5F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(AppBorderRadius.xl),
            boxShadow: AppShadows.colored,
          ),
          child: Stack(
            children: [
              Positioned(
                right: -40,
                top: -60,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.secondary.withValues(alpha: 0.18),
                  ),
                ),
              ),
              Positioned(
                right: 90,
                bottom: -70,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accent.withValues(alpha: 0.12),
                  ),
                ),
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  final greeting = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'welcome_back'.tr,
                        style: textMedium.copyWith(
                          fontSize: 13,
                          letterSpacing: 0.4,
                          color: Colors.white.withValues(alpha: 0.7),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textBold.copyWith(
                          fontSize: 26,
                          color: Colors.white,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'dashboard_report_slogan'.tr,
                        style: textRegular.copyWith(
                          fontSize: 14,
                          color: Colors.white.withValues(alpha: 0.72),
                        ),
                      ),
                    ],
                  );

                  final dateChip = Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(AppBorderRadius.full),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.calendar_month_rounded,
                          size: 16,
                          color: Colors.white.withValues(alpha: 0.85),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          today,
                          style: textMedium.copyWith(
                            fontSize: 13,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                  );

                  if (constraints.maxWidth < 640) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        greeting,
                        const SizedBox(height: 16),
                        dateChip,
                      ],
                    );
                  }

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: greeting),
                      const SizedBox(width: 16),
                      dateChip,
                    ],
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
