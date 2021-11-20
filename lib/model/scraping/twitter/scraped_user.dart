class TwitterScrapedUserList {
  final List<TwitterScrapedUser> scrapedUsers;

  TwitterScrapedUserList({this.scrapedUsers});

  factory TwitterScrapedUserList.fromJSON(Map<String, dynamic> json) {
    print("ALL USER DATA!!");
    Iterable usersData = json['followers_data'];
    List<TwitterScrapedUser> scrapedData =
        usersData.map((usr) => TwitterScrapedUser.fromJSON(usr)).toList();

    return TwitterScrapedUserList(
      scrapedUsers: scrapedData,
    );
  }
}

class TwitterScrapedUser {
  final String username;
  final String profileUrl;
  final String location;
  final String bio;
  final int followers;
  final int following;
  final String photo;

  TwitterScrapedUser(
      {this.username,
      this.profileUrl,
      this.location,
      this.bio,
      this.followers,
      this.following,
      this.photo});

  factory TwitterScrapedUser.fromJSON(Map<String, dynamic> json) {
    print("PER USER DATA!!");
    return TwitterScrapedUser(
      username: json['username'],
      profileUrl: json['profile_url'],
      bio: json['bio'],
      followers: json['followers_count'],
      following: json['following_count'],
      location: json['location'],
      photo: json['photo'],
    );
  }
}
