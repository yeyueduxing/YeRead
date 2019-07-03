class ComicHomeListEntity {
	ComicHomeListData data;
	String message;
	int status;

	ComicHomeListEntity({this.data, this.message, this.status});

	ComicHomeListEntity.fromJson(Map<String, dynamic> json) {
		data = json['data'] != null ? new ComicHomeListData.fromJson(json['data']) : null;
		message = json['message'];
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.data != null) {
      data['data'] = this.data.toJson();
    }
		data['message'] = this.message;
		data['status'] = this.status;
		return data;
	}
}

class ComicHomeListData {
	List<ComicHomeListDataBook> book;
	String name;

	ComicHomeListData({this.book, this.name});

	ComicHomeListData.fromJson(Map<String, dynamic> json) {
		if (json['book'] != null) {
			book = new List<ComicHomeListDataBook>();(json['book'] as List).forEach((v) { book.add(new ComicHomeListDataBook.fromJson(v)); });
		}
		name = json['name'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.book != null) {
      data['book'] =  this.book.map((v) => v.toJson()).toList();
    }
		data['name'] = this.name;
		return data;
	}
}

class ComicHomeListDataBook {
	String versionEnd;
	int advertiseSdktype;
	int unionType;
	List<String> versionNum;
	int ordernum;
	int bookId;
	String title;
	int bookcomicImgstyle;
	List<ComicHomeListDataBookComicInfo> comicInfo;
	int bookDatasource;
	int bookIntellrecommend;
	int versionFilter;
	String advertiseLocation;
	int istop;
	int bookcomicOrder;
	int unionId;
	int siteid;
	ComicHomeListDataBookConfig config;

	ComicHomeListDataBook({this.versionEnd, this.advertiseSdktype, this.unionType, this.versionNum, this.ordernum, this.bookId, this.title, this.bookcomicImgstyle, this.comicInfo, this.bookDatasource, this.bookIntellrecommend, this.versionFilter, this.advertiseLocation, this.istop, this.bookcomicOrder, this.unionId, this.siteid, this.config});

	ComicHomeListDataBook.fromJson(Map<String, dynamic> json) {
		versionEnd = json['version_end'];
		advertiseSdktype = json['advertise_sdktype'];
		unionType = json['union_type'];
		versionNum = json['version_num']?.cast<String>();
		ordernum = json['ordernum'];
		bookId = json['book_id'];
		title = json['title'];
		bookcomicImgstyle = json['bookcomic_imgstyle'];
		if (json['comic_info'] != null) {
			comicInfo = new List<ComicHomeListDataBookComicInfo>();(json['comic_info'] as List).forEach((v) { comicInfo.add(new ComicHomeListDataBookComicInfo.fromJson(v)); });
		}
		bookDatasource = json['book_datasource'];
		bookIntellrecommend = json['book_intellrecommend'];
		versionFilter = json['version_filter'];
		advertiseLocation = json['advertise_location'];
		istop = json['istop'];
		bookcomicOrder = json['bookcomic_order'];
		unionId = json['union_id'];
		siteid = json['siteid'];
		config = json['config'] != null ? new ComicHomeListDataBookConfig.fromJson(json['config']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['version_end'] = this.versionEnd;
		data['advertise_sdktype'] = this.advertiseSdktype;
		data['union_type'] = this.unionType;
		data['version_num'] = this.versionNum;
		data['ordernum'] = this.ordernum;
		data['book_id'] = this.bookId;
		data['title'] = this.title;
		data['bookcomic_imgstyle'] = this.bookcomicImgstyle;
		if (this.comicInfo != null) {
      data['comic_info'] =  this.comicInfo.map((v) => v.toJson()).toList();
    }
		data['book_datasource'] = this.bookDatasource;
		data['book_intellrecommend'] = this.bookIntellrecommend;
		data['version_filter'] = this.versionFilter;
		data['advertise_location'] = this.advertiseLocation;
		data['istop'] = this.istop;
		data['bookcomic_order'] = this.bookcomicOrder;
		data['union_id'] = this.unionId;
		data['siteid'] = this.siteid;
		if (this.config != null) {
      data['config'] = this.config.toJson();
    }
		return data;
	}
}

class ComicHomeListDataBookComicInfo {
	String comicName;
	int comicId;
	String score;
	int updateTime;
	String totalViewNum;
	String imgUrl;
	double pingfen;
	String lastComicChapterName;
	int ordernum;
	List<String> comicType;
	String content;
	String url;

	ComicHomeListDataBookComicInfo({this.comicName, this.comicId, this.score, this.updateTime, this.totalViewNum, this.imgUrl, this.pingfen, this.lastComicChapterName, this.ordernum, this.comicType, this.content, this.url});

	ComicHomeListDataBookComicInfo.fromJson(Map<String, dynamic> json) {
		comicName = json['comic_name'];
		comicId = json['comic_id'];
		score = json['score'];
		updateTime = json['update_time'];
		totalViewNum = json['total_view_num'];
		imgUrl = json['img_url'];
		pingfen = json['pingfen'];
		lastComicChapterName = json['last_comic_chapter_name'];
		ordernum = json['ordernum'];
		comicType = json['comic_type']?.cast<String>();
		content = json['content'];
		url = json['url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['comic_name'] = this.comicName;
		data['comic_id'] = this.comicId;
		data['score'] = this.score;
		data['update_time'] = this.updateTime;
		data['total_view_num'] = this.totalViewNum;
		data['img_url'] = this.imgUrl;
		data['pingfen'] = this.pingfen;
		data['last_comic_chapter_name'] = this.lastComicChapterName;
		data['ordernum'] = this.ordernum;
		data['comic_type'] = this.comicType;
		data['content'] = this.content;
		data['url'] = this.url;
		return data;
	}
}

class ComicHomeListDataBookConfig {
	String displayType;
	int interwidth;
	int isshowchange;
	String horizonratio;
	int outerwidth;
	int isshowtitle;
	int orderType;
	int isautoslide;
	int isshowdetail;

	ComicHomeListDataBookConfig({this.displayType, this.interwidth, this.isshowchange, this.horizonratio, this.outerwidth, this.isshowtitle, this.orderType, this.isautoslide, this.isshowdetail});

	ComicHomeListDataBookConfig.fromJson(Map<String, dynamic> json) {
		displayType = json['display_type'];
		interwidth = json['interwidth'];
		isshowchange = json['isshowchange'];
		horizonratio = json['horizonratio'];
		outerwidth = json['outerwidth'];
		isshowtitle = json['isshowtitle'];
		orderType = json['order_type'];
		isautoslide = json['isautoslide'];
		isshowdetail = json['isshowdetail'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['display_type'] = this.displayType;
		data['interwidth'] = this.interwidth;
		data['isshowchange'] = this.isshowchange;
		data['horizonratio'] = this.horizonratio;
		data['outerwidth'] = this.outerwidth;
		data['isshowtitle'] = this.isshowtitle;
		data['order_type'] = this.orderType;
		data['isautoslide'] = this.isautoslide;
		data['isshowdetail'] = this.isshowdetail;
		return data;
	}
}
