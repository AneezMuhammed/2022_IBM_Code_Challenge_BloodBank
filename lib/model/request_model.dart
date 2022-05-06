class RequestModel{
  String description;
  String quantity;
  String blood_grp;
  double latitude;
  double longitude;
  String uid;
  String request_id;
  RequestModel({this.description,this.quantity,this.blood_grp,this.latitude,this.longitude,this.uid,this.request_id});

  //data from server
  factory RequestModel.fromMap(map){
    return RequestModel(
      description: map['description'],
      quantity: map['quantity'],
      
      blood_grp: map['blood_grp'],
      latitude:map['latitude'],
      longitude: map['longitude'],
      uid: map['uid'],
      request_id: map['request_id']
    );


  }

  //sending to our server

  Map<String,dynamic> toMap(){
    return{
      'description':description,
      'quantity':quantity,
      'blood_grp':blood_grp,
      'latitude':latitude,
      'longitude':longitude,
      'uid':uid,
      'request_id':request_id

    };
  }
}