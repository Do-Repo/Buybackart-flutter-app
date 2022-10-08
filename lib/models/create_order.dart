// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:upwork_app/models/product_details.dart';
import 'package:upwork_app/models/questionnaire.dart';
import 'package:upwork_app/models/sell_options.dart';

class CreateOrder extends ChangeNotifier {
  int? id;
  int? varId;
  List<SAccessories>? accessories;
  int? calculation;
  int? total;
  List<DeviceReport>? deviceReport;
  List<SWarranties>? warrantyInStorage;
  ProductDetails? chosenProduct;
  SellOptions? chosenOption;

  CreateOrder({
    this.id,
    this.varId,
    this.accessories,
    this.calculation,
    this.total,
    this.deviceReport,
    this.warrantyInStorage,
    this.chosenProduct,
    this.chosenOption,
  });

  void setId(int id) {
    this.id = id;
    notifyListeners();
  }

  int? getId() {
    return id;
  }

  void setVarId(int varId) {
    this.varId = varId;
    notifyListeners();
  }

  int? getVarId() {
    return varId;
  }

  Variants getChosenVariant() {
    return chosenProduct!.variants.firstWhere((element) => element.id == varId);
  }

  void addAccessories(Accessories accessories) {
    this.accessories ??= [];
    this.accessories!.add(SAccessories(
        name: accessories.parent,
        id: accessories.id,
        weightage: accessories.weightage));

    notifyListeners();
  }

  bool isInAccessories(Accessories accessory) {
    accessories ??= [];
    return accessories!.any((element) => element.id == accessory.id);
  }

  void removeAccessories(Accessories accessories) {
    if (this.accessories != null) {
      this.accessories!.removeWhere((element) => element.id == accessories.id);
      notifyListeners();
    }
  }

  void setCalculation(int calculation) {
    this.calculation = calculation;
    notifyListeners();
  }

  int? getCalculation() {
    return calculation;
  }

  void setTotal(int total) {
    this.total = total;
    notifyListeners();
  }

  int? getTotal() {
    return total;
  }

  void clearChoices() {
    accessories = null;
    deviceReport = null;
    warrantyInStorage = null;
    notifyListeners();
  }

  void addSubQuestion(SubQuestion subQuestion, Questionnaire question) {
    var utf8Runes = subQuestion.sub_question.runes.toList();
    var formattedSubQuestion = utf8.decode(utf8Runes);
    deviceReport ??= [];
    int index =
        deviceReport!.indexWhere((element) => element.parentId == question.id);
    if (index != -1) {
      deviceReport![index].child.add(SQuestions(
          id: subQuestion.id,
          sub_question: formattedSubQuestion,
          weightage: subQuestion.weightage));
    } else {
      deviceReport!.add(DeviceReport(
        parentId: question.id,
        weightage: question.weightage,
        question: question.question,
        child: [
          SQuestions(
              id: subQuestion.id,
              sub_question: formattedSubQuestion,
              weightage: subQuestion.weightage),
        ],
      ));
    }
    notifyListeners();
  }

  void removeSubQuestion(SubQuestion subQuestion, Questionnaire question) {
    deviceReport ??= [];
    int index =
        deviceReport!.indexWhere((element) => element.parentId == question.id);
    if (index != -1) {
      deviceReport![index]
          .child
          .removeWhere((element) => element.id == subQuestion.id);
      if (deviceReport![index].child.isEmpty) {
        deviceReport!.removeAt(index);
      }
    }
    notifyListeners();
  }

  bool isInSubQuestions(SubQuestion subQuestion, Questionnaire question) {
    deviceReport ??= [];
    int index =
        deviceReport!.indexWhere((element) => element.parentId == question.id);
    if (index != -1) {
      return deviceReport![index]
          .child
          .any((element) => element.id == subQuestion.id);
    } else {
      return false;
    }
  }

  List<SWarranties> getWarranties() {
    return warrantyInStorage ?? [];
  }

  void addQuestion(Questionnaire question, String? answer, int? weight) {
    deviceReport ??= [];
    var theQuestion = DeviceReport(
      parentId: question.id,
      weightage: weight ?? question.weightage,
      question: answer ?? question.question,
      child: [],
    );
    deviceReport!
        .removeWhere((element) => element.parentId == theQuestion.parentId);
    deviceReport!.add(theQuestion);
    notifyListeners();
  }

  void removeQuestion(Questionnaire question) {
    deviceReport ??= [];
    deviceReport!.removeWhere((element) => element.parentId == question.id);
    notifyListeners();
  }

  void addWarranty(WarrantyQuestion warranty) {
    warrantyInStorage ??= [];
    warrantyInStorage!.add(SWarranties(
        id: warranty.id,
        name: warranty.warranty,
        weightage: warranty.weightage));
    notifyListeners();
  }

  bool isInWarranties(WarrantyQuestion warranty) {
    warrantyInStorage ??= [];
    return warrantyInStorage!.any((element) => element.id == warranty.id);
  }

  void clearWarranty() {
    warrantyInStorage = null;
    notifyListeners();
  }

