class Option{
  late final String id;
  final String count;
  final String price;

  Option({required this.id,required this.count,required this.price});

  Map<String,dynamic> toJson(){
    return {
      'count': count,
      'price': price
    };
  }

  factory Option.fromJson(String id,Map<String,dynamic> json){
    return Option(id: id, count: json['count'], price: json['price']);
  }
}