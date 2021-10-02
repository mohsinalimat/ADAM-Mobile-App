class ScrapedUserList {
  final List<ScrapedUser> scrapedUsers;

  ScrapedUserList({this.scrapedUsers});

  factory ScrapedUserList.fromJSON(Map<String, dynamic> json) {
    print(json);
    Iterable users = json['followers_data'];
    List<ScrapedUser> scrapedUser =
        users.map((data) => ScrapedUser.fromJSON(data)).toList();
    return ScrapedUserList(
      scrapedUsers: scrapedUser,
    );
  }
}

class ScrapedUser {
  final String username;
  final String bio;
  final String profileUrl;
  final int followers;
  final int following;
  final int mediaCount;
  final String photoUrl;

  ScrapedUser({
    this.username,
    this.bio,
    this.profileUrl,
    this.followers,
    this.following,
    this.mediaCount,
    this.photoUrl,
  });

  factory ScrapedUser.fromJSON(Map<String, dynamic> json) {
    return ScrapedUser(
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
