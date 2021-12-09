import 'package:flutter/material.dart';

class AudienceChip extends StatefulWidget {
  final String username;
  final Function onDelete;
  const AudienceChip({
    Key key,
    this.username,
    this.onDelete,
  }) : super(key: key);

  @override
  _AudienceChipState createState() => _AudienceChipState();
}

class _AudienceChipState extends State<AudienceChip> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5.0,
      ),
      child: Chip(
        avatar: CircleAvatar(
          child: Icon(Icons.person),
        ),
        label: Text(' ${widget.username}'),
        labelPadding: const EdgeInsets.all(2.0),
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        backgroundColor: Colors.white,
        deleteIcon: Icon(
          Icons.cancel,
          color: Colors.red,
        ),
        onDeleted: widget.onDelete,
      ),
    );
  }
}
