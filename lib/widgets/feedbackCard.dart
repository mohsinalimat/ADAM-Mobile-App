import 'package:flutter/material.dart';

class FeedbackCard extends StatefulWidget {
  const FeedbackCard({
    Key key,
  }) : super(key: key);

  @override
  _FeedbackCardState createState() => _FeedbackCardState();
}

class _FeedbackCardState extends State<FeedbackCard> {
  String _opt = "";
  int _vote = 12;
  int _prevVote = 0;
  bool _voteGiven = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/dp.png'),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          "John Doe",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          Icons.star_rounded,
                          size: 15.0,
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(child: Container()),
                PopupMenuButton(
                  onSelected: (value) {
                    setState(() {
                      _opt = value;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            Icon(
                              Icons.report,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 8),
                            Text("Under Reviewed: $_opt"),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Icon(Icons.more_vert_rounded),
                  itemBuilder: (context) =>
                      ["Flag as spam", "Flag as inappropriate"]
                          .map(
                            (opt) => PopupMenuItem(
                              value: opt,
                              child: Text(opt),
                            ),
                          )
                          .toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(
              "Really helpful, got my business started with this service. I am glad I found this on internet. Really afforadable and awesome results! 100% recommended!",
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("$_vote",
                  style:
                      TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
              const SizedBox(width: 5.0),
              Icon(Icons.thumb_up, size: 17.0)
            ],
          ),
          !_voteGiven
              ? Row(
                  children: [
                    Text(
                      "Was this review helpful?",
                    ),
                    Expanded(child: Container()),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _vote++;
                              _prevVote = _vote - 1;
                              _voteGiven = true;
                            });
                          },
                          child: Text("Yes"),
                        ),
                        TextButton(
                          onPressed: () {
                            if (_vote > 0) {
                              setState(() {
                                _vote--;
                                _prevVote = _vote;
                                _voteGiven = true;
                              });
                            }
                          },
                          child: Text("No"),
                        ),
                      ],
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Thank you for the response!"),
                    TextButton(
                      onPressed: () {
                        if (_vote > _prevVote) {
                          setState(() {
                            _vote--;
                            _voteGiven = false;
                          });
                        } else {
                          setState(() {
                            _vote++;
                            _voteGiven = false;
                          });
                        }
                      },
                      child: Text("Undo"),
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
