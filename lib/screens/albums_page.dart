import 'package:eclipse_digital_test/api.dart';
import 'package:eclipse_digital_test/models/album.dart';
import 'package:eclipse_digital_test/models/user.dart';
import 'package:eclipse_digital_test/screens/album_details_page.dart';
import 'package:eclipse_digital_test/widgets/album_preview_card.dart';
import 'package:flutter/material.dart';

class AlbumsPage extends StatelessWidget {
  final User user;
  AlbumsPage(this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text(
          "${user.username}'s albums",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: FutureBuilder(
        future: getUserAlbums(user.id),
        builder: (context, AsyncSnapshot<List<Album>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.separated(
              addAutomaticKeepAlives: true,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) {
                return AlbumPreviewCard(
                  snapshot.data![index],
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          AlbumDetailsPage(snapshot.data![index]))),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemCount: snapshot.data!.length,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }
        },
      ),
    );
  }
}
