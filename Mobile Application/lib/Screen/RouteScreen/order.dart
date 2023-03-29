import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp_app/Bloc/OrderBloc/order_bloc.dart';
import 'package:fyp_app/Model/model_export.dart';
import 'package:fyp_app/Screen/screen_export.dart';

class order extends StatelessWidget {
  final OrderRoute orderInfo;

  const order({Key? key, required this.orderInfo})
      : assert(order != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
      if (state is OrderInitial) {
        return Scaffold(
          appBar: AppBar(),
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      if (state is OrderLoaded) {
        List<OrderItems> orderItemsList = [];
        orderItemsList = state.orderItems;
        orderItemsList.insert(0, const OrderItems(productName: 'Product Name', productNumber: 'Product Number'));
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Name: ${orderInfo.first_name} ${orderInfo.last_name}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Phone Number: ${orderInfo.phone_number}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Deliver To: ${orderInfo.delivery1} ${orderInfo.delivery2}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Table(
                    columnWidths: const <int, TableColumnWidth>{
                      0: IntrinsicColumnWidth(),
                      1: IntrinsicColumnWidth(),
                    },
                    border: TableBorder.all(
                        color: Colors.black87,
                        width: 2.0,
                        style: BorderStyle.solid),
                    children: List<TableRow>.generate(
                      state.orderItems.length,
                      (index) {
                        final orderItem = orderItemsList[index];
                        return TableRow(children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              orderItem.productName,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              orderItem.productNumber,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 20),
                            ),
                          ),
                        ]);
                      },
                      growable: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
      return Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: Text('Fail'),
        ),
      );
    });
  }
}
