import 'dart:convert';

import 'package:upwork_app/models/create_order.dart';
import 'package:upwork_app/models/product_details.dart';
import 'package:upwork_app/models/questionnaire.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WarrantyItem extends StatefulWidget {
  const WarrantyItem(
      {Key? key, required this.warrantyQuestion, required this.isSelected})
      : super(key: key);
  final bool isSelected;
  final WarrantyQuestion warrantyQuestion;
  @override
  State<WarrantyItem> createState() => _WarrantyItemState();
}

class _WarrantyItemState extends State<WarrantyItem> {
  String formattedWarrantyQuestion = '';

  @override
  void initState() {
    super.initState();
    var utf8Runes = widget.warrantyQuestion.warranty.runes.toList();
    formattedWarrantyQuestion = utf8.decode(utf8Runes);
  }

  void toggleSelect() {
    final chosenProduct = Provider.of<CreateOrder>(context, listen: false);
    chosenProduct.clearWarranty();
    if (!widget.isSelected) {
      chosenProduct.addWarranty(widget.warrantyQuestion);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => toggleSelect(),
      child: SizedBox(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  style: BorderStyle.solid,
                  width: (widget.isSelected) ? 3 : 2,
                  color: (widget.isSelected)
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).primaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: CachedNetworkImage(
                  imageUrl: widget.warrantyQuestion.image,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(formattedWarrantyQuestion),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AccessoriesItem extends StatefulWidget {
  const AccessoriesItem({Key? key, required this.accessories})
      : super(key: key);
  final Accessories accessories;
  @override
  State<AccessoriesItem> createState() => _AccessoriesItemState();
}

class _AccessoriesItemState extends State<AccessoriesItem> {
  bool isSelected = false;
  String formattedTitle = "";

  @override
  void initState() {
    super.initState();
    var utf8Runes = widget.accessories.parent.runes.toList();
    formattedTitle = utf8.decode(utf8Runes);
    if (Provider.of<CreateOrder>(context, listen: false)
        .isInAccessories(widget.accessories)) {
      isSelected = true;
    }
  }

  void toggleSelect() {
    final chosenProduct = Provider.of<CreateOrder>(context, listen: false);
    if (!isSelected) {
      chosenProduct.addAccessories(widget.accessories);
      setState(() => isSelected = true);
    } else {
      chosenProduct.removeAccessories(widget.accessories);
      setState(() => isSelected = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => toggleSelect(),
      child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  style: BorderStyle.solid,
                  width: (isSelected) ? 4 : 2,
                  color: (isSelected)
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).primaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: CachedNetworkImage(
                  imageUrl: widget.accessories.image,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(formattedTitle),
              )
            ],
          )),
    );
  }
}

class QuestionItem extends StatefulWidget {
  const QuestionItem(
      {Key? key, required this.subQuestion, required this.question})
      : super(key: key);
  final SubQuestion subQuestion;
  final Questionnaire question;

  @override
  State<QuestionItem> createState() => _QuestionItemState();
}

class _QuestionItemState extends State<QuestionItem> {
  String formattedSubQuestion = '';
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    var utf8Runes = widget.subQuestion.sub_question.runes.toList();
    formattedSubQuestion = utf8.decode(utf8Runes);
    if (Provider.of<CreateOrder>(context, listen: false)
        .isInSubQuestions(widget.subQuestion, widget.question)) {
      isSelected = true;
    }
  }

  void toggleSelect() {
    final chosenProduct = Provider.of<CreateOrder>(context, listen: false);
    if (!isSelected) {
      chosenProduct.addSubQuestion(widget.subQuestion, widget.question);
      setState(() => isSelected = true);
    } else {
      chosenProduct.removeSubQuestion(widget.subQuestion, widget.question);
      setState(() => isSelected = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => toggleSelect(),
      child: SizedBox(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  style: BorderStyle.solid,
                  width: (isSelected) ? 4 : 2,
                  color: (isSelected)
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).primaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: CachedNetworkImage(
                  imageUrl: widget.subQuestion.image,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(formattedSubQuestion),
              )
            ],
          ),
        ),
      ),
    );
  }
}
