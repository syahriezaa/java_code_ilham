import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:magang/config/routes/app_routes.dart';
import 'package:magang/modules/features/dasboard/view/component/menu_card.dart';
import 'package:magang/modules/models/menu_model.dart';
import 'package:magang/shared/widgets/empty_data.dart';


class MenuList extends StatelessWidget {
  final List<MenuData> data;

  const MenuList({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Conditional.single(
      context: context,
      conditionBuilder: (context) => data.isNotEmpty,
      widgetBuilder: (context) => Wrap(
        runSpacing: 17.r,
        children: data.map<Widget>((menu) {
          return MenuCard.simple(
            menu: menu,
            onTap: () {
              try{
              Get.toNamed(
                AppRoutes.MenuDetailView, arguments: menu
            );}
                  catch(e){print(e);}
            }
          );
        }).toList(),
      ),
      fallbackBuilder: (context) => EmptyDataVertical(width: 100.r),
    );
  }
}
