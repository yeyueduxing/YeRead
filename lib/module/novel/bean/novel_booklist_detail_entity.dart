import 'package:tianyue/module/novel/bean/novel_author.dart';
import 'package:tianyue/module/novel/bean/novel_book.dart';

class NovelBooklistDetailEntity {
	bool ok;
	NovelBooklistDetailBooklist bookList;

	NovelBooklistDetailEntity({this.ok, this.bookList});

	NovelBooklistDetailEntity.fromJson(Map<String, dynamic> json) {
		print("不为空");
		ok = json['ok'];
		bookList = json['bookList'] != null ? new NovelBooklistDetailBooklist.fromJson(json['bookList']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['ok'] = this.ok;
		if (this.bookList != null) {
      data['bookList'] = this.bookList.toJson();
    }
		return data;
	}
}

class NovelBooklistDetailBooklist {
	dynamic isDistillate;
	int updateCount;
	String gender;
	NovelAuthor author;
	String created;
	String stickStopTime;
	bool isDraft;
	String shareLink;
	String title;
	List<String> tags;
	int total;
	List<NovelBooklistDetailBooklistBook> books;
	int collectorCount;
	String id;
	String sId;
	String updated;
	String desc;

	NovelBooklistDetailBooklist({this.isDistillate, this.updateCount, this.gender, this.author, this.created, this.stickStopTime, this.isDraft, this.shareLink, this.title, this.tags, this.total, this.books, this.collectorCount, this.id, this.sId, this.updated, this.desc});

	NovelBooklistDetailBooklist.fromJson(Map<String, dynamic> json) {
		isDistillate = json['isDistillate'];
		updateCount = json['updateCount'];
		gender = json['gender'];
		author = json['author'] != null ? new NovelAuthor.fromJson(json['author']) : null;
		created = json['created'];
		stickStopTime = json['stickStopTime'];
		isDraft = json['isDraft'];
		shareLink = json['shareLink'];
		title = json['title'];
		tags = json['tags']?.cast<String>();
		total = json['total'];
		if (json['books'] != null) {
			books = new List<NovelBooklistDetailBooklistBook>();(json['books'] as List).forEach((v) { books.add(new NovelBooklistDetailBooklistBook.fromJson(v)); });
		}
		collectorCount = json['collectorCount'];
		id = json['id'];
		sId = json['_id'];
		updated = json['updated'];
		desc = json['desc'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['isDistillate'] = this.isDistillate;
		data['updateCount'] = this.updateCount;
		data['gender'] = this.gender;
		if (this.author != null) {
      data['author'] = this.author.toJson();
    }
		data['created'] = this.created;
		data['stickStopTime'] = this.stickStopTime;
		data['isDraft'] = this.isDraft;
		data['shareLink'] = this.shareLink;
		data['title'] = this.title;
		data['tags'] = this.tags;
		data['total'] = this.total;
		if (this.books != null) {
      data['books'] =  this.books.map((v) => v.toJson()).toList();
    }
		data['collectorCount'] = this.collectorCount;
		data['id'] = this.id;
		data['_id'] = this.sId;
		data['updated'] = this.updated;
		data['desc'] = this.desc;
		return data;
	}
}

class NovelBooklistDetailBooklistBook {
	NovelBook book;
	String comment;

	NovelBooklistDetailBooklistBook({this.book, this.comment});

	NovelBooklistDetailBooklistBook.fromJson(Map<String, dynamic> json) {
		book = json['book'] != null ? new NovelBook.fromJson(json['book']) : null;
		comment = json['comment'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.book != null) {
      data['book'] = this.book.toJson();
    }
		data['comment'] = this.comment;
		return data;
	}
}

