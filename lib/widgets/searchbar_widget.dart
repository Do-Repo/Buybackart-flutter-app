import 'package:flutter/material.dart';
import 'package:upwork_app/controllers/get_search.dart';
import 'package:upwork_app/models/products.dart';

import '../pages/errorpage.dart';
import '../views/devices_view.dart';

class SearchTextfield extends StatefulWidget {
  const SearchTextfield({Key? key, this.isHomepage}) : super(key: key);
  final bool? isHomepage;

  @override
  State<SearchTextfield> createState() => _SearchTextfieldState();
}

class _SearchTextfieldState extends State<SearchTextfield> {
  TextEditingController controller = TextEditingController();

  void onSearch(String input) {
    if (widget.isHomepage != null && widget.isHomepage == true) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => SearchPage(input: input)));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SearchPage(input: input)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 2)),
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          suffixIcon: IconButton(
              onPressed: () => onSearch(controller.text),
              icon: const Icon(Icons.search)),
          filled: true,
          fillColor: Colors.white,
          hintText: "Search your device"),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.input}) : super(key: key);
  final String input;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int currentPage = 1, allPages = 1;
  bool showLoader = false;
  List<Product> reasonList = [];
  late Future<List<Product>> future;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >
          scrollController.position.maxScrollExtent - 40) {
        if (!showLoader) loadMore();
      }
    });
    future = searchOptimization();
  }

  Future<List<Product>> searchOptimization() async {
    // This had to be done because it's not returning same class

    await getSearch(widget.input, currentPage)
        // ignore: avoid_function_literals_in_foreach_calls
        .then((value) {
      allPages = value.pages;
      for (var element in value.products) {
        reasonList.add(
            Product(id: element.id, name: element.name, image: element.image));
      }
    });
    return reasonList;
  }

  void loadMore() async {
    if (currentPage < allPages) {
      setState(() => showLoader = true);
      currentPage++;
      print('oioi');
      await searchOptimization()
          .whenComplete(() => setState(() => showLoader = false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search your device"),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            color: Theme.of(context).primaryColor,
          ),
          Flexible(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: FutureBuilder(
                  future: future,
                  builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: ErrorScreen(
                              snapshot: snapshot,
                              onPressed: () {
                                setState(() => future = searchOptimization());
                              }));
                    } else {
                      if (snapshot.data == null || snapshot.data!.isEmpty) {
                        return Container();
                      } else {
                        return SingleChildScrollView(
                            controller: scrollController,
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                DevicesView(children: snapshot.data!),
                                if (showLoader)
                                  const Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: CircularProgressIndicator(),
                                  ),
                              ],
                            ));
                      }
                    }
                  },
                )),
          ),
        ],
      ),
    );
  }
}
