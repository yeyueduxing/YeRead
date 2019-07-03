import 'package:tianyue/module/novel/bean/novel_book.dart';

class NovelCateInfoEntity {
  int total;
  List<NovelBook> books;
  bool ok;

  NovelCateInfoEntity({this.total, this.books, this.ok});

  NovelCateInfoEntity.fromJson(Map<String, dynamic> json) {
    print("不为空");
    total = json['total'];
    if (json['books'] != null) {
      books = new List<NovelBook>();
      (json['books'] as List).forEach((v) {
        books.add(new NovelBook.fromJson(v));
      });
    }
    print("不为空");
    ok = json['ok'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.books != null) {
      data['books'] = this.books.map((v) => v.toJson()).toList();
    }
    data['ok'] = this.ok;
    return data;
  }
}
