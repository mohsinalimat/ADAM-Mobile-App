class InstaScrapedUserList {
  final List<InstaScrapedUser> scrapedUsers;

  InstaScrapedUserList({this.scrapedUsers});

  factory InstaScrapedUserList.fromJSON(Map<String, dynamic> json) {
    print(json);
    Iterable users = json['followers_data'];
    List<InstaScrapedUser> scrapedUser =
        users.map((data) => InstaScrapedUser.fromJSON(data)).toList();
    return InstaScrapedUserList(
      scrapedUsers: scrapedUser,
    );
  }
}

class InstaScrapedUser {
  final String username;
  final String bio;
  final String profileUrl;
  final int followers;
  final int following;
  final int mediaCount;
  final String photoUrl;

  InstaScrapedUser({
    this.username,
    this.bio,
    this.profileUrl,
    this.followers,
    this.following,
    this.mediaCount,
    this.photoUrl,
  });

  factory InstaScrapedUser.fromJSON(Map<String, dynamic> json) {
    return InstaScrapedUser(
      username: json['username'],
      bio: json['bio'],
      profileUrl: json['url'],
      followers: json['followers'],
      following: json['following'],
      mediaCount: json['media_count'],
      photoUrl: json['photo'],
    );
  }
}
