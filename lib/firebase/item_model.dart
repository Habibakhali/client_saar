class ItemModel{
  String id;
  String url;
  String weight;
  String price;
  String strength;
  String name;

  ItemModel({this.id='',required this.url,required this.weight,required this.price,required this.strength,required this.name});
  Map<String, dynamic> toJson (){
    return {
      'id':id,
      "url": url,
      "weight": weight,
      "price": price,
      'strength':strength,
      'name':name,
    };
  }
  ItemModel.fromJson(Map<String, dynamic> json):this(
    id:json['id'],
    url:json['url'],weight:json['weight'],
    price:json['price'],
    strength:json['strength'],
    name:json['name'],
  );
}