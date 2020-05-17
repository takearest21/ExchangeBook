class CardList {
  int id;
  String title;
  String intro;
  String img;
  bool bookStatus;

  CardList(
      {this.id,
      this.title,
      this.intro,
      this.img,
      this.bookStatus});

  factory CardList.fromJson(Map<String, dynamic> json) {
    return new CardList(
      id: json['id'],
      title: json['title'],
      intro: json['intro'],
      img: json['img'],
      bookStatus: json['bookStatus'],
    );
  }
}
