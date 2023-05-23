import 'package:google_search/core/models/google_search_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GoogleSearchModel', () {
    const link = 'https://example.com';
    const title = 'Example Title';

    test('copyWith() should create a new instance with updated link', () {
      final original = GoogleSearchModel(link: link, title: title);
      final updated = original.copyWith(link: 'https://updated.com');

      expect(original.link, equals(link));
      expect(updated.link, equals('https://updated.com'));
      expect(updated.title, equals(title));
    });

    test('copyWith() should create a new instance with updated title', () {
      final original = GoogleSearchModel(link: link, title: title);
      final updated = original.copyWith(title: 'Updated Title');

      expect(original.title, equals(title));
      expect(updated.link, equals(link));
      expect(updated.title, equals('Updated Title'));
    });

    test('toMap() should return a map with the correct values', () {
      final model = GoogleSearchModel(link: link, title: title);
      final map = model.toMap();

      expect(map['link'], equals(link));
      expect(map['title'], equals(title));
    });

    test('fromMap() should create a new instance from a map', () {
      final map = {'link': link, 'title': title};
      final model = GoogleSearchModel.fromMap(map);

      expect(model.link, equals(link));
      expect(model.title, equals(title));
    });

    test('equality should work correctly', () {
      final model1 = GoogleSearchModel(link: link, title: title);
      final model2 = GoogleSearchModel(link: link, title: title);
      final model3 = GoogleSearchModel(link: 'different link', title: title);

      expect(model1, equals(model2));
      expect(model1.hashCode, equals(model2.hashCode));

      expect(model1, isNot(equals(model3)));
      expect(model1.hashCode, isNot(equals(model3.hashCode)));
    });
  });
}
