import 'package:upwork_app/widgets/appbar_widget.dart';
import 'package:upwork_app/widgets/blogcard_widget.dart';
import 'package:flutter/material.dart';

import '../controllers/get_blogs.dart';
import '../models/blogs.dart';
import '../pages/errorpage.dart';

class BlogList extends StatefulWidget {
  const BlogList({Key? key}) : super(key: key);

  @override
  State<BlogList> createState() => _BlogListState();
}

class _BlogListState extends State<BlogList>
    with AutomaticKeepAliveClientMixin {
  Future<List<Blog>> future = getBlogs();

  List<Widget> setItems(AsyncSnapshot<List<Blog>> snapshot) {
    List<Widget> temp = [];
    for (var element in snapshot.data!) {
      temp.add(BlogCard(blog: element));
    }
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const CustomAppbar(title: 'Blogs'),
          FutureBuilder(
            future: future,
            builder: (context, AsyncSnapshot<List<Blog>> snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()));
              } else if (snapshot.hasError) {
                return SliverFillRemaining(
                  child: ErrorScreen(
                    snapshot: snapshot,
                    onPressed: () {
                      setState(() => future = getBlogs());
                    },
                  ),
                );
              } else {
                return SliverToBoxAdapter(
                  child: SingleChildScrollView(
                    child: Column(
                      children: setItems(snapshot),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
