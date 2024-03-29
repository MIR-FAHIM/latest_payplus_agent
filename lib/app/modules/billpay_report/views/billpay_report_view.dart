import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/custom_data.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import '../controllers/billpay_report_controller.dart';

class BillpayReportView extends GetView<BillpayReportController> {
  const BillpayReportView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF652981),
        title: Text('Bill History'.tr),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.billReportLoaded.isTrue) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: List.generate(controller.billReport.value.data!.length, (index) {
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.BILL_DETAILS, arguments: controller.billReport.value.data![index].id.toString());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 5,
                      child: SizedBox(
                        height: size.width * .2,
                        width: size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.network(
                                    controller.billReport.value.data![index].logo_url!,
                                    height: 40,
                                    width: 40,
                                  ),
                                   SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    width: Get.width*.37,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.billReport.value.data![index].billerType!,
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          controller.billReport.value.data![index].billName!,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                         SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Bill No: ${controller.billReport.value.data![index].billNo!}',
                                          style:  TextStyle(
                                            fontSize: 13,
                                            color: AppColors.primaryColor
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: Get.width*.35,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      DateFormat.yMMMd().format(DateTime.parse(controller.billReport.value.data![index].createdAt!)) +
                                          ' ' +
                                          DateFormat.jm().format(DateTime.parse(controller.billReport.value.data![index].createdAt!)),
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      uniCodeTk + ' ' + controller.billReport.value.data![index].billTotalAmount!,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      controller.billReport.value.data![index].paymentStatus!,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: controller.billReport.value.data![index].paymentStatus!.toLowerCase() == 'unpaid'
                                            ? Colors.red
                                            : controller.billReport.value.data![index].paymentStatus!.toLowerCase() == 'paid'
                                                ? Colors.green
                                                : Colors.yellow,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        } else {
          return SizedBox(
            height: Get.size.height,
            child: Center(
              child: Ui.customLoader(),
            ),
          );
        }
      }),
    );
  }
}
