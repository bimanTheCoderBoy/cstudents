import 'dart:convert';

class StudentEntity {
  String? _name;
  List<Object>? _account;
  int? _balance;
  String? _batch;
  String? _gaurdianNumber;
  String? _studentNumber;
  List<Object>? _studentExamArray;
  String? _tId;
  String? _class;
  Map<String, int>? quizMap = {};

  StudentEntity(
      {String? name,
      List<Object>? account,
      int? balance,
      String? batch,
      String? gaurdianNumber,
      String? studentNumber,
      List<Object>? studentExamArray}) {
    if (name != null) {
      this._name = name;
    }
    if (account != null) {
      this._account = account;
    }
    if (balance != null) {
      this._balance = balance;
    }
    if (batch != null) {
      this._batch = batch;
    }
    if (gaurdianNumber != null) {
      this._gaurdianNumber = gaurdianNumber;
    }
    if (studentNumber != null) {
      this._studentNumber = studentNumber;
    }
    if (studentExamArray != null) {
      this._studentExamArray = studentExamArray;
    }
  }
  String? get sclass => _class;
  set sclass(String? sclass) => _class = sclass;
  String? get tId => _tId;
  set tId(String? tId) => _tId = tId;
  String? get name => _name;
  set name(String? name) => _name = name;
  List<Object>? get account => _account;
  set account(List<Object>? account) => _account = account;
  int? get balance => _balance;
  set balance(int? balance) => _balance = balance;
  String? get batch => _batch;
  set batch(String? batch) => _batch = batch;
  String? get gaurdianNumber => _gaurdianNumber;
  set gaurdianNumber(String? gaurdianNumber) =>
      _gaurdianNumber = gaurdianNumber;
  String? get studentNumber => _studentNumber;
  set studentNumber(String? studentNumber) => _studentNumber = studentNumber;
  List<Object>? get studentExamArray => _studentExamArray;
  set studentExamArray(List<Object>? studentExamArray) =>
      _studentExamArray = studentExamArray;

  StudentEntity.fromJson(Map<String, dynamic>? json) {
    _name = json?['name'];
    if (json?['account'] != null) {
      _account = <Object>[];
      json?['account'].forEach((v) {
        _account!.add(v);
      });
    }
    _balance = json?['balance'];
    _batch = json?['batch'];
    _gaurdianNumber = "${json?['guardianNumber']}";
    _studentNumber = "${json?['number']}";
    if (json?['studentExamArray'] != null) {
      _studentExamArray = <Object>[];
      json?['studentExamArray'].forEach((v) {
        _studentExamArray!.add(v);
      });
    }
    if (json?['studentQuizArray'] != null) {
      quizMap = Map.castFrom(jsonDecode(json?['studentQuizArray']));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    if (this._account != null) {
      data['account'] = this._account!.map((v) => v).toList();
    }
    data['balance'] = this._balance;
    data['batch'] = this._batch;
    data['guardianNumber'] = int.parse(this._gaurdianNumber ?? "0");
    data['number'] = int.parse(this._studentNumber ?? "0");
    if (this._studentExamArray != null) {
      data['studentExamArray'] = this._studentExamArray!.map((v) => v).toList();
    }
    data['studentQuizArray'] = jsonEncode(quizMap);
    return data;
  }
}
