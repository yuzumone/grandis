import 'package:grandis/data/model/item.dart';

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
  String getImage() {
    return '';
  }

  @override
  String getUrl() {
    return '';
  }

  @override
  String toString() {
    return 'name: $name, date: $date';
  }
}
