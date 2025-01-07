// To parse this JSON data, do
//
//     final solutionRes = solutionResFromJson(jsonString);

import 'dart:convert';

SolutionRes solutionResFromJson(String str) => SolutionRes.fromJson(json.decode(str));

String solutionResToJson(SolutionRes data) => json.encode(data.toJson());

class SolutionRes {
  Solution solution;

  SolutionRes({
    required this.solution,
  });

  factory SolutionRes.fromJson(Map<String, dynamic> json) => SolutionRes(
    solution: Solution.fromJson(json["solution"]),
  );

  Map<String, dynamic> toJson() => {
    "solution": solution.toJson(),
  };
}

class Solution {
  String id;
  List<String> solution;

  Solution({
    required this.id,
    required this.solution,
  });

  factory Solution.fromJson(Map<String, dynamic> json) => Solution(
    id: json["_id"],
    solution: List<String>.from(json["solution"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "solution": List<dynamic>.from(solution.map((x) => x)),
  };
}
