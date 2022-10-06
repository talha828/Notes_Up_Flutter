import 'package:flutter/cupertino.dart';


class StoreFile extends ChangeNotifier{
  List<FileDetails>list=[];
  getData(Map<String,dynamic> json){
    list.clear();
    for (var i in json.values){
      print(i['details']["file_name"]);
      list.add(FileDetails().fromJson(i));
    }
    notifyListeners();
  }
}
class FileDetails extends ChangeNotifier{
  String? name;
  String? url;
  String? author;
  String? edition;
  String? grade;
  String? searchKey;

  fromJson(var json){
    name=json['details']['file_name'];
    url=json['details']["url"];
    edition=json['details']['edition'];
    author=json['details']['author_name'];
    grade=json['details']['grade'];
    searchKey=json['details']['search_key'];
  }

}