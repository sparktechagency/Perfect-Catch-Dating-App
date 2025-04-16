import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perfect_catch_dating_app/utils/app_strings.dart';
import '../../base/custom_app_bar.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.profileDetails.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile picture and name section
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage('https://s3-alpha-sig.figma.com/img/0070/a04d/2bab51a081e3a54b73822719d5e8134d?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=oMLhkNk-ooLwpMYnX7bt1Ny0ohotznWdrlMOZUtiQa9~S1eOzX3OQuNH3bm9LIvy607skMewOPXx1mD4OMNL34gV~f3Yhxbp3q0slXWMz90GqpWl6xZUg20d~-z~8wVEcikLNQY0zd4HcRHrC8-B1NWQcZ7AREFEjU907jwn8nIGdZNjV72CnLIh~jFcDe~b13KPBefghmIkfoq72fnsDmHYW7udlvsCZHSjWKKUwYX5nwB0AJDcXhvs7PMnv-Dg2U5Z5Waz2RxQc1A9dhtVmwP13ZPDcozOfwZPCJawNFXa2O5ksggFQo-d2cMxDt4sgMxh4LU3e5h1aAMMf2bCsQ__'),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sally Brown',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Text('Label: '),
                            Text(
                              'Model',
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Location section
              _sectionTitle('Location'),
              SizedBox(height: 8),
              _infoText('Chicago, IL, United States'),
              SizedBox(height: 24),

              // Contact information section
              _sectionTitle('Contact Information'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _infoItem('Date of Birth', '1995-01-01'),
                  _infoItem('Gender', 'Female'),
                  _infoItem('Status', 'Single'),
                ],
              ),
              SizedBox(height: 24),

              // About section
              _sectionTitle('About'),
              SizedBox(height: 8),
              _infoText(
                'Sally Brown is a talented model, photographer, and influencer with a love for fashion. She enjoys creating content for various brands and showcasing new looks.',
              ),
              SizedBox(height: 24),

              // Interests section
              _sectionTitle('Interests'),
              SizedBox(height: 8),
              Row(
                children: [
                  _interestChip('Photography'),
                  _interestChip('Fashion'),
                  _interestChip('Traveling'),
                ],
              ),
              SizedBox(height: 24),

              // Gallery photos section
              _sectionTitle('Gallery Photos'),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _galleryImage(),
                  _galleryImage(),
                  _galleryImage(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.8)),
    );
  }

  Widget _infoItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: Colors.grey)),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _infoText(String text) {
    return Text(
      text,
      style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 16),
    );
  }

  Widget _interestChip(String interest) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Chip(
        label: Text(interest),
        backgroundColor: Colors.teal.shade100,
      ),
    );
  }

  Widget _galleryImage() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://s3-alpha-sig.figma.com/img/0070/a04d/2bab51a081e3a54b73822719d5e8134d?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=oMLhkNk-ooLwpMYnX7bt1Ny0ohotznWdrlMOZUtiQa9~S1eOzX3OQuNH3bm9LIvy607skMewOPXx1mD4OMNL34gV~f3Yhxbp3q0slXWMz90GqpWl6xZUg20d~-z~8wVEcikLNQY0zd4HcRHrC8-B1NWQcZ7AREFEjU907jwn8nIGdZNjV72CnLIh~jFcDe~b13KPBefghmIkfoq72fnsDmHYW7udlvsCZHSjWKKUwYX5nwB0AJDcXhvs7PMnv-Dg2U5Z5Waz2RxQc1A9dhtVmwP13ZPDcozOfwZPCJawNFXa2O5ksggFQo-d2cMxDt4sgMxh4LU3e5h1aAMMf2bCsQ__'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.shade200,
      ),
    );
  }
}
