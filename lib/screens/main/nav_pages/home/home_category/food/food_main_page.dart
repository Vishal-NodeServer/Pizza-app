import 'package:flutter/material.dart';
import 'package:pizza_app/data/food_data.dart';
import 'package:pizza_app/screens/main/nav_pages/home/home_category/food/food_detail_page.dart';
import '../../../../../../theme/style.dart';

class FoodMainPage extends StatefulWidget {
  const FoodMainPage({super.key});

  @override
  State<FoodMainPage> createState() => _FoodMainPageState();
}

class _FoodMainPageState extends State<FoodMainPage> {
  int _currentSelectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Text(
                "Categories",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _singleCategoryItemWidget(
                    title: "Pizza",
                    color: _currentSelectedCategory == 0
                        ? primaryColorED6E1B
                        : Colors.grey[400],
                    onTap: () {
                      setState(() {
                        _currentSelectedCategory = 0;
                      });
                    },
                  ),
                  _singleCategoryItemWidget(
                    title: "Combo Pack",
                    color: _currentSelectedCategory == 1
                        ? primaryColorED6E1B
                        : Colors.grey[400],
                    onTap: () {
                      setState(() {
                        _currentSelectedCategory = 1;
                      });
                    },
                  ),
                  _singleCategoryItemWidget(
                    title: "Beverage",
                    color: _currentSelectedCategory == 2
                        ? primaryColorED6E1B
                        : Colors.grey[400],
                    onTap: () {
                      setState(() {
                        _currentSelectedCategory = 2;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Text(
                "Special",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _switchSpecialCategoryOnSelectedIndex(_currentSelectedCategory),
              const SizedBox(height: 20),
              const Text(
                "Popular Now",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              _switchPopularCategoryOnSelectedIndex(_currentSelectedCategory),
              const SizedBox(height: 20),
              const Text(
                "More Items",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              _switchVerticalListOnSelectedIndex(_currentSelectedCategory),
            ],
          ),
        ),
      ),
    );
  }

  _singleCategoryItemWidget({
    VoidCallback? onTap,
    Color? color,
    String? title,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: 110,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color,
          ),
          child: Center(
            child: Text(
              "$title",
              style: const TextStyle(color: whiteColor),
            ),
          ),
        ),
      ),
    );
  }

  // SWITCH SPECIAL LIST
  _switchSpecialCategoryOnSelectedIndex(int index) {
    switch (index) {
      case 0:
        return _buildFoodList(
          PIZZA_POPULAR_LIST,
          deliveryFee: 50,
          deliveryTime: "20 - 40 min",
        );
      case 1:
        return _buildFoodList(
          PIZZA_SPECIAL_LIST,
          deliveryFee: 50,
          deliveryTime: "20 - 40 min",
        );
      case 2:
        return _buildFoodList(
          PIZZA_SPECIAL_COMBO_LIST,
          deliveryFee: 50,
          deliveryTime: "20 - 40 min",
        );
    }
  }

  // Build food list for Special category
  _buildFoodList(List foodList,
      {required int deliveryFee, required String deliveryTime}) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: foodList.length,
        itemBuilder: (context, index) {
          var foodItem = foodList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodDetailPage(data: foodItem),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(
                  right: 10), // Adds spacing between the items
              width: 300, // Fixes the width of each item
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(15), // Rounded corners
                      image: DecorationImage(
                        image: AssetImage("assets/${foodItem['image']}"),
                        fit: BoxFit
                            .cover, // Ensure the image covers the container
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${foodItem['title']}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "\₹${foodItem['price']} Delivery Fee $deliveryFee, $deliveryTime",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey[350],
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text("${foodItem['rating']}"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // SWITCH POPULAR LIST
  _switchPopularCategoryOnSelectedIndex(int index) {
    switch (index) {
      case 0:
        return _buildPopularFoodList(PIZZA_POPULAR_LIST);
      case 1:
        return _buildPopularFoodList(PIZZA_SPECIAL_COMBO_LIST);
      case 2:
        return _buildPopularFoodList(BEVERAGE_SPECIAL_LIST);
    }
  }

  // Build food list for Popular category
  _buildPopularFoodList(List foodList) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: foodList.length,
        itemBuilder: (context, index) {
          var foodItem = foodList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodDetailPage(data: foodItem),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(
                  right: 10), // Adds spacing between the items
              width: 180, // Fixes the width of each item
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(15), // Rounded corners
                          image: DecorationImage(
                            image: AssetImage("assets/${foodItem['image']}"),
                            fit: BoxFit
                                .cover, // Ensure the image covers the container
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Container(
                          width: 50,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: redColor,
                          ),
                          child: Center(
                            child: Text(
                              "\₹${foodItem['price']}", // Use price from foodItem
                              style: const TextStyle(color: whiteColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${foodItem['title']}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // SWITCH VERTICAL LIST
  _switchVerticalListOnSelectedIndex(int index) {
    switch (index) {
      case 0:
        return _buildVerticalList(PIZZA_POPULAR_LIST);
      case 1:
        return _buildVerticalList(PIZZA_SPECIAL_COMBO_LIST);
      case 2:
        return _buildVerticalList(BEVERAGE_SPECIAL_LIST);
    }
  }

  _buildVerticalList(List foodList) {
    if (foodList.isEmpty) {
      return Center(child: Text('No items available.'));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: foodList.length > 5 ? 5 : foodList.length,
      itemBuilder: (context, index) {
        var foodItem = foodList[index];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          leading: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage("assets/${foodItem['image']}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            "${foodItem['title']}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text("\₹${foodItem['price']}"), // Use price from foodItem
          trailing: Text(
            "${foodItem['rating']}",
            style: TextStyle(color: Colors.grey[700]),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FoodDetailPage(data: foodItem),
              ),
            );
          },
        );
      },
    );
  }
}
