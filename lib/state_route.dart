import 'package:api_fetch/state_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class StateRoute extends StatefulWidget {
  const StateRoute({super.key, required this.count});

  final count;

  @override
  State<StateRoute> createState() => _StateRouteState();
}

class _StateRouteState extends State<StateRoute> {
  late int counter;

  @override
  void initState() {
    super.initState();
    counter = widget.count;
  }

  add() {
    setState(() {
      counter = counter + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Consumer<StateProvider>(
          builder: ((context, value, child) => Column(
                children: [
                  Text(value.count.last.toString()),
                  value.sliderValue.toStringAsFixed(2).text.xl4.make(),
                  Slider(
                      value: value.sliderValue,
                      onChanged: value.sliderOnChanged,
                      min: 10.0,
                      max: 100.0,
                    ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: value.count.length,
                      itemBuilder: (context, index) {
                        // final item = items[index];
                        // final image = item['picture']['thumbnail'];
                        final listItem = value.count[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Text(listItem.toString()),
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FloatingActionButton(
                            onPressed: value.add,
                            child: const Icon(Icons.add),
                          ),
                          FloatingActionButton(
                            onPressed: value.sub,
                            child: const Icon(Icons.remove),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
