import 'package:upwork_app/models/create_order.dart';
import 'package:upwork_app/widgets/product_tracker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../models/questionnaire.dart';
import '../pages/sellingPage/productinfo_page.dart';
import 'button_widget.dart';

class ButtonBar extends StatefulWidget {
  const ButtonBar(
      {Key? key, required this.tabController, required this.questions})
      : super(key: key);
  final TabController tabController;
  final List<Questionnaire> questions;

  @override
  State<ButtonBar> createState() => _ButtonBarState();
}

class _ButtonBarState extends State<ButtonBar> {
  bool hasSubQuestions() {
    bool answer = true;
    if (widget.tabController.index > widget.questions.length - 1) {
      answer = true;
    } else if (widget
        .questions[widget.tabController.index].specialsubquestion.isEmpty) {
      answer = false;
    }
    return answer;
  }

  bool isWarrantyQuestion() {
    bool answer = false;
    if (widget.tabController.index > widget.questions.length - 1) {
      answer = true;
    }
    return answer;
  }

  bool mandatoryQuestionAnswered() {
    return Provider.of<CreateOrder>(context, listen: true)
        .getWarranties()
        .isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final chosenProduct = Provider.of<CreateOrder>(context, listen: false);
    return Column(
      children: [
        Container(
            height: 2,
            width: double.infinity,
            color: Theme.of(context).primaryColor),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Yes button only when yes or no question is asked
            // By default yes or no question, has weightage only if it's a yes
            (!hasSubQuestions())
                ? Button(
                    onPressed: () {
                      chosenProduct.addQuestion(
                          widget.questions[widget.tabController.index],
                          widget.questions[widget.tabController.index].if_yes,
                          0);
                      widget.tabController
                          .animateTo(widget.tabController.index + 1);
                    },
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      "YES",
                      style: TextStyle(
                          fontSize: 55.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  )
                : Container(),

            // No button only when yes or no question is asked
            (!hasSubQuestions())
                ? Button(
                    onPressed: () {
                      chosenProduct.addQuestion(
                          widget.questions[widget.tabController.index],
                          widget.questions[widget.tabController.index].if_no,
                          null);
                      widget.tabController
                          .animateTo(widget.tabController.index + 1);
                    },
                    color: Theme.of(context).colorScheme.secondary,
                    child: Text(
                      "NO",
                      style: TextStyle(
                          fontSize: 55.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  )
                : Container(),

            // Arrow back button
            (widget.tabController.index > 0)
                ? Button(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      widget.tabController
                          .animateTo(widget.tabController.index - 1);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  )
                : Container(),

            // Skip button
            (hasSubQuestions() && !isWarrantyQuestion())
                ? Button(
                    onPressed: () {
                      widget.tabController.animateTo(widget.questions.length);
                    },
                    color: Theme.of(context).colorScheme.secondary,
                    child: Text(
                      "SKIP",
                      style: TextStyle(
                          fontSize: 55.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  )
                : Container(),

            // Continue button
            (hasSubQuestions())
                ? Button(
                    onPressed: () {
                      (widget.tabController.length - 1 ==
                              widget.tabController.index)
                          ? Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const ProductInfo(finalConfirmation: true)))
                          : widget.tabController
                              .animateTo(widget.tabController.index + 1);
                    },
                    enabled: (widget.tabController.index >
                            widget.questions.length - 1)
                        ? mandatoryQuestionAnswered()
                        : true,
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      "CONTINUE",
                      style: TextStyle(
                          fontSize: 55.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  )
                : Container(),
          ],
        ),
      ],
    );
  }
}
