import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:restaures/components/Global/api_response.dart';
import 'package:restaures/model/menu_item.dart';
import 'package:restaures/service/menu_service.dart';
import 'package:restaures/service/other_service.dart';
import 'package:restaures/widgets/custom_button.dart';
import 'package:toastification/toastification.dart';

class AddMenuRestaurantView extends StatefulWidget {
  const AddMenuRestaurantView({super.key});

  @override
  State<AddMenuRestaurantView> createState() => _AddMenuRestaurantViewState();
}

class _AddMenuRestaurantViewState extends State<AddMenuRestaurantView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController timeToPrepareController = TextEditingController();
  List<File> images = [];
  String selectedCategory = 'Starter';
  bool _isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? pickedFiles = await picker.pickMultiImage();

    if (pickedFiles != null) {
      setState(() {
        images.addAll(pickedFiles.map((file) => File(file.path)));
      });
    }
  }

  void removeImage(int index) {
    setState(() {
      images.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Menu Item'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: pickImages,
                  child: Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: Center(
                      child: images.isEmpty
                          ? const Text('Tap to add Images')
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: images.length,
                              itemBuilder: (context, index) => Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(8.0),
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: FileImage(images[index]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: IconButton(
                                      icon: const Icon(Icons.cancel,
                                          color: Colors.red),
                                      onPressed: () => removeImage(index),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: descriptionController,
                  maxLines: 4,
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Description is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Price (Rs.)'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Price is required';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Invalid price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: timeToPrepareController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Time to Prepare (mins)'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Time to Prepare is required';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Invalid time';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  items: [
                    'Starter',
                    'Main Course',
                    'Dessert',
                    'Beverage',
                    'Others'
                  ]
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value ?? 'Starter';
                    });
                  },
                  decoration: const InputDecoration(labelText: 'Category'),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: 'Add Item',
                  isLoading: _isLoading,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true;
                      });
                      List<String> imageURLs; // Placeholder for image URLs
                      if (images.isNotEmpty) {
                        ApiResponse response =
                            (await OtherService.uploadImage(files: images));

                        if (!response.success) {
                          toastification.show(
                            title: Text(response.message),
                            showIcon: true,
                            type: ToastificationType.error,
                            autoCloseDuration: const Duration(seconds: 5),
                          );
                          setState(() {
                            _isLoading = false;
                          });
                          return;
                        }
                        imageURLs =
                            response.data['fileUrls'].map<String>((url) {
                          return url.toString();
                        }).toList();
                      } else {
                        toastification.show(
                          title: const Text('Please add images'),
                          showIcon: true,
                          type: ToastificationType.error,
                          autoCloseDuration: const Duration(seconds: 5),
                        );

                        setState(() {
                          _isLoading = false;
                        });
                        return;
                      }
                      ApiResponse response = await MenuService.addMenu(
                        MenuItem(
                          category: selectedCategory,
                          images: imageURLs,
                          description: descriptionController.text.trim(),
                          name: nameController.text.trim(),
                          price: int.parse(priceController.text.trim()),
                          timeToPrepare:
                              int.parse(timeToPrepareController.text.trim()),
                        ),
                      );

                      if (response.success) {
                        toastification.show(
                          title: Text("Item Added"),
                          showIcon: true,
                          type: ToastificationType.success,
                          autoCloseDuration: const Duration(seconds: 5),
                        );
                      }

                      setState(() {
                        _isLoading = false;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
