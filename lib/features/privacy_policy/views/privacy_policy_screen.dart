import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/common/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  final Uri _privacyPolicyUrl = Uri.parse('https://www.termsfeed.com/live/edff902e-09e4-4966-a651-b87d88e0cff5');

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
              'Privacy Policy',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Last updated: August 12, 2024'),
            SizedBox(height: 16),
            Text(
              'This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You.\n\n'
              'We use Your Personal data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy. This Privacy Policy has been created with the help of the Privacy Policy Generator.\n\n'
              'Interpretation and Definitions\n\n'
              'Interpretation\n'
              'The words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.\n\n'
              'Definitions\n'
              'For the purposes of this Privacy Policy:\n\n'
              '**Account** means a unique account created for You to access our Service or parts of our Service.\n\n'
              '**Affiliate** means an entity that controls, is controlled by or is under common control with a party, where "control" means ownership of 50% or more of the shares, equity interest or other securities entitled to vote for election of directors or other managing authority.\n\n'
              '**Application** refers to ALFA-Connect, the software program provided by the Company.',
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: _launchURL,
              child: Text('View Full Privacy Policy',style: AppTextStyles.body,),
            ),
           
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL() async {
    if (!await launchUrl(_privacyPolicyUrl, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $_privacyPolicyUrl');
    }
  }
}
