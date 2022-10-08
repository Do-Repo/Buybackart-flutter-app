import 'package:provider/provider.dart';
import 'package:upwork_app/controllers/get_questions.dart';

import 'package:flutter/material.dart';
import 'package:upwork_app/controllers/post_orderinit.dart';
import 'package:upwork_app/models/create_order.dart';
import 'package:upwork_app/models/questionnaire.dart';
import 'package:upwork_app/models/sell_options.dart';
import 'package:upwork_app/pages/errorpage.dart';

import '../../views/question_view.dart';
import '../../widgets/product_tracker_widget.dart';

class QuestionsForm extends StatefulWidget {
  const QuestionsForm({Key? key}) : super(key: key);
  @override
  State<QuestionsForm> createState() => _QuestionsFormState();
}

class _QuestionsFormState extends State<QuestionsForm> {
  late Future<List> future;

  Future<List<Questionnaire>> getQuestion() async {
    final currentProduct = Provider.of<CreateOrder>(context, listen: false);
    int optionIndex =
        await orderInit(currentProduct.chosenProduct!.id, currentProduct.varId);

    // The backend provided to me really is bad and doesn't make sence but
    // I don't get paid enough to care and fix hit, here's a workaround
    // Without this, null exception is thrown when asked for option id because
    // You don't pick a brand when accessed by searching device

    // There should be a variable inside product info for category id, but there isn't
    // instead there is a string with its name
    currentProduct.setChosenOption(SellOptions(
        id: optionIndex, title: "placeHolder", image: "placeHolder"));
    return getQuestions(optionIndex);
  }

  @override
  void initState() {
    super.initState();
    future = Future.wait([getQuestion(), getWarrantyQuestions()]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() {
        Navigator.pop(context);
        return Future.value(true);
      }),
      child: Scaffold(
        appBar: AppBar(
          actions: const [ProductTracker()],
        ),
        body: FutureBuilder(
          future: future,
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return ErrorScreen(
                  snapshot: snapshot,
                  onPressed: () => setState(() {
                        future = Future.wait(
                            [getQuestion(), getWarrantyQuestions()]);
                      }));
            } else {
              return QuestionsView(
                questions: snapshot.data![0],
                warrantyQuestions: snapshot.data![1],
              );
            }
          },
        ),
      ),
    );
  }
}
