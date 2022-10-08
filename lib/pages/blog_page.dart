import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

import '../models/blogs.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../widgets/title_widget.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({Key? key, required this.blog}) : super(key: key);
  final Blog blog;

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage>
    with AutomaticKeepAliveClientMixin {
  String timeAgo = '';
  String formattedDescription = '';

  @override
  void initState() {
    super.initState();
    DateTime time = DateTime.parse(widget.blog.created);
    timeAgo = timeago.format(time);
    var utf8Runes = widget.blog.description.runes.toList();
    formattedDescription = utf8.decode(utf8Runes);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            elevation: 5,
            pinned: true,
            expandedHeight: 290,
            backgroundColor: Colors.white,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                    tag: widget.blog.id.toString(),
                    child: CachedNetworkImage(
                      imageUrl: widget.blog.image,
                      fit: BoxFit.cover,
                    ))),
            actions: <Widget>[
              const SizedBox(width: 15),
              CircleAvatar(
                radius: 17,
                backgroundColor: Colors.white.withOpacity(0.7),
                child: IconButton(
                  alignment: Alignment.center,
                  icon: Icon(Icons.arrow_back_ios_sharp,
                      size: 18, color: Colors.grey[900]),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const Spacer(),
              CircleAvatar(
                radius: 17,
                backgroundColor: Colors.white.withOpacity(0.7),
                child: IconButton(
                  icon: Icon(Icons.share, size: 18, color: Colors.grey[900]),
                  onPressed: () {
                    Share.share(
                        "Check this awesome blog!\nbuybackart.com/#/blog-detail/${widget.blog.id}");
                  },
                ),
              ),
              const SizedBox(width: 15)
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  ShortCutTitle(
                    title: widget.blog.title,
                  ),
                  Text(
                    "Author: ${widget.blog.author}",
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                  Text(
                    "Posted: $timeAgo",
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                  const Divider(),
                  Text(
                    formattedDescription,
                    style: TextStyle(fontSize: 50.sp),
                  ),
                  const SizedBox(height: 10)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
