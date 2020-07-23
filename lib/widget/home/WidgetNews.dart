import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/screen/NewsDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;
import 'package:jiffy/jiffy.dart';

class WidgetNews extends StatefulWidget {
  WidgetNews({Key key}) : super(key: key);

  @override
  _WidgetNewsState createState() {
    return _WidgetNewsState();
  }
}

class _WidgetNewsState extends State<WidgetNews> {
  wp.WordPress wordPress = wp.WordPress(
    baseUrl: 'https://m-bangun.com',
  );

  fetchPost() {
    Future<List<wp.Post>> posts = wordPress.fetchPosts(
      postParams: wp.ParamsPostList(
        context: wp.WordPressContext.view,
        pageNum: 1,
        includeCategories: [1],
        perPage: 20,
        order: wp.Order.desc,
        orderBy: wp.PostOrderBy.date,
      ),
      fetchAuthor: true,
      fetchFeaturedMedia: true,
      fetchComments: true,
    );
    return posts;
  }

  getPostImages(wp.Post post) {
    if (post.featuredMedia == null) {
      return SizedBox();
    }
    return Image.network(
      post.featuredMedia.sourceUrl,
      fit: BoxFit.cover,
      width: 270,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Berita terbaru',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          )),
                      Text(
                        'Berita terbaru tentang teknologi',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  child: Text(
                    '',
                    style: TextStyle(fontSize: 12, color: Color(0xffb16a085)),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 300,
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: FutureBuilder(
            future: fetchPost(),
            builder: (BuildContext context, AsyncSnapshot<List<wp.Post>> snapshot) {
              if (snapshot.connectionState == ConnectionState.none) {
                return Container();
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 5, right: 5, top: 10),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  wp.Post post = snapshot.data[index];
                  return Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: InkWell(
                      onTap: () => _openDetailNews(post.link, post.title.rendered),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: getPostImages(post),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: 250,
                                    child: RichText(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 4,
                                      strutStyle: StrutStyle(fontSize: 10.0),
                                      text: TextSpan(style: TextStyle(color: Colors.grey[800], fontSize: 12, fontWeight: FontWeight.bold), text: post.title.rendered),
                                    ),
                                  ),
                                  Container(
                                    width: 250,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          post.author.name,
                                          style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                                        ),
                                        Text(
                                          Jiffy(post.date).fromNow(),
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 2,
                    margin: EdgeInsets.all(10),
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }

  _openDetailNews(link, title) {
    Navigator.push(context, SlideRightRoute(page: NewsDetailScreen(link: link, title: title,)));
  }
}