  void removeWarranty(WarrantyQuestion warranty) {
    warrantyInStorage ??= [];
    warrantyInStorage!.removeWhere((element) => element.id == warranty.id);
    notifyListeners();
  }

  void setChosenProduct(ProductDetails chosenProduct) {
    this.chosenProduct = chosenProduct;
    notifyListeners();
  }

  void clearOrder() {
    id = null;
    varId = null;
    accessories = null;
    calculation = null;
    total = null;
    deviceReport = null;
    warrantyInStorage = null;
    chosenProduct = null;
    notifyListeners();
  }

  void setChosenOption(SellOptions chosenOption) {
    this.chosenOption = chosenOption;
    notifyListeners();
  }

  SellOptions? getChosenOption() {
    return chosenOption;
  }

  ProductDetails? getChosenProduct() {
    return chosenProduct;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'varId': varId,
      'accessories': accessories?.map((x) => x.toMap()).toList(),
      'calculation': calculation,
      'total': total,
      'deviceReport': deviceReport?.map((x) => x.toMap()).toList(),
      'warrantyInStorage': warrantyInStorage?.map((x) => x.toMap()).toList(),
    };
  }

  factory CreateOrder.fromMap(Map<String, dynamic> map) {
    return CreateOrder(
      id: map['id']?.toInt(),
      varId: map['varId']?.toInt(),
      accessories: map['accessories'] != null
          ? List<SAccessories>.from(
              map['accessories']?.map((x) => SAccessories.fromMap(x)))
          : null,
      calculation: map['calculation']?.toInt(),
      total: map['total']?.toInt(),
      deviceReport: map['deviceReport'] != null
          ? List<DeviceReport>.from(
              map['deviceReport']?.map((x) => DeviceReport.fromMap(x)))
          : null,
      warrantyInStorage: map['warrantyInStorage'] != null
          ? List<SWarranties>.from(
              map['warrantyInStorage']?.map((x) => SWarranties.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateOrder.fromJson(String source) =>
      CreateOrder.fromMap(json.decode(source));
}

class DeviceReport {
  String question;
  int parentId;
  int weightage;
  List<SQuestions> child;

  DeviceReport({
    required this.question,
    required this.parentId,
    required this.weightage,
    required this.child,
  });

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'parentId': parentId,
      'weightage': weightage,
      'child': child.map((x) => x.toMap()).toList(),
    };
  }

  factory DeviceReport.fromMap(Map<String, dynamic> map) {
    return DeviceReport(
      question: map['question'] ?? '',
      parentId: map['parentId']?.toInt() ?? 0,
      weightage: map['weightage']?.toInt() ?? 0,
      child: List<SQuestions>.from(
          map['child']?.map((x) => SQuestions.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory DeviceReport.fromJson(String source) =>
      DeviceReport.fromMap(json.decode(source));
}

class SQuestions {
  int id;
  String sub_question;
  int weightage;

  SQuestions({
    required this.id,
    required this.sub_question,
    required this.weightage,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sub_question': sub_question,
      'weightage': weightage,
    };
  }

  factory SQuestions.fromMap(Map<String, dynamic> map) {
    return SQuestions(
      id: map['id']?.toInt() ?? 0,
      sub_question: map['sub_question'] ?? '',
      weightage: map['weightage']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SQuestions.fromJson(String source) =>
      SQuestions.fromMap(json.decode(source));
}

class SAccessories {
  String name;
  int id;
  int weightage;

  SAccessories({
    required this.name,
    required this.id,
    required this.weightage,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'weightage': weightage,
    };
  }

  factory SAccessories.fromMap(Map<String, dynamic> map) {
    return SAccessories(
      name: map['name'] ?? '',
      id: map['id']?.toInt() ?? 0,
      weightage: map['weightage']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SAccessories.fromJson(String source) =>
      SAccessories.fromMap(json.decode(source));
}

class SWarranties {
  String name;
  int id;
  int weightage;

  SWarranties({
    required this.name,
    required this.id,
    required this.weightage,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'weightage': weightage,
    };
  }

  factory SWarranties.fromMap(Map<String, dynamic> map) {
    return SWarranties(
      name: map['name'] ?? '',
      id: map['id']?.toInt() ?? 0,
      weightage: map['weightage']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SWarranties.fromJson(String source) =>
      SWarranties.fromMap(json.decode(source));
}

class ProductSum {
  int id;
  List<DeviceReport> report;
  List<SAccessories> accessories;
  ProductSum({
    required this.id,
    required this.report,
    required this.accessories,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'report': report.map((x) => x.toMap()).toList(),
      'accessories': accessories.map((x) => x.toMap()).toList(),
    };
  }

  factory ProductSum.fromMap(Map<String, dynamic> map) {
    return ProductSum(
      id: map['id']?.toInt() ?? 0,
      report: List<DeviceReport>.from(
          map['report']?.map((x) => DeviceReport.fromMap(x))),
      accessories: List<SAccessories>.from(
          map['accessories']?.map((x) => SAccessories.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductSum.fromJson(String source) =>
      ProductSum.fromMap(json.decode(source));
}
