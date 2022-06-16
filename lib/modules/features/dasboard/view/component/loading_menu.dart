import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magang/shared/widgets/shimmer.dart';

class LoadingMenu extends StatelessWidget {
  const LoadingMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 17.r,
      children: List.generate(2, (i) {
        return RectShimmer(height: 89.r, radius: 10.r);
      }),
    );
  }
}
