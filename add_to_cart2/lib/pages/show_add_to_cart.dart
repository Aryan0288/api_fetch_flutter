import 'package:add_to_cart2/pages/home_page.dart';
import 'package:add_to_cart2/providers/api_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:badges/badges.dart' as badges;

class ShowAddToCart extends StatefulWidget {
  const ShowAddToCart({super.key});

  @override
  State<ShowAddToCart> createState() => _ShowAddToCartState();
}

class _ShowAddToCartState extends State<ShowAddToCart> {
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
    return Scaffold(
      appBar:
          AppBar(title: "All Carts".text.make(), centerTitle: true, actions: [
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
                animationDuration: Duration(seconds: 2),
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
            if (value.addCarts.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/empty_cart.png").py(32),
                    const SizedBox(width: 32),
                    ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        },
                        label: const Icon(Icons.home_outlined).scale(scaleValue: 2).p32())
                  ],
                ),
              );
            }
            return ListView.builder(
                itemCount: value.addCarts.length,
                itemBuilder: (context, index) {
                  final resData = value.addCarts[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Card(
                        elevation: 12,
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
                                          style:ElevatedButton.styleFrom(
                                            backgroundColor: Colors.deepPurpleAccent,
                                            iconColor: Colors.black,
                                            elevation: 30,
                                          ),
                                            onPressed: () {
                                              value.removeFromCart(resData);
                                            },
                                            child: Icon(
                                                Icons.delete_forever_rounded)),
                                            
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
