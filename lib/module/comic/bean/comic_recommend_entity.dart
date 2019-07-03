class ComicRecommendEntity {
	String cartoonName;
	int cartoonId;

	ComicRecommendEntity({this.cartoonName, this.cartoonId});

	ComicRecommendEntity.fromJson(Map<String, dynamic> json) {
		cartoonName = json['cartoon_name'];
		cartoonId = json['cartoon_id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['cartoon_name'] = this.cartoonName;
		data['cartoon_id'] = this.cartoonId;
		return data;
	}
}
