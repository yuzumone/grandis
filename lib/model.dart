class Item {
  String getTitle() => '';
  String getSubTitle() => '';
  String getUrl() => '';
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
    name = map['FacilityName'];
    url = map['FacilityURLSP'];
    standbyTime = map['StandbyTime'].toString();
    status = map['OperatingStatus'];
    updateTime = map['UpdateTime'];
    fsStatus = map['FsStatus'];
  }

  @override
  String getTitle() {
    return name;
  }

  @override
  String getSubTitle() {
    var str = <String>[];
    if (standbyTime != 'false' && standbyTime != 'null') {
      str.add('待ち時間: $standbyTime分');
    }
    if (fsStatus != null) {
      str.add('FP: $fsStatus');
    }
    if (status != null) {
      str.add(status);
    }
    str.add('更新時間: $updateTime');
    return str.join('\n');
  }

  @override
  String getUrl() {
    return url;
  }

  @override
  String toString() {
    return 'name: $name, standbyTime: $standbyTime, status: $status, update: $updateTime';
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
    name = map['FacilityName'];
    url = map['FacilityURLSP'];
    status = map['FacilityStatus'];
    operatingHours = map['operatingHours'];
    updateTime = map['UpdateTime'];
  }

  @override
  String getTitle() {
    return name;
  }

  @override
  String getSubTitle() {
    var str = <String>[];
    if (status != null) {
      str.add(status);
    }
    if (operatingHours != null) {
      operatingHours.forEach((hour) {
        str.add('${hour['OperatingHoursFrom']} - ');
      });
    }
    str.add('更新時間: $updateTime');
    return str.join('\n');
  }

  @override
  String getUrl() {
    return url;
  }

  @override
  String toString() {
    return 'name: $name, status: $status, operating: $operatingHours, update: $updateTime';
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
    name = map['FacilityName'];
    area = map['AreaJName'];
    url = map['FacilityURLSP'];
    status = map['FacilityStatus'];
    standbyTime = map['StandbyTime'];
    operatingHours = map['operatinghours'];
    updateTime = map['UpdateTime'];
  }

  @override
  String getTitle() {
    return name;
  }

  @override
  String getSubTitle() {
    var str = <String>[];
    if (status != null) {
      str.add(status);
    }
    if (standbyTime != null) {
      str.add('待ち時間: $standbyTime分');
    }
    if (operatingHours != null) {
      operatingHours.forEach((hour) {
        var sta = hour['OperatingStatus'];
        sta ??= '';
        str.add(
            '${hour['OperatingHoursFrom']} - ${hour['OperatingHoursTo']}\t$sta');
      });
    }
    str.add('更新時間: $updateTime');
    return str.join('\n');
  }

  @override
  String getUrl() {
    return url;
  }

  @override
  String toString() {
    return 'name: $name, area: $area, status: $status, standby: $standbyTime, operating: $operatingHours, update: $updateTime';
  }
}

class Restaurant implements Item {
  String name;
  String url;
  String status;
  String standbyTimeMin;
  String standbyTimeMax;
  List<dynamic> operatingHours;
  String updateTime;
  String popCornFlavors;

  Restaurant();

  Restaurant.fromMap(Map<String, dynamic> map) {
    name = map['FacilityName'];
    url = map['FacilityURLSP'];
    status = map['FacilityStatus'];
    standbyTimeMin = map['StandbyTimeMin'].toString();
    standbyTimeMax = map['StandbyTimeMax'].toString();
    operatingHours = map['operatingHours'];
    updateTime = map['UpdateTime'];
    popCornFlavors = map['PopCornFlavors'];
  }

  @override
  String getTitle() {
    return name;
  }

  @override
  String getSubTitle() {
    var str = <String>[];
    if (status != null) {
      str.add(status);
    }
    String wait;
    if (standbyTimeMin == 'null' && standbyTimeMax == 'null') {
      wait = null;
    } else if (standbyTimeMax == 'null') {
      wait = '$standbyTimeMin分以上';
    } else if (standbyTimeMin == standbyTimeMax) {
      wait = '$standbyTimeMax分';
    } else {
      wait = '$standbyTimeMin - $standbyTimeMax分';
    }
    if (wait != null) {
      str.add('待ち時間: $wait');
    }
    if (operatingHours != null) {
      operatingHours.forEach((hour) {
        var sta = hour['OperatingStatus'];
        sta ??= '';
        str.add(
            '${hour['OperatingHoursFrom']} - ${hour['OperatingHoursTo']}\t$sta');
      });
    }
    if (popCornFlavors != null) {
      str.add(popCornFlavors);
    }
    str.add('更新時間: $updateTime');
    return str.join('\n');
  }

  @override
  String getUrl() {
    return url;
  }

  @override
  String toString() {
    return 'name: $name, status: $status, min: $standbyTimeMin, max: $standbyTimeMax, operating: $operatingHours, update: $updateTime';
  }
}

class Rehabilitate implements Item {
  String name;
  String date;
  String url;

  Rehabilitate(this.name, this.date, this.url);

  @override
  String getTitle() {
    return name;
  }

  @override
  String getSubTitle() {
    return date;
  }

  @override
  String getUrl() {
    return url;
  }

  @override
  String toString() {
    return 'name: $name, date: $date';
  }
}
