import 'package:add_to_cart2/pages/show_add_to_cart.dart';
import 'package:add_to_cart2/providers/api_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:badges/badges.dart' as badges;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String truncateDescription(String description, int wordLimit) {
    List<String> words = description.split(' ');
    if (words.length > wordLimit) {
      return words.sublist(0, wordLimit).join(' ') + '...';
    } else {
      return description;
    }
  }

  @override
  Widget build(BuildContext context) {
    print("start builder");
    return Scaffold(
      appBar:
          AppBar(title: "Add to Cart".text.make(), centerTitle: true, actions: [
        Consumer<ApiProviders>(
          builder: (context, value, child) => InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ShowAddToCart()));
            },
            child: badges.Badge(
              badgeContent: Text(value.addCarts.length.toString()),
              badgeAnimation: const badges.BadgeAnimation.slide(
                animationDuration: Duration(seconds: 1),
              ),
              child: const Icon(Icons.add_shopping_cart_rounded),
            ),
          ),
        ),
        const SizedBox(
          width: 30,
        )
      ]),
      body: SafeArea(
        child: Consumer<ApiProviders>(
          builder: (context, value, child) {
            print("consumer");
            if (value.apiDataResponse.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: value.apiDataResponse.length,
                itemBuilder: (context, index) {
                  final resData = value.apiDataResponse[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Card(
                        color: Colors.white,
                        elevation: 20,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 8),
                          child: Row(
                            children: [
                              Image.network(resData['image']).wh(140, 110),
                              const SizedBox(
                                  width:
                                      10), // Add spacing between the image and the text
                              Expanded(
                                // Use Expanded here to avoid overflow
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    "${resData['title']}"
                                        .text
                                        .xl
                                        .black
                                        .make()
                                        .pOnly(bottom: 4),
                                    truncateDescription(
                                            resData['description'], 10)
                                        .text
                                        .make(),
                                    Row(
                                      children: [
                                        "Stocks: ".text.semiBold.black.make(),
                                        "${resData['rating']['count']}"
                                            .text
                                            .make()
                                            .py(4),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        ...List.generate(5, (index) {
                                          return Icon(index <
                                                  resData['rating']['rate']
                                                      .round()
                                              ? Icons.star
                                              : Icons.star_border);
                                        })
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        "\$${resData['price']}"
                                            .text
                                            .xl2
                                            .bold
                                            .color(Colors.deepPurple)
                                            .make(),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              elevation: 30,
                                            ),
                                            onPressed: () {
                                              value.addToCart(resData, context);
                                              setState(() {});
                                            },
                                            child:
                                                const Icon(Icons.shopping_cart))
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                  );
                });
          },
        ),
      ),
    );
  }
}
