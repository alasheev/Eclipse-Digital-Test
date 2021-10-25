import 'package:eclipse_digital_test/api.dart';
import 'package:eclipse_digital_test/models/user.dart';
import 'package:eclipse_digital_test/screens/albums_page.dart';
import 'package:eclipse_digital_test/screens/posts_page.dart';
import 'package:eclipse_digital_test/widgets/album_preview_card.dart';
import 'package:eclipse_digital_test/widgets/post_preview_card.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  User user;
  UserPage(this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text(
          user.username,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder(
              future:
                  Future.wait([getUserPosts(user.id), getUserAlbums(user.id)]),
              builder: (context, AsyncSnapshot<List<List>> snapshot) {
                if ((snapshot.connectionState == ConnectionState.done) && snapshot.data != null) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('name: ${user.name}'),
                      SizedBox(height: 10),
                      Text('email: ${user.email}'),
                      SizedBox(height: 10),
                      Text('phone: ${user.phone}'),
                      SizedBox(height: 10),
                      Text('website: ${user.website}'),
                      SizedBox(height: 10),
                      Text('working:'),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.company['name']),
                            Text(user.company['bs']),
                            Text(
                              "''${user.company['catchPhrase']}''",
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                          'address: ${user.address['city']}, ${user.address['street']}, ${user.address['suite']}'),
                      SizedBox(height: 10),
                      Text('user posts:'),
                      PostPreviewCard(snapshot.data![0][0]),
                      SizedBox(height: 10),
                      PostPreviewCard(snapshot.data![0][1]),
                      SizedBox(height: 10),
                      PostPreviewCard(snapshot.data![0][2]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PostsPage(user)));
                            },
                            child: Text('View all posts'),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text('user albums:'),
                      AlbumPreviewCard(snapshot.data![1][0]),
                      SizedBox(height: 10),
                      AlbumPreviewCard(snapshot.data![1][1]),
                      SizedBox(height: 10),
                      AlbumPreviewCard(snapshot.data![1][2]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AlbumsPage(user)));
                            },
                            child: Text('View all albums'),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.black),
                  );
                }
              }),
        ),
      ),
    );
  }
}
