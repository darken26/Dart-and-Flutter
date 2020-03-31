import 'package:flutter_test/flutter_test.dart';
import 'package:loginbloc/src/resources/news_api_provider.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'dart:convert';

void main() {
  test('FetchTopIds return a list of ids', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    });

    final ids = await newsApi.fetchTopIds();

    expect(ids, [1, 2, 3, 4]);
  });

  test('FetchItems return an ItemModel', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      return Response(json.encode({'id': 231}), 200);
    });

    final item = await newsApi.fetchItem(999);

    expect(item.id, 231);
  });
}