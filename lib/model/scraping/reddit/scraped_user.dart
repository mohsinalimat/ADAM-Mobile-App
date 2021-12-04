class RedditScrapedDataList {
  final List<RedditScrapedData> scrapedUsers;

  RedditScrapedDataList({this.scrapedUsers});

  factory RedditScrapedDataList.fromJSON(Map<String, dynamic> json) {
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
  final String profilePic;

  RedditScrapedData({
    this.username,
    this.profileUrl,
    this.profilePic,
  });

  factory RedditScrapedData.fromJSON(Map<String, dynamic> json) {
    return RedditScrapedData(
      username: json['username'],
      profilePic: json['img'],
      profileUrl: json['profile_url'],
    );
  }
}
