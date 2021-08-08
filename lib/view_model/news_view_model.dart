part of 'vm.dart';

class NewsVM with ChangeNotifier {
  List<Article> headlinesIDList = [];
  List<Article> _headlinesPagination = [];
  List<Article> get headLinesPagination => _headlinesPagination;
  set headLinesPagination(List<Article> value) {
    _headlinesPagination.addAll(value);
    notifyListeners();
  }

  bool loadHeadlines = false;

  List<Article> categoryList = [];
  List<Article> categoryPagination = [];

  bool loadCategory = false;

  Future<void> getData(BuildContext context, String? category,
      {cancelTok}) async {

    assert(() {
      print(category);
      return true;
    }());

    Map<String, dynamic> param = {
      "category": category?.toLowerCase() ?? null,
    };

    ResponseAPI result = await ConsumeAPI().get(param, cancelTok);

    if (result.data != null) {
      List<Article> articles = (result.data['articles'] as List<dynamic>)
          .map((e) => Article.fromJson(e))
          .toList()
          .where((element) =>
              element.urlToImage != null && element.desription != null)
          .toList();

      if (category != null) {
        categoryList.clear();
        categoryPagination.clear();
        categoryList = articles;
        categoryPagination.addAll(categoryList.getRange(0, 5));
      } else {
        headlinesIDList = articles;
        headLinesPagination.clear();
        _headlinesPagination.addAll(headlinesIDList.getRange(0, 5));
      }
      assert(() {
        print(result.data);
        return true;
      }());
    } else {
      if (result.msg != "Move Page") {
        ScaffoldMessenger.of(context).showSnackBar(snackbar(result.msg));
      }
    }

    notifyListeners();
  }
}
