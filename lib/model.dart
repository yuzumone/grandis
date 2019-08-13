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

class Parade implements Item {
  String name;
  String url;
  String status;
  List<dynamic> operatingHours;
  String updateTime;

  Parade();

  Parade.fromMap(Map<String, dynamic> map) {
    this.name = map['FacilityName'];
    this.url = map['FacilityURLSP'];
    this.status = map['FacilityStatus'];
    this.operatingHours = map['operatingHours'];
    this.updateTime = map['UpdateTime'];
  }

  @override
  String getTitle() {
    return name;
  }

  @override
  String getSubTitle() {
    List<String> str = [];
    if (status != null) {
      str.add(status);
    }
    if (operatingHours != null) {
      operatingHours.forEach((hour) {
        str.add("${hour['OperatingHoursFrom']} - ");
      });
    }
    str.add("更新時間: $updateTime");
    return str.join('\n');
  }
}

class Greeting implements Item {
  String name;
  String area;
  String url;
  String status;
  String standbyTime;
  List<dynamic> operatingHours;
  String updateTime;

  Greeting();

  Greeting.fromMap(Map<String, dynamic> map) {
    this.name = map['FacilityName'];
    this.area = map['AreaJName'];
    this.url = map['FacilityURLSP'];
    this.status = map['FacilityStatus'];
    this.standbyTime = map['StandbyTime'];
    this.operatingHours = map['operatinghours'];
    this.updateTime = map['UpdateTime'];
  }

  @override
  String getTitle() {
    return name;
  }

  @override
  String getSubTitle() {
    List<String> str = [];
    if (status != null) {
      str.add(status);
    }
    if (standbyTime != null) {
      str.add("待ち時間: $standbyTime分");
    }
    if (operatingHours != null) {
      operatingHours.forEach((hour) {
        var sta = hour['OperatingStatus'];
        sta ??= '';
        str.add("${hour['OperatingHoursFrom']} - ${hour['OperatingHoursTo']}\t$sta");
      });
    }
    str.add("更新時間: $updateTime");
    return str.join('\n');
  }
}
