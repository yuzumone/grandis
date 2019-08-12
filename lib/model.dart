class Item {
  String getTitle() => '';
  String getSubTitle() => '';
}

class Attraction implements Item {
  String name;
  String url;
  String standbyTime;
  String status;
  String updateTime;
  String fsStatus;

  Attraction();

  Attraction.fromMap(Map<String, dynamic> map) {
    this.name = map['FacilityName'];
    this.url = map['FacilityURLSP'];
    this.standbyTime = map['StandbyTime'].toString();
    this.status = map['OperatingStatus'];
    this.updateTime = map['UpdateTime'];
    this.fsStatus = map['FsStatus'];
  }

  @override
  String getTitle() {
    return name;
  }

  @override
  String getSubTitle() {
    List<String> str = [];
    if (standbyTime != "false" && standbyTime != "null") {
      str.add("待ち時間: $standbyTime分");
    }
    if (fsStatus != null) {
      str.add("FP: $fsStatus");
    }
    if (status != null) {
      str.add(status);
    }
    str.add("更新時間: $updateTime");
    return str.join("\n");
  }

  @override
  String toString() {
    return "name: $name, standbyTime: $standbyTime, status: $status, update: $updateTime";
  }
}
