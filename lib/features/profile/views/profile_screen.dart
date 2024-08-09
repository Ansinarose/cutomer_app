// ignore_for_file: unused_local_variable, unused_import

import 'package:customer_application/bloc/bloc/app_bloc.dart';
import 'package:customer_application/bloc/bloc/app_event.dart';
import 'package:customer_application/bloc/bloc/app_state.dart';
import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/common/widgets/curved_appbar.dart';
import 'package:customer_application/common/widgets/logout_dialog.dart';
import 'package:customer_application/features/basket/views/basket_screen.dart';
import 'package:customer_application/features/booking/views/booking_screen.dart';
import 'package:customer_application/features/cart/views/cart_screen.dart';
import 'package:customer_application/features/chat/views/chat_screen.dart';
import 'package:customer_application/features/payment/views/payment_history_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBackgroundcolor,
          appBar: CurvedAppBar(title: ''),
          body: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    children: [
                      _buildListTile(
                        title: 'Name',
                        icon: Icons.person,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProfileDetailsAddScreen()));
                        },
                      ),
                      _buildListTile(
                        title: 'Help Center',
                        icon: Icons.help,
                        onTap: () {
                           Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CustomerChatScreen()));
                        },
                      ),
                      _buildListTile(
                        title: 'My Cart',
                        icon: Icons.shopping_cart,
                        onTap: () {
                         Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CartScreen()));
                        },
                      ),
                      _buildListTile(
                        title: 'My Payments',
                        icon: Icons.payment,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PaymentHistoryScreen()));
                        },
                      ),
                      _buildListTile(
                        title: 'My Orders',
                        icon: Icons.list_alt,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> BasketScreen()));
                        },
                      ),
                      _buildListTile(
                        title: 'Logout',
                        icon: Icons.logout,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return LogoutDialog(
                                onConfirmLogout: () {
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
          ),
        );
      },
    );
  }

  Widget _buildListTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: TextStyle(color: AppColors.textPrimaryColor),
          ),
          leading: Icon(icon, color: AppColors.textPrimaryColor),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: onTap,
        ),
        Divider(height: 1, color: Colors.grey),
      ],
    );
  }
}
