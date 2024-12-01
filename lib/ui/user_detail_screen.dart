import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kebormed_mobile/common/app_dimens.dart';

import '../common/labels.dart';
import '../data/models/user_model.dart';

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Get.arguments[0] as User;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text(
          Labels.userDetailLabel,
          style: theme.textTheme.headlineMedium,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Navigates back to the previous screen
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // User Profile Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: AppDimens.avatarRadius,
                    backgroundColor: theme.primaryColor,
                    child: Text(
                      user.name!.substring(0, 1),
                      style: theme.textTheme.headlineMedium!.copyWith(color: theme.colorScheme.onPrimary),
                    ),
                  ),
                  const SizedBox(height: AppDimens.padding12),
                  Text(
                    user.name!,
                    style: theme.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    user.email!,
                    style: theme.textTheme.bodyMedium!.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDimens.padding16),

            // Information List
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimens.cardRadius),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppDimens.padding16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(context,Icons.person, Labels.username, user.username!),
                    const Divider(),
                    _buildInfoRow(context,Icons.phone, Labels.phoneLabel, user.phone!),
                    const Divider(),
                    _buildInfoRow(context,Icons.language, Labels.websiteLabel, user.website!),
                    const Divider(),
                    _buildInfoRow(context,
                      Icons.location_on,
                      Labels.addressLabel,
                      '${user.address!.suite ?? ""}, ${user.address!.street ?? ""}, ${user.address!.city ?? ""}, ${user.address!.zipcode ?? ""}',
                    ),
                    const Divider(),
                    _buildInfoRow(context,Icons.business, Labels.companyLabel, user.company!.name!),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context,IconData icon, String label, String value) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: AppDimens.padding12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: theme.textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
