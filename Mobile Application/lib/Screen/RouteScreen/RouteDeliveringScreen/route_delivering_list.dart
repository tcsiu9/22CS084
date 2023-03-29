import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:fyp_app/Model/model_export.dart';
import 'package:fyp_app/Bloc/bloc_export.dart';
import 'package:fyp_app/Screen/RouteScreen/order.dart';

class RouteDeliveringList extends StatelessWidget {
  final RouteLoaded state;
  final String route_uuid;

  const RouteDeliveringList(
      {Key? key, required this.state, required this.route_uuid})
      : assert(state != null),
        assert(route_uuid != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, OrderRoute> routes = state.routes;
    List<OrderStatus> orderStatus = state.status['delivering']!.values.toList();

    return Expanded(
      child: orderStatus.isNotEmpty
          ? ListView.builder(
              itemCount: orderStatus.length,
              itemBuilder: (BuildContext context, int index) {
                OrderStatus status = orderStatus[index];
                OrderRoute route = routes[status.uuid]!;
                return (index < orderStatus.length - 1)
                    ? SizedBox(
                        height: 130,
                        width: MediaQuery.of(context).size.width - 32,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => order(orderInfo: route)));
                            BlocProvider.of<OrderBloc>(context)
                                .add(OrderFetched(route_uuid: route.uuid));
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: 24,
                                    width: 24,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 3,
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    child: const CircleAvatar(
                                      backgroundColor: Colors.black,
                                    ),
                                  ),
                                  const Flexible(
                                    child: DottedLine(
                                      direction: Axis.vertical,
                                      dashColor: Colors.grey,
                                      lineThickness: 2,
                                      dashGapLength: 4,
                                      dashLength: 8,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 28,
                                          width: 28,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text((index + 1).toString()),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          'Ship to: ${route.first_name} ${route.last_name}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      children: [
                                        const CircleAvatar(
                                          radius: 16,
                                          backgroundColor: Colors.black,
                                          foregroundColor: Colors.white,
                                          child: Icon(
                                            Icons.route,
                                            size: 14,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Flexible(
                                          child: Text(
                                            "${route.delivery1} ${route.delivery2}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ))
                    : SizedBox(
                        height: 130,
                        width: MediaQuery.of(context).size.width - 32,
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<OrderBloc>(context)
                                .add(OrderFetched(route_uuid: route.uuid));
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => order(orderInfo: route)));
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: 24,
                                    width: 24,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 3,
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    child: const CircleAvatar(
                                      backgroundColor: Colors.black,
                                    ),
                                  ),
                                  // const Flexible(
                                  //   child: DottedLine(
                                  //     // dashGapLength: 8,
                                  //     // lineLength: ,
                                  //     direction: Axis.vertical,
                                  //     dashColor: Colors.grey,
                                  //     lineThickness: 2,
                                  //     dashGapLength: 4,
                                  //     dashLength: 8,
                                  //   ),
                                  // ),
                                ],
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 28,
                                          width: 28,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text((index + 1).toString()),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          'Ship to: ${route.first_name} ${route.last_name}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      children: [
                                        const CircleAvatar(
                                          radius: 16,
                                          backgroundColor: Colors.black,
                                          foregroundColor: Colors.white,
                                          child: Icon(
                                            Icons.route,
                                            size: 14,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Flexible(
                                          child: Text(
                                            "${route.delivery1} ${route.delivery2}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ));
              },
            )
          : const Center(child: Text('Empty')),
    );
  }
}
