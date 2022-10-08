import 'package:upwork_app/models/create_order.dart';
import 'package:upwork_app/widgets/questionitem_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../models/questionnaire.dart';

class QuestionSlide extends StatefulWidget {
  const QuestionSlide({Key? key, required this.question}) : super(key: key);
  final Questionnaire question;
  @override
  State<QuestionSlide> createState() => _QuestionSlideState();
}

class _QuestionSlideState extends State<QuestionSlide> {
  List<Widget> setSubQuestions() {
    List<Widget> temp = [];
    for (var subQuestion in widget.question.specialsubquestion) {
      temp.add(
          QuestionItem(subQuestion: subQuestion, question: widget.question));
    }
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                VerticalDivider(
                  thickness: 3,
                  color: Theme.of(context).primaryColor,
                ),
                Flexible(
                  child: Text(
                    widget.question.question,
                    style: TextStyle(
                        fontSize: 50.sp,
                        letterSpacing: -0.7,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          (widget.question.prop_image.isNotEmpty)
              ? Padding(
                  padding: const EdgeInsets.all(15.0),
                  child:
                      CachedNetworkImage(imageUrl: widget.question.prop_image),
                )
              : Container(),
          (widget.question.specialsubquestion.isNotEmpty)
              ? Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.count(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: setSubQuestions(),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}

class WarrantySlide extends StatefulWidget {
  const WarrantySlide({Key? key, required this.question}) : super(key: key);
  final List<WarrantyQuestion> question;
  @override
  State<WarrantySlide> createState() => _WarrantySlideState();
}

class _WarrantySlideState extends State<WarrantySlide> {
  List<Widget> setWarrantyQuestions() {
    List<Widget> temp = [];
    for (var warrantyQuestion in widget.question) {
      temp.add(WarrantyItem(
          warrantyQuestion: warrantyQuestion,
          isSelected: (Provider.of<CreateOrder>(context, listen: true)
                  .isInWarranties(warrantyQuestion))
              ? true
              : false));
    }
    return temp;
  }

  List<Widget> setAccessoires() {
    List<Widget> temp = [];
    final chosenProduct = Provider.of<CreateOrder>(context, listen: true);
    for (var item in chosenProduct.chosenProduct!.attachedaccessory) {
      temp.add(AccessoriesItem(accessories: item));
    }
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  VerticalDivider(
                    thickness: 3,
                    color: Theme.of(context).primaryColor,
                  ),
                  Flexible(
                    child: Text(
                      "Which of the below accessories do you have with you?",
                      style: TextStyle(
                          fontSize: 50.sp,
                          letterSpacing: -0.7,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            IntrinsicHeight(
              child: Row(
                children: [
                  VerticalDivider(
                    thickness: 3,
                    color: Theme.of(context).primaryColor,
                  ),
                  Flexible(
                    child: Text(
                      "You can select more than one",
                      style: TextStyle(
                          fontSize: 40.sp,
                          letterSpacing: -0.7,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.count(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 1,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: setAccessoires(),
              ),
            ),
            IntrinsicHeight(
              child: Row(
                children: [
                  VerticalDivider(
                    thickness: 3,
                    color: Theme.of(context).primaryColor,
                  ),
                  Flexible(
                    child: Text(
                      "How old is your device?",
                      style: TextStyle(
                          fontSize: 50.sp,
                          letterSpacing: -0.7,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            IntrinsicHeight(
              child: Row(
                children: [
                  VerticalDivider(
                    thickness: 3,
                    color: Theme.of(context).primaryColor,
                  ),
                  Flexible(
                    child: Text(
                      "Cover only manufacturer warranty (Mandatory To Select)",
                      style: TextStyle(
                          fontSize: 40.sp,
                          letterSpacing: -0.7,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.count(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 1,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: setWarrantyQuestions(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
