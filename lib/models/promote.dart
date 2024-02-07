class PromoteImage{
  final String id;
  final String image;
  PromoteImage({required this.id,required this.image});

  Map<String, dynamic> toJson() {
    return {
      'image' : image
    };
  }

  factory PromoteImage.fromJson(String id,Map<String, dynamic> json){
    return PromoteImage(id: id, image: json['image']);
  }
}