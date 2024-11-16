import 'package:flutter/material.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/privacy_policy/ui/widgets/policy.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/privacy_policy/ui/widgets/sub_contents.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
   // final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 17, 17, 17),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          'Privacy Policy',
          style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
              fontSize: width * 0.05),
        ),
      ),
      body: ListView(
        children: [
          policyContents(
            context: context,
            mainHeading: '1. Information We Collect',
            introduction:
                'We collect various types of information to facilitate the management and functionality of our theatre-side application.',
            subcontents: const SizedBox.shrink(),
          ),
          policyContents(
              context: context,
              mainHeading: '2. How We Use the Information',
              introduction:
                  'The information we collect is used to enhance your experience and ensure efficient management of theatre operations:',
              subcontents: subContents(
                  context: context, itemCount: 3, contentItems: contentItems)),
          policyContents(
            context: context,
            mainHeading: 'Information Sharing and Disclosure',
            introduction:
                'We do not share your information with third parties except in the following situations:',
            subcontents: subContents(
                context: context, contentItems: contentItems3, itemCount: 3),
          ),
          policyContents(
            context: context,
            mainHeading: '4. Data Security',
            introduction:
                'We are committed to protecting your information and employ measures such as encryption and secure storage to safeguard against unauthorized access, alteration, or disclosure. However, please note that no security system is completely foolproof.',
            subcontents: const SizedBox.shrink(),
          ),
          policyContents(
            context: context,
            mainHeading: '5. Data Retention',
            introduction:
                'We retain your information only for as long as necessary to fulfill the purposes outlined in this Privacy Policy or as legally required. When your data is no longer needed, we will securely delete or anonymize it.',
            subcontents: const SizedBox.shrink(),
          ),
          policyContents(
            context: context,
            mainHeading: '6. Your Rights and Choices',
            introduction:
                'Depending on your location and applicable laws, you may have the following rights:',
            subcontents: subContents(
                context: context, contentItems: contentItems6, itemCount: 4),
          ),
          policyContents(
            context: context,
            mainHeading: '7. Changes to This Privacy Policy',
            introduction:
                'We may update this Privacy Policy from time to time to reflect changes in our practices or for legal and regulatory reasons. We will notify you of any significant changes through the app or other means. We encourage you to review this policy periodically to stay informed about how we protect your information.',
            subcontents: const SizedBox.shrink(),
          ),
          policyContents(
            context: context,
            mainHeading: '8. Contact Us',
            introduction:
                'If you have questions about this Privacy Policy or our data practices, please contact us at :',
            subcontents: const SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}

final List<Map<String, String>> contentItems = [
  {
    'title': 'To Provide Services:',
    'subtitle':
        'To facilitate ticket bookings, manage show information, and provide you with access to essential app features.'
  },
  {
    'title': 'To Analyze Performance:',
    'subtitle':
        'To monitor and analyze app usage and sales performance, helping you optimize theatre operations.'
  },
  {
    'title': 'To Ensure Security:',
    'subtitle':
        'To protect your account and transactions through secure authentication and data handling practices.'
  },
];
final List<Map<String, String>> contentItems3 = [
  {
    'title': 'With Your Consent: ',
    'subtitle':
        'We may share your information with third parties when you provide explicit consent.'
  },
  {
    'title': 'Service Providers:',
    'subtitle':
        'We may work with trusted service providers to process financial transactions, analyze data, and perform other services. These providers are bound by confidentiality agreements.'
  },
  {
    'title': 'Legal Obligations:',
    'subtitle':
        'We may disclose information if required to comply with legal obligations, such as court orders or regulatory requirements.'
  },
];
final List<Map<String, String>> contentItems6 = [
  {
    'title': 'Access: ',
    'subtitle':
        'You may request access to the personal information we hold about you.'
  },
  {
    'title': 'Correction: ',
    'subtitle':
        'You may request corrections to any inaccurate or incomplete information.'
  },
  {
    'title': 'Deletion: ',
    'subtitle':
        'You may request deletion of your information, subject to legal and contractual restrictions.'
  },
  {
    'title': 'Data Portability: ',
    'subtitle':
        'You may request a copy of your information in a machine-readable format.'
  },
];
