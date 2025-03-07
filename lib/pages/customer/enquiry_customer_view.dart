import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:restaures/components/Global/api_response.dart';
import 'package:restaures/model/enquiry.dart';
import 'package:restaures/service/enquiry_service.dart';
import 'package:restaures/widgets/custom_card.dart';
import 'package:slider_button/slider_button.dart';
import 'package:toastification/toastification.dart';

class EnquiryCustomerView extends StatefulWidget {
  const EnquiryCustomerView({super.key});

  @override
  State<EnquiryCustomerView> createState() => _EnquiryCustomerViewState();
}

class _EnquiryCustomerViewState extends State<EnquiryCustomerView> {
  bool _isLoading = false;
  late List<EnquiryModel> enquiries;

  List<EnquiryModel> pendingEnquiries = [];
  List<EnquiryModel> acceptedEnquiries = [];
  List<EnquiryModel> orderEnquiries = [];
  @override
  void initState() {
    getEnquiries();
    super.initState();
  }

  void getEnquiries() async {
    setState(() {
      _isLoading = true;
    });
    // get enquiries
    ApiResponse response = await EnquiryService.getCustomerEnquiries();
    if (response.success) {
      List<EnquiryModel> items = [];
      response.data.forEach((item) {
        items.add(EnquiryModel.fromJson(item));
      });

      setState(() {
        enquiries = items;
        pendingEnquiries =
            enquiries.where((element) => element.status == "Pending").toList();
        acceptedEnquiries =
            enquiries.where((element) => element.status == "Accepted").toList();
        orderEnquiries = enquiries
            .where((element) => element.status == "Confirmed")
            .toList();
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  const TabBar(
                    tabs: [
                      Tab(text: "Pending"),
                      Tab(text: "Accepted"),
                      Tab(text: "Order")
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        ListView.builder(
                          itemCount: pendingEnquiries.length,
                          itemBuilder: (context, index) {
                            EnquiryModel enquiry = pendingEnquiries[index];
                            return GFListTile(
                              shadow: BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                              onTap: () {
                                // show enquiry details bottom sheet

                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20)),
                                  ),
                                  builder: (context) {
                                    return SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          GFCard(
                                            boxFit: BoxFit.cover,
                                            title: GFListTile(
                                              avatar: GFAvatar(
                                                backgroundImage: NetworkImage(
                                                    enquiry.menuId.images[0]),
                                                shape: GFAvatarShape.standard,
                                              ),
                                              titleText: enquiry.menuId.name,
                                              subTitleText:
                                                  "By ${enquiry.restaurantId.name}",
                                              icon: const Icon(Icons.fastfood,
                                                  color: GFColors.PRIMARY),
                                            ),
                                            content: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    TagWidget(
                                                      tagColor: Colors.orange,
                                                      text: enquiry.status,
                                                      icon: Icons.restaurant,
                                                      color: Colors.white,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    TagWidget(
                                                      tagColor: Colors.black,
                                                      text:
                                                          '${enquiry.quantity}',
                                                      icon: Icons.shopping_cart,
                                                      color: Colors.white,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    TagWidget(
                                                      tagColor: Colors.white,
                                                      text:
                                                          '${enquiry.totalPrice}',
                                                      icon:
                                                          Icons.currency_rupee,
                                                      color: Colors.black,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  enquiry.menuId.description,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 5,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              avatar: GFAvatar(
                                backgroundImage:
                                    NetworkImage(enquiry.menuId.images[0]),
                                shape: GFAvatarShape.standard,
                              ),
                              title: Text(enquiry.menuId.name),
                              description:
                                  Text("By ${enquiry.restaurantId.name}"),
                              icon: TagWidget(
                                  color: Colors.white,
                                  text: "Pending",
                                  icon: Icons.timer,
                                  tagColor: Colors.orange),
                            );
                          },
                        ),
                        ListView.builder(
                          itemCount: acceptedEnquiries.length,
                          itemBuilder: (context, index) {
                            EnquiryModel enquiry = acceptedEnquiries[index];
                            return GFListTile(
                              avatar: GFAvatar(
                                backgroundImage:
                                    NetworkImage(enquiry.menuId.images[0]),
                              ),
                              title: Text(
                                enquiry.menuId.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              description: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "ETA ${enquiry.menuId.timeToPrepare}m",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text("By ${enquiry.restaurantId.name}"),
                                ],
                              ),
                              icon: TagWidget(
                                  color: Colors.white,
                                  text: "Accepted",
                                  icon: Icons.check,
                                  tagColor: Colors.green),
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20)),
                                  ),
                                  builder: (context) {
                                    return SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          GFCard(
                                            boxFit: BoxFit.cover,
                                            title: GFListTile(
                                              avatar: GFAvatar(
                                                backgroundImage: NetworkImage(
                                                    enquiry.menuId.images[0]),
                                                shape: GFAvatarShape.standard,
                                              ),
                                              titleText: enquiry.menuId.name,
                                              subTitleText:
                                                  "By ${enquiry.restaurantId.name}",
                                              icon: const Icon(Icons.fastfood,
                                                  color: GFColors.PRIMARY),
                                            ),
                                            content: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    TagWidget(
                                                      tagColor: Colors.green,
                                                      text: enquiry.status,
                                                      icon: Icons.restaurant,
                                                      color: Colors.white,
                                                    ),
                                                    // ETA
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    TagWidget(
                                                      tagColor: Colors.black,
                                                      text:
                                                          '${enquiry.menuId.timeToPrepare}m',
                                                      icon: Icons.timer,
                                                      color: Colors.white,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    TagWidget(
                                                      tagColor: Colors.black,
                                                      text:
                                                          '${enquiry.quantity}',
                                                      icon: Icons.shopping_cart,
                                                      color: Colors.white,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    TagWidget(
                                                      tagColor: Colors.white,
                                                      text:
                                                          '${enquiry.totalPrice}',
                                                      icon:
                                                          Icons.currency_rupee,
                                                      color: Colors.black,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  enquiry.menuId.description,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 5,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: SliderButton(
                                              width: double.infinity,
                                              action: () async {
                                                setState(() {
                                                  _isLoading = true;
                                                });
                                                ApiResponse response =
                                                    await EnquiryService
                                                        .updateEnquiryCustomerStatus(
                                                            enquiry.id,
                                                            "Confirmed",
                                                            enquiry
                                                                .timeToPrepare);

                                                if (response.success) {
                                                  toastification.show(
                                                    title:
                                                        Text("Order Confirmed"),
                                                    showIcon: true,
                                                    type: ToastificationType
                                                        .success,
                                                    autoCloseDuration:
                                                        const Duration(
                                                            seconds: 5),
                                                  );
                                                  getEnquiries();
                                                  setState(() {
                                                    _isLoading = false;
                                                  });
                                                  Navigator.pop(context);
                                                }
                                                return false;
                                              },
                                              label: Text(
                                                "Slide to pay for your order",
                                                style: TextStyle(
                                                    color: Color(0xff4a4a4a),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 17),
                                              ),
                                              icon: Icon(Icons.send_outlined,
                                                  color: Colors.white),
                                              buttonColor: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),

                        // Order Enquiries
                        ListView.builder(
                          itemCount: orderEnquiries.length,
                          itemBuilder: (context, index) {
                            EnquiryModel enquiry = orderEnquiries[index];
                            return GFListTile(
                              avatar: GFAvatar(
                                backgroundImage:
                                    NetworkImage(enquiry.menuId.images[0]),
                              ),
                              title: Text(enquiry.menuId.name),
                              description:
                                  Text("By ${enquiry.restaurantId.name}"),
                              icon: TagWidget(
                                  color: Colors.white,
                                  text: "Order",
                                  icon: Icons.shopping_cart,
                                  tagColor: Colors.blue),
                            );
                          },
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
