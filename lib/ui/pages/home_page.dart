part of 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> loadData() async {
    final prov = context.read<NewsVM>();
    prov.loadHeadlines = true;
    await prov.getData(context, null);
    prov.loadHeadlines = false;
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomSpacerHeight(2),
            Container(
              width: width(40),
              padding: EdgeInsets.symmetric(horizontal: width(5)),
              child: Text(
                "US Headlines",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: width(4.5),
                ),
              ),
            ),
            CustomSpacerHeight(2),
            Container(
              height: height(25),
              child: Consumer<NewsVM>(builder: (context, data, _) {
                if (data.loadHeadlines) return CustomLoading();

                List<Article> originals = data.headlinesIDList;
                List<Article> items = data.headLinesPagination;

                return NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    //This is for load more pagination

                    if (items.length == originals.length) return false;

                    if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                      if ((items.length + 5) > originals.length) {
                        data.headLinesPagination.addAll(
                            originals.getRange(items.length, originals.length));
                      } else {
                        data.headLinesPagination.addAll(
                            originals.getRange(items.length, items.length + 5));
                      }
                      setState(() {});
                    }

                    return false;
                  },
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: (items.length <= originals.length)
                          ? items.length
                          : originals.length,
                      itemBuilder: (context, i) {
                        Article headline = items[i];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => DetailPage(headline)));
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                left: (i == 0) ? width(5) : 0,
                                right:
                                    (i == items.length) ? width(5) : width(2)),
                            child: Stack(
                              children: [
                                Container(
                                    child: showImage(headline.urlToImage)),
                                Container(
                                  width: width(80),
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    gradient: LinearGradient(
                                      begin: Alignment(0, 1),
                                      end: Alignment(0, 0.06),
                                      colors: [
                                        Colors.black,
                                        Colors.black.withOpacity(0)
                                      ],
                                    ),
                                  ),
                                  alignment: Alignment.bottomLeft,
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    headline.title,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                );
              }),
            ),
            CustomSpacerHeight(3),
            Expanded(
              child: DefaultTabController(
                length: 4,
                initialIndex: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TabBar(
                      isScrollable: true,
                      indicatorColor: Colors.black,
                      labelColor: Colors.black,
                      tabs: [
                        Tab(
                          text: "Business",
                        ),
                        Tab(
                          text: "Entertainment",
                        ),
                        Tab(
                          text: "Technology",
                        ),
                        Tab(
                          text: "Health",
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        child: Consumer<NewsVM>(
                          builder: (context, data, _) {
                            return TabBarView(
                              children: [
                                CategoryPage("Business", loadData),
                                CategoryPage("Entertainment", loadData),
                                CategoryPage("Technology", loadData),
                                CategoryPage("Health", loadData)
                              ],
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
