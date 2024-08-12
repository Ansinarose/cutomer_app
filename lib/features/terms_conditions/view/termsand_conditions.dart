import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/common/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.textPrimaryColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms and Conditions',
              style: TextStyle(
                color: AppColors.textPrimaryColor,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            _buildSectionTitle('1. Introduction'),
            _buildSectionContent(
              'Welcome to the Alfa Aluminium Works Customer App. By downloading or using the app, you agree to comply with and be bound by the following terms and conditions. Please read these terms carefully before using the app. If you do not agree with these terms, please do not use the app.',
            ),
            _buildSectionTitle('2. Account Registration'),
            _buildSectionContent(
              'User Login: To access certain features, you must log in using your username and password. You are responsible for maintaining the confidentiality of your account credentials and are responsible for all activities that occur under your account.\n\n'
              'Signup: You can sign up using your email, phone number, and password. Additionally, you may sign in using Google.\n\n'
              'Profile Information: After signing up, you may choose to add profile details, including your name, phone number, email, gender, occupation, pincode, city, state, and a profile picture. This session is optional and not mandatory for using the app.',
            ),
            _buildSectionTitle('3. Services and Categories'),
            _buildSectionContent(
              'Home Page: The home page of the app displays different services offered by Alfa Aluminium Works. Customers can swipe and choose the desired service.\n\n'
              'Service Categories: Each service has multiple categories that can be explored. You can use the search function to find specific categories.\n\n'
              'Product Selection: Upon selecting a category, you will be taken to a page where multiple products are displayed. A filter option is available to narrow down your choices. You can book a product by selecting the desired color and adding your address.',
            ),
            _buildSectionTitle('4. Orders and Fulfillment'),
            _buildSectionContent(
              'Order Processing: When you place an order for fabrication works, Alfa Aluminium Works will ensure that workers complete the job within one month of the order date.\n\n'
              'Basket Screen: You can view the status of your booked products in the Basket screen, including tracking the progress of your order.',
            ),
            _buildSectionTitle('5. Payments'),
            _buildSectionContent(
              'Payment Gateway: Upon completion of the work, you will be required to make a payment through our integrated payment gateway, Razorpay. Please ensure that all payment information provided is accurate and complete.',
            ),
            _buildSectionTitle('6. Reviews'),
            _buildSectionContent(
              'Adding Reviews: After the completion of a product or service, you may add a review. All reviews submitted will be publicly displayed and shared across the app as a common review for that product or service.',
            ),
            _buildSectionTitle('7. Chat Support'),
            _buildSectionContent(
              'Customer Support: The app includes a chat option where customers can directly communicate with the company for support, inquiries, or issues related to services and products.',
            ),
            _buildSectionTitle('8. Privacy'),
            _buildSectionContent(
              'Data Collection: By using the app, you agree that we may collect, store, and use your personal information as per our Privacy Policy. This includes details provided during signup, profile creation, and payment processing.\n\n'
              'Data Security: We are committed to ensuring that your information is secure. However, you are responsible for keeping your login details confidential.',
            ),
            _buildSectionTitle('9. Modifications to the Service'),
            _buildSectionContent(
              'App Changes: Alfa Aluminium Works reserves the right to modify or discontinue, temporarily or permanently, the app or any features within it without prior notice.',
            ),
            _buildSectionTitle('10. Limitation of Liability'),
            _buildSectionContent(
              'Service Delivery: Alfa Aluminium Works strives to ensure that all services are provided as described. However, we are not liable for any delays or issues arising from external factors beyond our control.\n\n'
              'Indemnification: You agree to indemnify and hold harmless Alfa Aluminium Works, its affiliates, and employees from any claim or demand arising out of your use of the app or violation of these terms.',
            ),
            _buildSectionTitle('11. Governing Law'),
            _buildSectionContent(
              'These terms and conditions are governed by and construed in accordance with the laws of [Your Jurisdiction], and you irrevocably submit to the exclusive jurisdiction of the courts in that location.',
            ),
            _buildSectionTitle('12. Contact Us'),
            _buildSectionContent(
              'For any questions or concerns regarding these Terms and Conditions, please contact us at iansinarose@gmail.com',
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.textPrimaryColor,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Text(
      content,
      style: TextStyle(
        color: AppColors.textPrimaryColor,
        fontSize: 16.0,
        height: 1.5,
      ),
    );
  }
}
