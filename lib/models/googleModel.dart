
// {
// "name": "Open Graph Test User",
// "email": "open_jygexjs_user@tfbnw.net",
// "picture": {
// "data": {
// "height": 126,
// "url": "https://scontent.fuio21-1.fna.fbcdn.net/v/t1.30497-1/s200x200/84628273_176159830277856_972693363922829312_n.jpg",
// "width": 200
// }
// },
// "id": "136742241592917"
// }
import 'package:flutter/foundation.dart';

class GoogleModel{
  final String ?name;
  final String ?email;
  final String ?id;
  final String ?image;

  GoogleModel({this.name, this.email, this.id, this.image});
  factory GoogleModel.fromjson(Map<String,dynamic>json)=>
      GoogleModel(
        name:json['name'] ,
        email:json['email'],
        id:json['uid'],
        image: json['image']
      );

  Map<String,dynamic> toMap(){
    return{
      'email':email,
      'name':name,
      'image':image,
      'id':id,
    };
  }
  }


