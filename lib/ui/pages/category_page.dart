part of 'pages.dart';

class CategoryPage extends StatefulWidget {
  final String title;
  final Function() callbackFunction;
  const CategoryPage(this.title, this.callbackFunction, {Key? key})
      : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool load = false;

  Future<void> _refresh() async {
    if (mounted) {
      await widget.callbackFunction();
      await loadData();
    }
  }

  Future<void> loadData() async {
    // For handle when refresh active and user move page
    if(!mounted) return;

    // Cancel consume api previose category
    if (!cancelToken.isCancelled) cancelToken.cancel("Move Page");

    final prov = context.read<NewsVM>();
    cancelToken = CancelToken();

    prov
        .getData(context, widget.title.toLowerCase(), cancelTok: cancelToken)
        .then((value) {
      if (mounted)
        setState(() {
          load = false;
        });
    });
  }

  @override
  void initState() {
    load = true;
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<NewsVM>();
    List<Article> originals = prov.categoryList;
    List<Article> items = prov.categoryPagination;

    if (load) {
      return CustomLoading();
    }

    return NotificationListener(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          // This is for load more pagination

          if (items.length == originals.length) return false;

          if ((items.length + 5) > originals.length) {
            prov.categoryPagination
                .addAll(originals.getRange(items.length, originals.length));
          } else {
            prov.categoryPagination
                .addAll(originals.getRange(items.length, items.length + 5));
          }
          setState(() {});
        }

        return false;
      },
      child: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.builder(
          physics: ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: (items.length <= originals.length)
              ? items.length
              : originals.length,
          itemBuilder: (context, i) {
            final item = items[i];
            return InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => DetailPage(item)));
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: height(1), horizontal: width(5)),
                width: double.infinity,
                // color: Colors.red,
                height: height(22),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      height: height(18),
                      child: showImage(item.urlToImage, w: 20),
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          item.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: width(3),
                          ),
                        ),
                        CustomSpacerHeight(0.5),
                        Text(
                          "${DateFormat("h:m a dd MMMM yyyy").format(item.publishedAt!)}",
                          style: TextStyle(
                              fontSize: width(3), fontWeight: FontWeight.w300),
                        ),
                        CustomSpacerHeight(0.8),
                        Text(
                          item.desription!,
                          maxLines: 2,
                          style: TextStyle(fontSize: width(3)),
                        ),
                        CustomSpacerHeight(0.8),
                        Text(
                          "From ${item.source.name}",
                          style: TextStyle(fontSize: width(3)),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
