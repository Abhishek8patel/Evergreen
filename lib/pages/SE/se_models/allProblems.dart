// To parse this JSON data, do
//
//     final allProblemsDto = allProblemsDtoFromJson(jsonString);

import 'dart:convert';

AllProblemsDto allProblemsDtoFromJson(String str) => AllProblemsDto.fromJson(json.decode(str));

String allProblemsDtoToJson(AllProblemsDto data) => json.encode(data.toJson());

class AllProblemsDto {
  Problems problems;

  AllProblemsDto({
    required this.problems,
  });

  factory AllProblemsDto.fromJson(Map<String, dynamic> json) => AllProblemsDto(
    problems: Problems.fromJson(json["Problems"]),
  );

  Map<String, dynamic> toJson() => {
    "Problems": problems.toJson(),
  };
}

class Problems {
  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  Problems({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory Problems.fromJson(Map<String, dynamic> json) => Problems(
    currentPage: json["current_page"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Datum {
  String id;
  String problem;
  List<String> solution;
  String datetime;

  Datum({
    required this.id,
    required this.problem,
    required this.solution,
    required this.datetime,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    problem: json["problem"],
    solution: List<String>.from(json["solution"].map((x) => x)),
    datetime: json["datetime"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "problem": problem,
    "solution": List<dynamic>.from(solution.map((x) => x)),
    "datetime": datetime,
  };
}

class Link {
  String? url;
  String label;
  bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
