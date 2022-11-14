class GlucoseData {
  String? fromDate;
  List<Glucose>? glucose;

  GlucoseData({this.fromDate, this.glucose});

  GlucoseData.fromJson(Map<String, dynamic> json) {
    fromDate = json['fromDate'];
    if (json['glucose'] != null) {
      glucose = <Glucose>[];
      json['glucose'].forEach((v) {
        glucose!.add(new Glucose.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fromDate'] = this.fromDate;
    if (this.glucose != null) {
      data['glucose'] = this.glucose!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Glucose {
  String? date;
  double? glucose;

  Glucose({this.date, this.glucose});

  Glucose.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    glucose = json['glucose'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['glucose'] = this.glucose;
    return data;
  }
}