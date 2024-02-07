class Order{
  late final String id;
  final String name;
  final String phone;
  final String address;
  final String count;
  final String totalPrice;
  final String date;
  late final String status;

  Order({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.count,
    required this.totalPrice,
    required this.date,
    required this.status
  });

  Map<String, dynamic> toJson() {
    return {
      'name' : name,
      'phone' : phone,
      'address' : address,
      'count' : count,
      'total' : totalPrice,
      'date' : date,
      'status' : status
    };
  }

  factory Order.fromJson(String id, Map<String, dynamic> json) {
    return Order(
        id: id,
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      count: json['count'],
      totalPrice: json['total'],
      date: json['date'],
      status: json['status']
    );
  }
}

class OrderStatus{
  static String ordered = 'Ordered';
  static String cancelled = 'Cancelled';
  static String confirmed = 'Confirmed';
  static String delivered = 'Delivered';
}