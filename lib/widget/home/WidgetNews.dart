import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/screen/NewsDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;
import 'package:pk_skeleton/pk_skeleton.dart';

class WidgetNews extends StatefulWidget {
  WidgetNews({Key key, this.kategoriId}) : super(key: key);
  final int kategoriId;

  @override
  _WidgetNewsState createState() {
    return _WidgetNewsState();
  }
}

class _WidgetNewsState extends State<WidgetNews> {
  wp.WordPress wordPress = wp.WordPress(
    baseUrl: baseURL + '',
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
    return ClipRRect(
      // borderRadius: BorderRadius.only(
      //   topLeft: Radius.circular(8.0),
      //   topRight: Radius.circular(8.0),
      // ),
      child: Image.network(post.featuredMedia.sourceUrl, width: 50, height: 50, fit: BoxFit.fill),
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
            margin: EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
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
          height: 250,
          margin: EdgeInsets.only(bottom: 10),
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
            future: fetchPost(),
            builder: (BuildContext context, AsyncSnapshot<List<wp.Post>> snapshot) {
              if (snapshot.connectionState == ConnectionState.none) {
                return Container();
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Container(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: SingleChildScrollView(
                            child: PKCardPageSkeleton(
//                                isCircularImage: true,
                                ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: SingleChildScrollView(
                            child: PKCardPageSkeleton(
//                                isCircularImage: true,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return ListView.builder(
                scrollDirection: Axis.vertical,
                // physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(left: 5, right: 5, top: 10),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  wp.Post post = snapshot.data[index];
                  return Container(
                    height: 100,
                    child: InkWell(
                      onTap: () => _openDetailNews(post.link, post.title.rendered),
                      child: ListTile(
                        leading: Container(child: getPostImages(post)),
                        title: Container(
                          width: MediaQuery.of(context).size.width,
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            text: TextSpan(style: TextStyle(color: Colors.grey[800], fontSize: 14, fontWeight: FontWeight.normal), text: post.title.rendered),
                          ),
                        ),
                        subtitle: Container(
                          width: MediaQuery.of(context).size.width,
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            text: TextSpan(style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.normal), text: post.slug),
                          ),
                        ),
                      ),
                      // child: Column(
                      //   children: <Widget>[
                      //     Expanded(
                      //       flex: 2,
                      //       child: getPostImages(post),
                      //     ),
                      //     Expanded(
                      //       flex: 1,
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //           children: [
                      //             Container(
                      //               width: MediaQuery.of(context).size.width,
                      //               child: RichText(
                      //                 overflow: TextOverflow.ellipsis,
                      //                 maxLines: 2,
                      //                 text: TextSpan(style: TextStyle(color: Colors.grey[800], fontSize: 9, fontWeight: FontWeight.normal), text: post.title.rendered),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ),
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
    Navigator.push(
        context,
        SlideRightRoute(
            page: NewsDetailScreen(
          link: link,
          title: title,
        )));
  }
}
