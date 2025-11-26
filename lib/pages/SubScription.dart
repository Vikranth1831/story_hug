import 'dart:developer' as AppLogger;

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_workers/rx_workers.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:story_hug/components/CommonLoader.dart';
import 'package:story_hug/controller/PaymentController.dart';
import 'package:story_hug/controller/SubScriptionController.dart';
import 'package:story_hug/utils/color_constants.dart';
import 'package:story_hug/utils/media_query_helper.dart';
import '../data/remote_data_source.dart';
import '../models/CreatePaymentModel.dart';
import '../repositories/SubScriptionRepo.dart';
import '../repositories/payment_repository.dart';

class SubScriptions extends StatefulWidget {
  const SubScriptions({super.key});

  @override
  State<SubScriptions> createState() => _SubScriptionsState();
}

class _SubScriptionsState extends State<SubScriptions> {
  final SubScriptionController subScriptionController = Get.put(
    SubScriptionController(
      scriptionRepo: SubScriptionImpl(remoteDataSource: RemoteDataSourceImpl()),
    ),
  ); // Create Payment Controller
  final PaymentController paymentController = Get.put(
    PaymentController(
      paymentRepository: PaymentRepositoryImpl(
        remoteDataSource: RemoteDataSourceImpl(),
      ),
    ),
  );

  // Verify Payment Controller
  final VerifyPaymentController verifyPaymentController = Get.put(
    VerifyPaymentController(
      paymentRepository: PaymentRepositoryImpl(
        remoteDataSource: RemoteDataSourceImpl(),
      ),
    ),
  );
  int? selectedPlanIndex;
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();

    subScriptionController.fetchSubScriptions();

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    ever(paymentController.createPayment, (orderData) {
      if (orderData != null) {
        _openRazorpayCheckout(orderData);
      }
    });
  }

  void _openRazorpayCheckout(CreatePaymentModel model) {
    var options = {
      'key': "rzp_test_RePGJBwNOm2BaS",
      'amount': model.order?.amount,
      'currency': model.order?.currency ?? "INR",
      'name': "StoryHug",
      'description': "Subscription Payment",
      'order_id': model.order?.id,
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      AppLogger.log("⚠ ERROR OPENING RAZORPAY: $e");
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    AppLogger.log(
      "✅ Payment successful: ${response.paymentId} ${response.signature}",
    );
    Map<String, dynamic> data = {
      "razorpay_order_id": response.orderId,
      "razorpay_payment_id": response.paymentId,
      "razorpay_signature": response.signature,
    };
    AppLogger.log("successdata::${data}");
    final res = await verifyPaymentController.createPayments(data);

    if (res != null && res.success == true) {
      Get.back();
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    AppLogger.log("❌ Payment failed: ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    AppLogger.log("💼 External wallet selected: ${response.walletName}");
  }

  @override
  Widget build(BuildContext context) {
    final h = SizeConfig.screenHeight;
    final w = SizeConfig.screenWidth;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bgimage.png"),
            fit: BoxFit.cover,
          ),
        ),

        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: h * 0.08),

                  Image.asset(
                    "assets/images/favoritesimage.png",
                    width: w * 0.55,
                  ),

                  SizedBox(height: h * 0.03),

                  Container(
                    width: w * 0.90,
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0x7F73CCFE),
                        width: 2,
                      ),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /// TITLE
                        const Text(
                          "Unlock the magic within",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Image.asset(
                          "assets/images/subscribe.png",
                          height: h * 0.35,
                          width: w * 0.8,
                          fit: BoxFit.contain,
                        ),

                        const SizedBox(height: 15),

                        Obx(() {
                          if (subScriptionController.isLoading.value) {
                            return const Center(
                              child: DottedProgressWithLogo(),
                            );
                          }

                          if (subScriptionController.errorMessage.value !=
                              null) {
                            return Center(
                              child: Text(
                                subScriptionController.errorMessage.value!,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }

                          final plans = subScriptionController
                              .subScription
                              .value
                              ?.subscriptionPlans;

                          if (plans == null || plans.isEmpty) {
                            return const Text(
                              "No subscription plans available",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            );
                          }

                          return SizedBox(
                            height:
                                w *
                                0.42 *
                                1.2, // dynamic height based on width (ratio)
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              itemCount: plans.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 16),

                              itemBuilder: (context, index) {
                                final plan = plans[index];
                                final bool isSelected =
                                    selectedPlanIndex == index;

                                return Container(
                                  width: w * 0.42,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 24,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF2F3C74),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: isSelected
                                          ? primarycolor
                                          : Colors.transparent,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Html(
                                        data: "${plan.features ?? ""}",
                                        style: {
                                          "body": Style(
                                            color: Colors.white,
                                            fontSize: FontSize(13),
                                            margin: Margins.zero,
                                            padding: HtmlPaddings.zero,
                                          ),
                                        },
                                      ),

                                      const SizedBox(height: 12),

                                      SizedBox(
                                        width: SizeConfig.screenWidth,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(
                                              () => selectedPlanIndex = index,
                                            );
                                            paymentController.createPayments({
                                              "subscription_id": plan.id,
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            elevation: isSelected ? 4 : 0,
                                            backgroundColor: isSelected
                                                ? const Color(0xFFFFD363)
                                                : const Color(0xFFE0E3F0),
                                            foregroundColor: const Color(
                                              0xFF24305B,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 8,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              side: isSelected
                                                  ? BorderSide.none
                                                  : const BorderSide(
                                                      color: Color(0xFF24305B),
                                                      width: 1.2,
                                                    ),
                                            ),
                                          ),
                                          child: Text(
                                            "Buy Now",
                                            style: TextStyle(
                                              fontFamily: "Arial",
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        }),

                        const SizedBox(height: 20),

                        /// PRICE TEXT
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: "Starts at ₹ ",
                                style: TextStyle(
                                  fontFamily: "Arial",
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),

                              /// Dynamic Price
                              TextSpan(
                                text: selectedPlanIndex != null
                                    ? "${subScriptionController.subScription.value?.subscriptionPlans?[selectedPlanIndex!].planPrice ?? ''}"
                                    : "--",
                                style: const TextStyle(
                                  fontFamily: "Arial",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),

                              const TextSpan(
                                text: " per Month",
                                style: TextStyle(
                                  fontFamily: "Arial",
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
