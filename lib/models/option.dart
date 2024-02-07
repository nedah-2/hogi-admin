class Option{
  final String count;
  final String price;

  Option({required this.count,required this.price});

  Map<String,dynamic> toJson(){
    return {
      'count': count,
      'price': price
    };
  }

  factory Option.fromJson(Map<String,dynamic> json){
    return Option(count: json['count'], price: json['price']);
  }
}