import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:restaures/components/Global/api_response.dart';
import 'package:restaures/model/enquiry.dart';
import 'package:restaures/service/enquiry_service.dart';
import 'package:restaures/widgets/custom_card.dart';
import 'package:toastification/toastification.dart';

class EnquiryRestaurantView extends StatefulWidget {
  const EnquiryRestaurantView({super.key});

  @override
  State<EnquiryRestaurantView> createState() => _EnquiryRestaurantViewState();
}

class _EnquiryRestaurantViewState extends State<EnquiryRestaurantView> {
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
    ApiResponse response = await EnquiryService.getRestaurantEnquiries();
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
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20)),
                                  ),
                                  builder: (context) {
                                    int waitMins = enquiry.menuId.timeToPrepare;
                                    return StatefulBuilder(
                                      builder: (context, setStateBottomSheet) {
                                        return SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              GFCard(
                                                boxFit: BoxFit.cover,
                                                title: GFListTile(
                                                  avatar: GFAvatar(
                                                    backgroundImage:
                                                        NetworkImage(enquiry
                                                            .menuId.images[0]),
                                                    shape:
                                                        GFAvatarShape.standard,
                                                  ),
                                                  titleText:
                                                      enquiry.menuId.name,
                                                  subTitleText:
                                                      "By ${enquiry.restaurantId.name}",
                                                  icon: const Icon(
                                                      Icons.fastfood,
                                                      color: GFColors.PRIMARY),
                                                ),
                                                content: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        TagWidget(
                                                          tagColor:
                                                              Colors.orange,
                                                          text: enquiry.status,
                                                          icon:
                                                              Icons.restaurant,
                                                          color: Colors.white,
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        TagWidget(
                                                          tagColor:
                                                              Colors.black,
                                                          text:
                                                              '${enquiry.quantity}',
                                                          icon: Icons
                                                              .shopping_cart,
                                                          color: Colors.white,
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        TagWidget(
                                                          tagColor:
                                                              Colors.white,
                                                          text:
                                                              '${enquiry.totalPrice}',
                                                          icon: Icons
                                                              .currency_rupee,
                                                          color: Colors.black,
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Text(
                                                      enquiry
                                                          .menuId.description,
                                                      style: const TextStyle(
                                                          fontSize: 16),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 5,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  const Spacer(),
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          if (waitMins > 1) {
                                                            setStateBottomSheet(
                                                                () {
                                                              waitMins--;
                                                            });
                                                          }
                                                        },
                                                        child:
                                                            Icon(Icons.remove),
                                                      ),
                                                      SizedBox(width: 5),
                                                      Text(
                                                        "$waitMins mins",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      SizedBox(width: 5),
                                                      InkWell(
                                                        onTap: () {
                                                          setStateBottomSheet(
                                                              () {
                                                            waitMins++;
                                                          });
                                                        },
                                                        child: Icon(Icons.add),
                                                      ),
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  GFButton(
                                                    size: GFSize.LARGE,
                                                    onPressed: () async {
                                                      ApiResponse response =
                                                          await EnquiryService
                                                              .updateEnquiryStatus(
                                                                  enquiry.id,
                                                                  "Accepted",
                                                                  waitMins);

                                                      if (response.success) {
                                                        toastification.show(
                                                          title: Text(
                                                              'Enquiry Sent successfully'),
                                                          showIcon: true,
                                                          type:
                                                              ToastificationType
                                                                  .success,
                                                          autoCloseDuration:
                                                              const Duration(
                                                                  seconds: 5),
                                                        );
                                                        getEnquiries();
                                                      }
                                                      Navigator.pop(context);
                                                    },
                                                    text: "Send",
                                                    color: Colors.blueAccent,
                                                  ),
                                                  const SizedBox(width: 15),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                            ],
                                          ),
                                        );
                                      },
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
                                  Text("By ${enquiry.customerId.firstName}"),
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
                              title: Text(enquiry.menuId.name),
                              description:
                                  Text("By ${enquiry.restaurantId.name}"),
                              icon: TagWidget(
                                  color: Colors.white,
                                  text: "Accepted",
                                  icon: Icons.check,
                                  tagColor: Colors.green),
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
                                  Text("By ${enquiry.customerId.firstName}"),
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
