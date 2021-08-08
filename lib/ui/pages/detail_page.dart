part of 'pages.dart';

class DetailPage extends StatelessWidget {
  final Article article;
  const DetailPage(this.article, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: height(10),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                  ),
                  Align(
                      alignment: Alignment.center, child: Text("Detail News")),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Center(
                    child: Container(
                      height: height(40),
                      child: Stack(
                        children: [
                          Container(
                            child: showImage(article.urlToImage)),
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
                          )
                        ],
                      ),
                    ),
                  ),
                  CustomSpacerHeight(2),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width(5)),
                    child: Text(
                      article.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: width(3.7)),
                    ),
                  ),
                  CustomSpacerHeight(1),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width(5)),
                    child: Text(
                      "From ${article.source.name} - ${DateFormat("h:m a dd MMMM yyyy").format(article.publishedAt!)}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w300, fontSize: width(3.2)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: height(2), horizontal: width(5)),
                    child: Text(
                      article.content?.split("[").first ?? article.desription!,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: width(3.5)),
                    ),
                  ),
                  CustomSpacerHeight(8),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: width(15)),
                      width: double.infinity,
                      height: height(6.5),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.black,
                          primary: Colors.white,
                        ),
                        onPressed: () async {
                          await canLaunch(article.url)
                              ? await launch(article.url)
                              : ScaffoldMessenger.of(context).showSnackBar(
                                  snackbar("Can't open this url"));
                        },
                        child: Text("Browse More"),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
