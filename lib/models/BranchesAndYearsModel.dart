import 'dart:convert';

/// success : true
/// data : {"booklets":[{"id":1,"duration":1,"name":"Test1","description":"Teating1","status":"0","level":"1","total_weightage":100,"created_by":1,"updated_by":null,"created_at":"2025-04-15T14:51:50.000000Z","updated_at":"2025-04-15T14:51:50.000000Z"}],"years":["First Year","Second Year","Third Year","Fourth Year"],"branches":["Computer Science","Mechanical","Civil","Electrical"]}

BranchesAndYearsModel branchesAndYearsModelFromJson(String str) =>
    BranchesAndYearsModel.fromJson(json.decode(str));
String branchesAndYearsModelToJson(BranchesAndYearsModel data) =>
    json.encode(data.toJson());

class BranchesAndYearsModel {
  BranchesAndYearsModel({
    bool? success,
    Data? data,
  }) {
    _success = success;
    _data = data;
  }

  BranchesAndYearsModel.fromJson(dynamic json) {
    _success = json['success'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _success;
  Data? _data;
  BranchesAndYearsModel copyWith({
    bool? success,
    Data? data,
  }) =>
      BranchesAndYearsModel(
        success: success ?? _success,
        data: data ?? _data,
      );
  bool? get success => _success;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

/// booklets : [{"id":1,"duration":1,"name":"Test1","description":"Teating1","status":"0","level":"1","total_weightage":100,"created_by":1,"updated_by":null,"created_at":"2025-04-15T14:51:50.000000Z","updated_at":"2025-04-15T14:51:50.000000Z"}]
/// years : ["First Year","Second Year","Third Year","Fourth Year"]
/// branches : ["Computer Science","Mechanical","Civil","Electrical"]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    List<Booklets>? booklets,
    List<String>? years,
    List<String>? branches,
  }) {
    _booklets = booklets;
    _years = years;
    _branches = branches;
  }

  Data.fromJson(dynamic json) {
    if (json['booklets'] != null) {
      _booklets = [];
      json['booklets'].forEach((v) {
        _booklets?.add(Booklets.fromJson(v));
      });
    }
    _years = json['years'] != null ? json['years'].cast<String>() : [];
    _branches = json['branches'] != null ? json['branches'].cast<String>() : [];
  }
  List<Booklets>? _booklets;
  List<String>? _years;
  List<String>? _branches;
  Data copyWith({
    List<Booklets>? booklets,
    List<String>? years,
    List<String>? branches,
  }) =>
      Data(
        booklets: booklets ?? _booklets,
        years: years ?? _years,
        branches: branches ?? _branches,
      );
  List<Booklets>? get booklets => _booklets;
  List<String>? get years => _years;
  List<String>? get branches => _branches;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_booklets != null) {
      map['booklets'] = _booklets?.map((v) => v.toJson()).toList();
    }
    map['years'] = _years;
    map['branches'] = _branches;
    return map;
  }
}

/// id : 1
/// duration : 1
/// name : "Test1"
/// description : "Teating1"
/// status : "0"
/// level : "1"
/// total_weightage : 100
/// created_by : 1
/// updated_by : null
/// created_at : "2025-04-15T14:51:50.000000Z"
/// updated_at : "2025-04-15T14:51:50.000000Z"

Booklets bookletsFromJson(String str) => Booklets.fromJson(json.decode(str));
String bookletsToJson(Booklets data) => json.encode(data.toJson());

class Booklets {
  Booklets({
    num? id,
    num? duration,
    String? name,
    String? description,
    String? status,
    String? level,
    num? totalWeightage,
    num? createdBy,
    dynamic updatedBy,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _duration = duration;
    _name = name;
    _description = description;
    _status = status;
    _level = level;
    _totalWeightage = totalWeightage;
    _createdBy = createdBy;
    _updatedBy = updatedBy;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Booklets.fromJson(dynamic json) {
    _id = json['id'];
    _duration = json['duration'];
    _name = json['name'];
    _description = json['description'];
    _status = json['status'];
    _level = json['level'];
    _totalWeightage = json['total_weightage'];
    _createdBy = json['created_by'];
    _updatedBy = json['updated_by'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  num? _duration;
  String? _name;
  String? _description;
  String? _status;
  String? _level;
  num? _totalWeightage;
  num? _createdBy;
  dynamic _updatedBy;
  String? _createdAt;
  String? _updatedAt;
  Booklets copyWith({
    num? id,
    num? duration,
    String? name,
    String? description,
    String? status,
    String? level,
    num? totalWeightage,
    num? createdBy,
    dynamic updatedBy,
    String? createdAt,
    String? updatedAt,
  }) =>
      Booklets(
        id: id ?? _id,
        duration: duration ?? _duration,
        name: name ?? _name,
        description: description ?? _description,
        status: status ?? _status,
        level: level ?? _level,
        totalWeightage: totalWeightage ?? _totalWeightage,
        createdBy: createdBy ?? _createdBy,
        updatedBy: updatedBy ?? _updatedBy,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  num? get duration => _duration;
  String? get name => _name;
  String? get description => _description;
  String? get status => _status;
  String? get level => _level;
  num? get totalWeightage => _totalWeightage;
  num? get createdBy => _createdBy;
  dynamic get updatedBy => _updatedBy;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['duration'] = _duration;
    map['name'] = _name;
    map['description'] = _description;
    map['status'] = _status;
    map['level'] = _level;
    map['total_weightage'] = _totalWeightage;
    map['created_by'] = _createdBy;
    map['updated_by'] = _updatedBy;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
