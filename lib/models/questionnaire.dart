import 'dart:convert';

// ignore_for_file: non_constant_identifier_names

class Questionnaire {
  int id;
  String prop_image;
  String question_cat;
  String question;
  String if_yes;
  String if_no;
  int weightage;
  List<SubQuestion> specialsubquestion;

  Questionnaire({
    required this.id,
    required this.prop_image,
    required this.question_cat,
    required this.question,
    required this.if_yes,
    required this.if_no,
    required this.weightage,
    required this.specialsubquestion,
  });

  factory Questionnaire.fromMap(Map<String, dynamic> map) {
    return Questionnaire(
      id: map['id']?.toInt() ?? 0,
      prop_image: map['prop_image'] ?? '',
      question_cat: map['question_cat'] ?? '',
      question: map['question'] ?? '',
      if_yes: map['if_yes'] ?? '',
      if_no: map['if_no'] ?? '',
      weightage: map['weightage']?.toInt() ?? 0,
      specialsubquestion: List<SubQuestion>.from(
          map['specialsubquestion']?.map((x) => SubQuestion.fromMap(x))),
    );
  }
}

class SubQuestion {
  int id;
  String sub_question;
  String image;
  int weightage;

  SubQuestion({
    required this.id,
    required this.sub_question,
    required this.image,
    required this.weightage,
  });

  factory SubQuestion.fromMap(Map<String, dynamic> map) {
    return SubQuestion(
      id: map['id']?.toInt() ?? 0,
      sub_question: map['sub_question'] ?? '',
      image: map['image'] ?? '',
      weightage: map['weightage']?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sub_question': sub_question,
      'image': image,
      'weightage': weightage,
    };
  }

  String toJson() => json.encode(toMap());

  factory SubQuestion.fromJson(String source) =>
      SubQuestion.fromMap(json.decode(source));
}

class WarrantyQuestion {
  int id;
  String warranty;
  String image;
  int weightage;

  WarrantyQuestion({
    required this.id,
    required this.warranty,
    required this.image,
    required this.weightage,
  });

  factory WarrantyQuestion.fromMap(Map<String, dynamic> map) {
    return WarrantyQuestion(
      id: map['id']?.toInt() ?? 0,
      warranty: map['warranty'] ?? '',
      image: map['image'] ?? '',
      weightage: map['weightage']?.toInt() ?? 0,
    );
  }
}
