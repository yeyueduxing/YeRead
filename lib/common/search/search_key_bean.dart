import 'dart:convert' show json;


class SearchKeyBean {
  int errorCode;
  String errorMsg;
  String loadMsg;
  List<SearchKeyNode> nodes;
}

class SearchKeyNode {
  String name;
}
