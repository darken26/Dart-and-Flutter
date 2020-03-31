import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

class Repository {
  NewsDbProvider _dbProvider = NewsDbProvider();
  NewsApiProvider _apiProvider = NewsApiProvider();

  Future<List<int>> fetchTopIds() {
    return _apiProvider.fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    var item = await _dbProvider.fetchItem(id);
    if(item != null)
      return item;

    item = await _apiProvider.fetchItem(id);
     _dbProvider.insertItem(item);

     return item;
  }
}