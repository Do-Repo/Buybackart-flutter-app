import 'package:upwork_app/models/blogs.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../pages/blog_page.dart';

class BlogCard extends StatefulWidget {
  const BlogCard({Key? key, required this.blog}) : super(key: key);
  final Blog blog;
  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BlogPage(
                blog: widget.blog,
              ))),
      child: Stack(
        children: [
          SizedBox(
            height: 350,
            width: double.infinity,
            child: Hero(
              tag: widget.blog.id.toString(),
              child: CachedNetworkImage(
                imageUrl: widget.blog.image,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned.fill(
              child: Column(
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.9)),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      VerticalDivider(
                        width: 15,
                        thickness: 5,
                        color: Theme.of(context).primaryColor,
                      ),
                      Flexible(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.blog.title,
                              style: TextStyle(
                                  fontSize: 50.sp,
                                  letterSpacing: -0.7,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              widget.blog.description,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
