
class RegisterModel{
  final String ?name;
  final String ?email;
  final String ?uid;

  RegisterModel({this.uid, this.name, this.email});
  factory RegisterModel.fromjson(Map<String,dynamic>json)=>
      RegisterModel(
        name:json['name'] ,
        email:json['email'],
        uid:json['uid'],
      );

  Map<String,dynamic> toMap(){
    return{
      'email':email,
      'name':name,

    };
  }
}


