import 'package:flutter/material.dart';
import 'package:pt_warung_madura_albertus_carlos/config/style.dart';

class EmptyCategorySection extends StatelessWidget {
  const EmptyCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Column(
        children: [
          SizedBox(height: 100),
          Image(
            height: 140,
            width: 140,
            image: AssetImage(
              'assets/images/data_not_found.png',
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Data Not Found',
            style: Style.poppinsFont,
          ),
        ],
      ),
    );
  }
}
