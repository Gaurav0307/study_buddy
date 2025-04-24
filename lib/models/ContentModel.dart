import 'dart:convert';

/// success : true
/// data : [{"id":3,"booklet_id":1,"question_type":"image","marks":10,"created_at":"2025-04-15T14:54:32.000000Z","updated_at":"2025-04-15T14:54:32.000000Z","question":"Test Question","option_1":null,"option_2":null,"option_3":null,"option_4":null,"image":"20250415145432_67fe7328a7365.png","answer":null},{"id":4,"booklet_id":1,"question_type":"pdf","marks":10,"created_at":"2025-04-15T14:55:43.000000Z","updated_at":"2025-04-15T14:55:43.000000Z","question":"Test Question","option_1":null,"option_2":null,"option_3":null,"option_4":null,"image":"20250415145543_67fe736f29b17.pdf","answer":null},{"id":5,"booklet_id":1,"question_type":"video","marks":10,"created_at":"2025-04-15T14:59:11.000000Z","updated_at":"2025-04-15T14:59:11.000000Z","question":"Test Question","option_1":null,"option_2":null,"option_3":null,"option_4":null,"image":"20250415145911_67fe743f53490.mp4","answer":null}]

ContentModel contentModelFromJson(String str) =>
    ContentModel.fromJson(json.decode(str));
String contentModelToJson(ContentModel data) => json.encode(data.toJson());

class ContentModel {
  ContentModel({
    bool? success,
    List<Data>? data,
  }) {
    _success = success;
    _data = data;
  }

  ContentModel.fromJson(dynamic json) {
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _success;
  List<Data>? _data;
  ContentModel copyWith({
    bool? success,
    List<Data>? data,
  }) =>
      ContentModel(
        success: success ?? _success,
        data: data ?? _data,
      );
  bool? get success => _success;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 3
/// booklet_id : 1
/// question_type : "image"
/// marks : 10
/// created_at : "2025-04-15T14:54:32.000000Z"
/// updated_at : "2025-04-15T14:54:32.000000Z"
/// question : "Test Question"
/// option_1 : null
/// option_2 : null
/// option_3 : null
/// option_4 : null
/// image : "20250415145432_67fe7328a7365.png"
/// answer : null

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    num? id,
    num? bookletId,
    String? questionType,
    num? marks,
    String? createdAt,
    String? updatedAt,
    String? question,
    dynamic option1,
    dynamic option2,
    dynamic option3,
    dynamic option4,
    String? image,
    dynamic answer,
  }) {
    _id = id;
    _bookletId = bookletId;
    _questionType = questionType;
    _marks = marks;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _question = question;
    _option1 = option1;
    _option2 = option2;
    _option3 = option3;
    _option4 = option4;
    _image = image;
    _answer = answer;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _bookletId = json['booklet_id'];
    _questionType = json['question_type'];
    _marks = json['marks'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _question = json['question'];
    _option1 = json['option_1'];
    _option2 = json['option_2'];
    _option3 = json['option_3'];
    _option4 = json['option_4'];
    _image = json['image'];
    _answer = json['answer'];
  }
  num? _id;
  num? _bookletId;
  String? _questionType;
  num? _marks;
  String? _createdAt;
  String? _updatedAt;
  String? _question;
  dynamic _option1;
  dynamic _option2;
  dynamic _option3;
  dynamic _option4;
  String? _image;
  dynamic _answer;
  Data copyWith({
    num? id,
    num? bookletId,
    String? questionType,
    num? marks,
    String? createdAt,
    String? updatedAt,
    String? question,
    dynamic option1,
    dynamic option2,
    dynamic option3,
    dynamic option4,
    String? image,
    dynamic answer,
  }) =>
      Data(
        id: id ?? _id,
        bookletId: bookletId ?? _bookletId,
        questionType: questionType ?? _questionType,
        marks: marks ?? _marks,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        question: question ?? _question,
        option1: option1 ?? _option1,
        option2: option2 ?? _option2,
        option3: option3 ?? _option3,
        option4: option4 ?? _option4,
        image: image ?? _image,
        answer: answer ?? _answer,
      );
  num? get id => _id;
  num? get bookletId => _bookletId;
  String? get questionType => _questionType;
  num? get marks => _marks;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get question => _question;
  dynamic get option1 => _option1;
  dynamic get option2 => _option2;
  dynamic get option3 => _option3;
  dynamic get option4 => _option4;
  String? get image => _image;
  dynamic get answer => _answer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['booklet_id'] = _bookletId;
    map['question_type'] = _questionType;
    map['marks'] = _marks;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['question'] = _question;
    map['option_1'] = _option1;
    map['option_2'] = _option2;
    map['option_3'] = _option3;
    map['option_4'] = _option4;
    map['image'] = _image;
    map['answer'] = _answer;
    return map;
  }
}
