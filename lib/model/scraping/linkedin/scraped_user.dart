class LinkedInScrapedUserList {
  final List<LinkedInScrapedUser> scrapedUsers;

  LinkedInScrapedUserList({this.scrapedUsers});

  factory LinkedInScrapedUserList.fromJSON(Map<String, dynamic> json) {
    print(json);
    Iterable users = json['followers_data'];
    List<LinkedInScrapedUser> scrapedUser =
        users.map((data) => LinkedInScrapedUser.fromJSON(data)).toList();
    return LinkedInScrapedUserList(
      scrapedUsers: scrapedUser,
    );
  }
}

class LinkedInScrapedUser {
  final String profileUrl;
  final String username;
  final String fullName;
  final String headline;
  final String summary;

  LinkedInScrapedUser({
    this.profileUrl,
    this.username,
    this.fullName,
    this.headline,
    this.summary,
  });

  factory LinkedInScrapedUser.fromJSON(Map<String, dynamic> json) {
    return LinkedInScrapedUser(
      profileUrl: json['profile_url'],
      username: json['username'],
      fullName: json['fullName'],
      headline: json['headline'],
      summary: json['summary'],
    );
  }
}
