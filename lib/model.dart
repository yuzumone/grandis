class Item {
  String getTitle() => '';
  String getSubTitle() => '';
}

class Attraction implements Item {
  String name;
  String? standbyTime;
  String? status;
  String? updateTime;
  String? fsStatus;

  Attraction(
      this.name, this.standbyTime, this.status, this.updateTime, this.fsStatus);

  factory Attraction.fromMap(Map<String, dynamic> map) {
    final name = map['FacilityName'];
    final standbyTime = map['StandbyTime'].toString();
    final status = map['OperatingStatus'];
    final updateTime = map['UpdateTime'];
    final fsStatus = map['FsStatus'];
    return Attraction(name, standbyTime, status, updateTime, fsStatus);
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
      str.add(status!);
    }
    str.add('更新時間: $updateTime');
    return str.join('\n');
  }

  @override
  String toString() {
    return 'name: $name, standbyTime: $standbyTime, status: $status, update: $updateTime';
  }
}

class Parade implements Item {
  String name;
  String? status;
  List<dynamic>? operatingHours;
  String? updateTime;

  Parade(this.name, this.status, this.operatingHours, this.updateTime);

  factory Parade.fromMap(Map<String, dynamic> map) {
    final name = map['FacilityName'];
    final status = map['FacilityStatus'];
    final operatingHours = map['operatingHours'];
    final updateTime = map['UpdateTime'];
    return Parade(name, status, operatingHours, updateTime);
  }

  @override
  String getTitle() {
    return name;
  }

  @override
  String getSubTitle() {
    var str = <String>[];
    if (status != null) {
      str.add(status!);
    }
    if (operatingHours != null) {
      operatingHours!.forEach((hour) {
        str.add('${hour['OperatingHoursFrom']} - ');
      });
    }
    str.add('更新時間: $updateTime');
    return str.join('\n');
  }

  @override
  String toString() {
    return 'name: $name, status: $status, operating: $operatingHours, update: $updateTime';
  }
}

class Greeting implements Item {
  String name;
  String? area;
  String? status;
  String? standbyTime;
  List<dynamic>? operatingHours;
  String? updateTime;

  Greeting(this.name, this.area, this.status, this.standbyTime,
      this.operatingHours, this.updateTime);

  factory Greeting.fromMap(Map<String, dynamic> map) {
    final name = map['FacilityName'];
    final area = map['AreaJName'];
    final status = map['FacilityStatus'];
    final standbyTime = map['StandbyTime'];
    final operatingHours = map['operatinghours'];
    final updateTime = map['UpdateTime'];
    return Greeting(
        name, area, status, standbyTime, operatingHours, updateTime);
  }

  @override
  String getTitle() {
    return name;
  }

  @override
  String getSubTitle() {
    var str = <String>[];
    if (status != null) {
      str.add(status!);
    }
    if (standbyTime != null) {
      str.add('待ち時間: $standbyTime分');
    }
    if (operatingHours != null) {
      operatingHours!.forEach((hour) {
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
  String toString() {
    return 'name: $name, area: $area, status: $status, standby: $standbyTime, operating: $operatingHours, update: $updateTime';
  }
}

class Restaurant implements Item {
  String name;
  String? status;
  String? standbyTimeMin;
  String? standbyTimeMax;
  List<dynamic>? operatingHours;
  String? updateTime;
  String? popCornFlavors;

  Restaurant(this.name, this.status, this.standbyTimeMin, this.standbyTimeMax,
      this.operatingHours, this.updateTime, this.popCornFlavors);

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    final name = map['FacilityName'];
    final status = map['FacilityStatus'];
    final standbyTimeMin = map['StandbyTimeMin'].toString();
    final standbyTimeMax = map['StandbyTimeMax'].toString();
    final operatingHours = map['operatingHours'];
    final updateTime = map['UpdateTime'];
    final popCornFlavors = map['PopCornFlavors'];
    return Restaurant(name, status, standbyTimeMin, standbyTimeMax,
        operatingHours, updateTime, popCornFlavors);
  }

  @override
  String getTitle() {
    return name;
  }

  @override
  String getSubTitle() {
    var str = <String>[];
    if (status != null) {
      str.add(status!);
    }
    String? wait;
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
      operatingHours!.forEach((hour) {
        var sta = hour['OperatingStatus'];
        sta ??= '';
        str.add(
            '${hour['OperatingHoursFrom']} - ${hour['OperatingHoursTo']}\t$sta');
      });
    }
    if (popCornFlavors != null) {
      str.add(popCornFlavors!);
    }
    str.add('更新時間: $updateTime');
    return str.join('\n');
  }

  @override
  String toString() {
    return 'name: $name, status: $status, min: $standbyTimeMin, max: $standbyTimeMax, operating: $operatingHours, update: $updateTime';
  }
}

class Rehabilitate implements Item {
  String name;
  String date;

  Rehabilitate(this.name, this.date);

  @override
  String getTitle() {
    return name;
  }

  @override
  String getSubTitle() {
    return date;
  }

  @override
  String toString() {
    return 'name: $name, date: $date';
  }
}
