import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/questionnaire.dart';
import '../widgets/buttonbar_widget.dart' as bt;
import '../widgets/questionslide_widget.dart';

class QuestionsView extends StatefulWidget {
  const QuestionsView(
      {Key? key, required this.questions, required this.warrantyQuestions})
      : super(key: key);
  final List<Questionnaire> questions;
  final List<WarrantyQuestion> warrantyQuestions;
  @override
  State<QuestionsView> createState() => _QuestionsViewState();
}

class _QuestionsViewState extends State<QuestionsView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  List<Widget> setPages() {
    List<Widget> temp = [];
    for (var question in widget.questions) {
      temp.add(QuestionSlide(question: question));
    }
    temp.add(WarrantySlide(question: widget.warrantyQuestions));
    return temp;
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: setPages().length, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        color: Theme.of(context).primaryColor,
        padding: const EdgeInsets.all(8),
        width: double.infinity,
        child: Text(
          "Answer these questions to get the accurate value of your phone",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 60.sp,
              color: Colors.white),
        ),
      ),
      const SizedBox(height: 10),
      Flexible(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: tabController,
            children: setPages(),
          ),
        ),
      ),
      bt.ButtonBar(
        questions: widget.questions,
        tabController: tabController,
      )
    ]);
  }
}
