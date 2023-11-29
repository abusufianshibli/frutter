class Invoice {
  final String customer;
  final String address;
  final List<LineItem> items;
  final String phone;
  Invoice({required this.customer, required this.address, required this.items, required this.phone});
  double totalCost() {
    return items.fold(0, (previousValue, element) => previousValue + element.cost);
  }
}

class LineItem {
  final String description;
  final double cost;

  LineItem({required this.description, required this.cost});
}