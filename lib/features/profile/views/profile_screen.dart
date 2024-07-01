// ignore_for_file: unused_local_variable

import 'package:customer_application/bloc/bloc/app_bloc.dart';
import 'package:customer_application/bloc/bloc/app_event.dart';
import 'package:customer_application/bloc/bloc/app_state.dart';
import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/common/widgets/curved_appbar.dart';
import 'package:customer_application/common/widgets/logout_dialog.dart';
import 'package:customer_application/features/profile/views/profile_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreenWrapper extends StatelessWidget {
  const ProfileScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuthBloc(), child: ProfileScreen());
  }
}

class ProfileScreen extends StatelessWidget {
  // const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen height and width
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate padding based on screen height
    final topPadding = screenHeight * 0.05; // 5% of screen height

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBackgroundcolor,
          appBar: CurvedAppBar(title: ''),
          body: Padding(
            padding: EdgeInsets.only(top: topPadding),
            child: ListView(
              children: [
                ListTile(
                  title: Text(
                    'Name',
                    style: TextStyle(color: AppColors.textPrimaryColor),
                  ),
                  // subtitle: Text('User Name'),
                  leading:
                      Icon(Icons.person, color: AppColors.textPrimaryColor),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProfileDetailsAddScreen()));
                  },
                ),
                Divider(height: 1, color: Colors.grey),
                ListTile(
                  title: Text(
                    'Help Center',
                    style: TextStyle(color: AppColors.textPrimaryColor),
                  ),
                  leading: Icon(Icons.help, color: AppColors.textPrimaryColor),
                  onTap: () {
                    // Handle tap
                  },
                ),
                Divider(height: 1, color: Colors.grey),
                ListTile(
                  title: Text(
                    'My Cart',
                    style: TextStyle(color: AppColors.textPrimaryColor),
                  ),
                  leading: Icon(Icons.shopping_cart,
                      color: AppColors.textPrimaryColor),
                  onTap: () {
                    // Handle tap
                  },
                ),
                Divider(height: 1, color: Colors.grey),
                ListTile(
                  title: Text(
                    'My Payments',
                    style: TextStyle(color: AppColors.textPrimaryColor),
                  ),
                  leading:
                      Icon(Icons.payment, color: AppColors.textPrimaryColor),
                  onTap: () {
                    // Handle tap
                  },
                ),
                Divider(height: 1, color: Colors.grey),
                ListTile(
                  title: Text(
                    'My Orders',
                    style: TextStyle(color: AppColors.textPrimaryColor),
                  ),
                  leading:
                      Icon(Icons.list_alt, color: AppColors.textPrimaryColor),
                  onTap: () {
                    // Handle tap
                  },
                ),
                Divider(height: 1, color: Colors.grey),
                ListTile(
                  title: Text(
                    'Logout',
                    style: TextStyle(color: AppColors.textPrimaryColor),
                  ),
                  leading:
                      Icon(Icons.logout, color: AppColors.textPrimaryColor),
                  onTap: () {
                    
                    showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return LogoutDialog(
                        onConfirmLogout: () {
                        //  Perform logout logic here
                          final authBloc = BlocProvider.of<AuthBloc>(context);
                          authBloc.add(LogoutEvent());
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/login', (route) => false);
                        },
                      );
                    },
                  );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
