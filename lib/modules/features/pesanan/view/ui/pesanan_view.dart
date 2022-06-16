import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:magang/config/routes/app_routes.dart';
import 'package:magang/config/themes/colors.dart';
import 'package:magang/modules/features/pesanan/controller/order_controller.dart';
import 'package:magang/modules/features/pesanan/view/component/dropdown_status.dart';
import 'package:magang/modules/features/pesanan/view/component/empty_order_data.dart';
import 'package:magang/modules/features/pesanan/view/component/order_cart.dart';
import 'package:magang/modules/features/pesanan/view/component/pick_data.dart';
import 'package:magang/shared/widgets/empty_data.dart';
import 'package:magang/shared/widgets/server_error_view.dart';
import 'package:magang/shared/widgets/shimmer.dart';

import '../../../../../shared/style/shapes.dart';

class PesananView extends StatelessWidget {
  const PesananView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(OrderController());
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Material(
               clipBehavior: Clip.antiAlias,
               elevation: 2,
                color: Colors.white,
                shape: CustomShape.bottomRoundedShape,
                child: SafeArea(
                  child: TabBar(
                    indicatorColor:blueColor,
                    unselectedLabelColor: darkColor,
                    labelColor: blueColor,
                    labelStyle: Get.textTheme.titleSmall,
                    tabs:[
                    Padding(
                        padding: EdgeInsets.symmetric(vertical:10.r),
                        child: Tab(text: "On Going".tr,)
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical:10.r),
                        child: Tab(text: "History".tr))
                  ],
                  ),
                ),
              ),
          ),
        body: TabBarView(
          children: [
            _onGoingOrders(context),
            _historyOrders(context),
          ],
        ),
      ),
    );
  }

  Widget _onGoingOrders(BuildContext context){
    return RefreshIndicator(
      onRefresh: OrderController.to.fetchOnGoing,
          child: Obx(
                () => ConditionalSwitch.single(
              context: context,
              valueBuilder: (context) => OrderController.to.onGoingStatus.value,
              caseBuilders: {
                'error': (context) => const ServerError(),
                'empty': (context) => OrderDataEmpty(
                  title: 'Already Ordered? Track the order here.'.tr,
                ),
                'loading': (context) => ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: 25.r,
                    vertical: 25.r,
                  ),
                  separatorBuilder: (_, i) => 16.verticalSpacingRadius,
                  itemCount: 5,
                  itemBuilder: (_, i) => AspectRatio(
                    aspectRatio: 378 / 138,
                    child: RectShimmer(radius: 10.r),
                  ),
                ),
              },
              fallbackBuilder: (context) => ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 25.r, vertical: 25.r),
                separatorBuilder: (_, index) => 16.verticalSpacingRadius,
                itemCount: OrderController.to.onGoingOrders.length,
                itemBuilder: (_, index) => OrderCard(
                  order: OrderController.to.onGoingOrders.elementAt(index),
                  onTap: () => Get.toNamed(
                    AppRoutes.DetailPesananView,
                    arguments: OrderController.to.onGoingOrders.elementAt(index),
                  ),
                ),
              ),
            ),

          ),
    );
  }
  Widget _historyOrders(BuildContext context){
    final Map<String, String> filterStatus = {
      'all': 'All status'.tr,
      'completed': 'Completed'.tr,
      'canceled': 'Canceled'.tr,
    };

    return RefreshIndicator(
      onRefresh: OrderController.to.fetchHistory,
      child: Obx(
            () => ConditionalSwitch.single(
          context: context,
          valueBuilder: (context) => OrderController.to.historyStatus.value,
          caseBuilders: {
            'error': (context) => const ServerError(),
            'empty': (context) => OrderDataEmpty(
              title: 'Start placing orders.'.tr,
              subtitle:
              'The food you ordered will appear here so you can find your favorite menu again!'
                  .tr,
            ),
            'loading': (context) => ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: 25.r,
                vertical: 25.r,
              ),
              separatorBuilder: (_, i) => 16.verticalSpacingRadius,
              itemCount: 5,
              itemBuilder: (_, i) => AspectRatio(
                aspectRatio: 378 / 138,
                child: RectShimmer(radius: 10.r),
              ),
            ),
          },
          fallbackBuilder: (context) => ListView(
            padding: EdgeInsets.symmetric(horizontal: 25.r, vertical: 25.r),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: DropdownStatus(
                      items: filterStatus,
                      selectedItem: OrderController.to.selectedCategory,
                      onChanged: (value) =>
                          OrderController.to.setFilter(category: value),
                    ),
                  ),
                  22.horizontalSpaceRadius,
                  Expanded(
                    child: DatePicker(
                      selectedDate: OrderController.to.selectedDateRange,
                      onChanged: (value) =>
                          OrderController.to.setFilter(dateRange: value),
                    ),
                  ),
                ],
              ),
              25.verticalSpacingRadius,
              ...Conditional.list(
                context: context,
                conditionBuilder: (context) =>
                OrderController.to.historyOrderFiltered.isEmpty,
                widgetBuilder: (context) => [
                  100.verticalSpacingRadius,
                  const EmptyDataVertical(),
                  100.verticalSpacingRadius,
                ],
                fallbackBuilder: (context) =>
                    OrderController.to.historyOrderFiltered
                        .map(
                          (order) => Padding(
                        padding: EdgeInsets.only(bottom: 16.r),
                        child: OrderCard(
                          order: order,
                          onOrderAgain: () =>
                              OrderController.to.onOrderAgain(order),
                          onTap: () => Get.toNamed(
                            AppRoutes.DetailPesananView,
                            arguments: order,
                          ),
                        ),
                      ),
                    )
                        .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
