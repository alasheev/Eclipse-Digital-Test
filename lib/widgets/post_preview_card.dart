import 'package:eclipse_digital_test/models/post.dart';
import 'package:flutter/material.dart';

class PostPreviewCard extends StatelessWidget {
  final Post post;
  final void Function()? onTap;
  PostPreviewCard(this.post, {this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.blueGrey[50]),
      child: ListTile(
        title: Text(
          '#${post.id} ${post.title}',
          softWrap: false,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          ' ${post.body.substring(0, post.body.indexOf('\n'))}...',
          overflow: TextOverflow.ellipsis,
        ),
        trailing: onTap != null
            ? Icon(Icons.keyboard_arrow_right)
            : SizedBox.shrink(),
        onTap: onTap,
      ),
    );
  }
}
