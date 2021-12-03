class RedditScrapedDataList {
  final List<RedditScrapedData> scrapedUsers;

  RedditScrapedDataList({this.scrapedUsers});

  factory RedditScrapedDataList.fromJSON(Map<String, dynamic> json) {
    print("ALL USER DATA!!");
    Iterable usersData = json['data'];
    List<RedditScrapedData> scrapedData =
        usersData.map((usr) => RedditScrapedData.fromJSON(usr)).toList();

    return RedditScrapedDataList(
      scrapedUsers: scrapedData,
    );
  }
}

class RedditScrapedData {
  final String username;
  final String profileUrl;

  RedditScrapedData({
    this.username,
    this.profileUrl,
  });

  factory RedditScrapedData.fromJSON(Map<String, dynamic> json) {
    print("PER USER DATA!!");
    return RedditScrapedData(
      username: json['username'],
      profileUrl: json['img'],
    );
  }
}
