class UserModel{
  String uid;
  String email;
  String name;
  String blood_grp;
  String phone;
  String address;
  bool isWilling;
   double latitude;
  double longitude;
  UserModel({this.uid,this.email,this.name,this.blood_grp,this.address,this.phone,this.isWilling,this.latitude,this.longitude});

  //data from server
  factory UserModel.fromMap(map){
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      blood_grp: map['blood_grp'],
      address: map['address'],
      phone: map['phone'],
      isWilling: map['isWilling'],
      latitude: map['latitude'],
      longitude: map['longitude']
    );


  }

  //sending to our server

  Map<String,dynamic> toMap(){
    return{
      'uid':uid,
      'email':email,
      'name':name,
      'blood_grp':blood_grp,
      'address':address,
      'phone':phone,
      'isWilling':isWilling,
      'latitude':latitude,
      'longitude':longitude
    };
  }
}