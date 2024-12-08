import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'category_provider.g.dart';

@Riverpod(keepAlive: true)
class Category extends _$Category {
  @override
  List<String> build() {
    return [];
  }

  void addCategory(List<String> categories) {
    state = ["All", ...categories];
  }
}
