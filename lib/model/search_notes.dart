import 'package:flutter/cupertino.dart';

class SearchNotes extends ChangeNotifier{
  List<FileDetails>fileDetails=[];
  List<String>searchKeys=[];
  void storeFiles(var json){
    fileDetails.add(FileDetails().fromJson(json));
    notifyListeners();
  }
  void storeKeys(var key){
    searchKeys.add(key);
  }
  void clearKeys(){
    searchKeys.clear();
  }
  void clearFiles(){
    fileDetails.clear();
  }
}

class FileDetails {
  String? name;
  String? url;
  String? author;
  String? edition;
  String? grade;
  String? searchKey;
  fromJson(var json){
    name=json['file_name'];
    url=json["url"];
    edition=json['edition'];
    author=json['author_name'];
    grade=json['grade'];
    searchKey=json['search_key'];
  }

}