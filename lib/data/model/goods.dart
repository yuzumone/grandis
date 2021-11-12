import 'package:grandis/data/model/item.dart';

class Goods implements Item {
  final String name;
  final String url;
  final String image;
  final String price;
  final String? date;

  Goods(this.name, this.url, this.image, this.price, this.date);

  @override
  String getTitle() {
    return name;
  }

  @override
  String getSubTitle() {
    var str = <String>[];
    str.add(price);
    if (date != null) str.add(date!);
    return str.join('\n');
  }

  @override
  String getImage() {
    return image;
  }

  @override
  String getUrl() {
    return url;
  }

  @override
  String toString() {
    return 'Goods<name: $name, price: $price>';
  }
}
