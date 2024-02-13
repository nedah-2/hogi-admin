import 'package:flutter/material.dart';
import 'package:hogi_milk_admin/providers/order_manager.dart';
import 'package:provider/provider.dart';

import '../models/order.dart';
import '../widgets/order_card.dart';

class SearchOrder extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back_outlined),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FoundOrderList(query: query.toLowerCase());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FoundOrderList(query: query.toLowerCase());
  }
}

class FoundOrderList extends StatelessWidget {
  const FoundOrderList({super.key, required this.query});
  final String query;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderManager>(context, listen: false);
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: provider.getFoundOrder(query).length,
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return OrderCard(
              order: provider.getFoundOrder(query)[index],
              isCancelled: provider.getFoundOrder(query)[index].status ==
                  OrderStatus.cancelled);
        });
  }
}
