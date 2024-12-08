import 'package:hive_flutter/hive_flutter.dart';
part 'rating_model.g.dart';
@HiveType(typeId: 1)
class RatingModel {
  @HiveField(1)
  double rate;
  @HiveField(2)
  int count;
  RatingModel({
    required this.rate,
    required this.count,
  });

  factory RatingModel.fromMap(Map<String, dynamic> map) {
    return RatingModel(
      rate: (map['rate'].runtimeType == int)
          ? map['rate'].toDouble()
          : map['rate'],
      count: map['count'],
    );
  }

  @override
  String toString() => 'RatingModel(rate: $rate, count: $count)';
}
