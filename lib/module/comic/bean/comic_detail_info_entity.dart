class ComicDetailInfoEntity {
	String comicCopyright;
	int copyrightType;
	int chargeLimittimeFree;
	String comicNotice;
	String coverChargeStatus;
	int renqi;
	int chargeCoinFree;
	int chargeLotteryFree;
	int chargeGameFree;
	int chargeLimitlineFree;
	String updateStatusStr;
	int readtype;
	String comicAuthor;
	List<String> coverList;
	String comicDesc;
	String comicName;
	int updateTime;
	String chargeStatus;
	int chargePaid;
	int comicStatus;
	int humanType;
	String copyrightTypeCn;
	int chargeOthersPaid;
	int allprice;
	int chargeSpreadFree;
	int chargeShareFree;
	ComicDetailInfoComicType comicType;
	String comicMedia;
	int servicetime;
	String lastChapterId;
	int chargeVipFree;
	int isshowdata;
	int chargeFreeTurn;
	int shoucang;
	int chargeCreditPaid;
	List<ComicDetailInfoComicChapter> comicChapter;
	int chargeTruetimeFree;
	int chargeLimitlinePaid;
	String backgroundColor;
	List<ComicDetailInfoComicTypeNew> comicTypeNew;
	int chargeAdvertiseFree;
	String comicShareUrl;
	int chargeCouponsFree;
	int chargeLimittimePaid;

	ComicDetailInfoEntity({this.comicCopyright, this.copyrightType, this.chargeLimittimeFree, this.comicNotice, this.coverChargeStatus, this.renqi, this.chargeCoinFree, this.chargeLotteryFree, this.chargeGameFree, this.chargeLimitlineFree, this.updateStatusStr, this.readtype, this.comicAuthor, this.coverList, this.comicDesc, this.comicName, this.updateTime, this.chargeStatus, this.chargePaid, this.comicStatus, this.humanType, this.copyrightTypeCn, this.chargeOthersPaid, this.allprice, this.chargeSpreadFree, this.chargeShareFree, this.comicType, this.comicMedia, this.servicetime, this.lastChapterId, this.chargeVipFree, this.isshowdata, this.chargeFreeTurn, this.shoucang, this.chargeCreditPaid, this.comicChapter, this.chargeTruetimeFree, this.chargeLimitlinePaid, this.backgroundColor, this.comicTypeNew, this.chargeAdvertiseFree, this.comicShareUrl, this.chargeCouponsFree, this.chargeLimittimePaid});

	ComicDetailInfoEntity.fromJson(Map<String, dynamic> json) {
		comicCopyright = json['comic_copyright'];
		copyrightType = json['copyright_type'];
		chargeLimittimeFree = json['charge_limittime_free'];
		comicNotice = json['comic_notice'];
		coverChargeStatus = json['cover_charge_status'];
		renqi = json['renqi'];
		chargeCoinFree = json['charge_coin_free'];
		chargeLotteryFree = json['charge_lottery_free'];
		chargeGameFree = json['charge_game_free'];
		chargeLimitlineFree = json['charge_limitline_free'];
		updateStatusStr = json['update_status_str'];
		readtype = json['readtype'];
		comicAuthor = json['comic_author'];
		coverList = json['cover_list']?.cast<String>();
		comicDesc = json['comic_desc'];
		comicName = json['comic_name'];
		updateTime = json['update_time'];
		chargeStatus = json['charge_status'];
		chargePaid = json['charge_paid'];
		comicStatus = json['comic_status'];
		humanType = json['human_type'];
		copyrightTypeCn = json['copyright_type_cn'];
		chargeOthersPaid = json['charge_others_paid'];
		allprice = json['allprice'];
		chargeSpreadFree = json['charge_spread_free'];
		chargeShareFree = json['charge_share_free'];
		comicType = json['comic_type'] != null ? new ComicDetailInfoComicType.fromJson(json['comic_type']) : null;
		comicMedia = json['comic_media'];
		servicetime = json['servicetime'];
		lastChapterId = json['last_chapter_id'];
		chargeVipFree = json['charge_vip_free'];
		isshowdata = json['isshowdata'];
		chargeFreeTurn = json['charge_free_turn'];
		shoucang = json['shoucang'];
		chargeCreditPaid = json['charge_credit_paid'];
		if (json['comic_chapter'] != null) {
			comicChapter = new List<ComicDetailInfoComicChapter>();(json['comic_chapter'] as List).forEach((v) { comicChapter.add(new ComicDetailInfoComicChapter.fromJson(v)); });
		}
		chargeTruetimeFree = json['charge_truetime_free'];
		chargeLimitlinePaid = json['charge_limitline_paid'];
		backgroundColor = json['background_color'];
		if (json['comic_type_new'] != null) {
			comicTypeNew = new List<ComicDetailInfoComicTypeNew>();(json['comic_type_new'] as List).forEach((v) { comicTypeNew.add(new ComicDetailInfoComicTypeNew.fromJson(v)); });
		}
		chargeAdvertiseFree = json['charge_advertise_free'];
		comicShareUrl = json['comic_share_url'];
		chargeCouponsFree = json['charge_coupons_free'];
		chargeLimittimePaid = json['charge_limittime_paid'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['comic_copyright'] = this.comicCopyright;
		data['copyright_type'] = this.copyrightType;
		data['charge_limittime_free'] = this.chargeLimittimeFree;
		data['comic_notice'] = this.comicNotice;
		data['cover_charge_status'] = this.coverChargeStatus;
		data['renqi'] = this.renqi;
		data['charge_coin_free'] = this.chargeCoinFree;
		data['charge_lottery_free'] = this.chargeLotteryFree;
		data['charge_game_free'] = this.chargeGameFree;
		data['charge_limitline_free'] = this.chargeLimitlineFree;
		data['update_status_str'] = this.updateStatusStr;
		data['readtype'] = this.readtype;
		data['comic_author'] = this.comicAuthor;
		data['cover_list'] = this.coverList;
		data['comic_desc'] = this.comicDesc;
		data['comic_name'] = this.comicName;
		data['update_time'] = this.updateTime;
		data['charge_status'] = this.chargeStatus;
		data['charge_paid'] = this.chargePaid;
		data['comic_status'] = this.comicStatus;
		data['human_type'] = this.humanType;
		data['copyright_type_cn'] = this.copyrightTypeCn;
		data['charge_others_paid'] = this.chargeOthersPaid;
		data['allprice'] = this.allprice;
		data['charge_spread_free'] = this.chargeSpreadFree;
		data['charge_share_free'] = this.chargeShareFree;
		if (this.comicType != null) {
      data['comic_type'] = this.comicType.toJson();
    }
		data['comic_media'] = this.comicMedia;
		data['servicetime'] = this.servicetime;
		data['last_chapter_id'] = this.lastChapterId;
		data['charge_vip_free'] = this.chargeVipFree;
		data['isshowdata'] = this.isshowdata;
		data['charge_free_turn'] = this.chargeFreeTurn;
		data['shoucang'] = this.shoucang;
		data['charge_credit_paid'] = this.chargeCreditPaid;
		if (this.comicChapter != null) {
      data['comic_chapter'] =  this.comicChapter.map((v) => v.toJson()).toList();
    }
		data['charge_truetime_free'] = this.chargeTruetimeFree;
		data['charge_limitline_paid'] = this.chargeLimitlinePaid;
		data['background_color'] = this.backgroundColor;
		if (this.comicTypeNew != null) {
      data['comic_type_new'] =  this.comicTypeNew.map((v) => v.toJson()).toList();
    }
		data['charge_advertise_free'] = this.chargeAdvertiseFree;
		data['comic_share_url'] = this.comicShareUrl;
		data['charge_coupons_free'] = this.chargeCouponsFree;
		data['charge_limittime_paid'] = this.chargeLimittimePaid;
		return data;
	}
}

class ComicDetailInfoComicType {
	String jingpin;
	String rexue;
	String shenmo;
	String jingji;

	ComicDetailInfoComicType({this.jingpin, this.rexue, this.shenmo, this.jingji});

	ComicDetailInfoComicType.fromJson(Map<String, dynamic> json) {
		jingpin = json['jingpin'];
		rexue = json['rexue'];
		shenmo = json['shenmo'];
		jingji = json['jingji'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['jingpin'] = this.jingpin;
		data['rexue'] = this.rexue;
		data['shenmo'] = this.shenmo;
		data['jingji'] = this.jingji;
		return data;
	}
}

class ComicDetailInfoComicChapter {
	int islock;
	int isbuy;
	int downloadPrice;
	String webview;
	int showSpiltline;
	String chapterName;
	String rule;
	String sourceUrl;
	int chapterTopicId;
	int startNum;
	int price;
	String chapterShareUrl;
	String chapterDomain;
	int endNum;
	String chapterId;
	int createDate;
	ComicDetailInfoComicChapterChapterImage chapterImage;

	ComicDetailInfoComicChapter({this.islock, this.isbuy, this.downloadPrice, this.webview, this.showSpiltline, this.chapterName, this.rule, this.sourceUrl, this.chapterTopicId, this.startNum, this.price, this.chapterShareUrl, this.chapterDomain, this.endNum, this.chapterId, this.createDate, this.chapterImage});

	ComicDetailInfoComicChapter.fromJson(Map<String, dynamic> json) {
		islock = json['islock'];
		isbuy = json['isbuy'];
		downloadPrice = json['download_price'];
		webview = json['webview'];
		showSpiltline = json['show_spiltline'];
		chapterName = json['chapter_name'];
		rule = json['rule'];
		sourceUrl = json['source_url'];
		chapterTopicId = json['chapter_topic_id'];
		startNum = json['start_num'];
		price = json['price'];
		chapterShareUrl = json['chapter_share_url'];
		chapterDomain = json['chapter_domain'];
		endNum = json['end_num'];
		chapterId = json['chapter_id'];
		createDate = json['create_date'];
		chapterImage = json['chapter_image'] != null ? new ComicDetailInfoComicChapterChapterImage.fromJson(json['chapter_image']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['islock'] = this.islock;
		data['isbuy'] = this.isbuy;
		data['download_price'] = this.downloadPrice;
		data['webview'] = this.webview;
		data['show_spiltline'] = this.showSpiltline;
		data['chapter_name'] = this.chapterName;
		data['rule'] = this.rule;
		data['source_url'] = this.sourceUrl;
		data['chapter_topic_id'] = this.chapterTopicId;
		data['start_num'] = this.startNum;
		data['price'] = this.price;
		data['chapter_share_url'] = this.chapterShareUrl;
		data['chapter_domain'] = this.chapterDomain;
		data['end_num'] = this.endNum;
		data['chapter_id'] = this.chapterId;
		data['create_date'] = this.createDate;
		if (this.chapterImage != null) {
      data['chapter_image'] = this.chapterImage.toJson();
    }
		return data;
	}
}

class ComicDetailInfoComicChapterChapterImage {
	String high;
	String middle;
	String low;

	ComicDetailInfoComicChapterChapterImage({this.high, this.middle, this.low});

	ComicDetailInfoComicChapterChapterImage.fromJson(Map<String, dynamic> json) {
		high = json['high'];
		middle = json['middle'];
		low = json['low'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['high'] = this.high;
		data['middle'] = this.middle;
		data['low'] = this.low;
		return data;
	}
}

class ComicDetailInfoComicTypeNew {
	String name;
	int id;

	ComicDetailInfoComicTypeNew({this.name, this.id});

	ComicDetailInfoComicTypeNew.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['id'] = this.id;
		return data;
	}
}
