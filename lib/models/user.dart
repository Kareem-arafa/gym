class User{
  final String name;
  final String phone;
  final String email;
   String uid;
   String profilePic;
   String gender;
   String role;
   List<String>follow=[];

  User({this.phone,this.email,this.gender,this.name,this.role,this.uid,this.profilePic,this.follow});

  String getName(){
    String userName=name;
    return userName;
  }

  String getid(){
    String userId=uid;
    return userId;
  }

  String getUrl(){
    String url=profilePic;
    return url;
  }

  String getPhone(){
    String userPhone=phone;
    return userPhone;
  }

  String getEmail(){
    String userEmail=email;
    return userEmail;
  }

  String getGender(){
    String userGender=gender;
    return userGender;
  }

  String getRole(){
    String userRole=role;
    return userRole;
  }

  List<String>getFollow(){
    return follow;
  }

}