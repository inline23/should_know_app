import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:should_know_app/model/articles_model.dart';
import 'package:should_know_app/pages/article_details_page.dart';
import 'package:should_know_app/services/api_services.dart';
import 'package:should_know_app/utilities/layout_util.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class ArticleCardWidget extends StatefulWidget {
  bool? isReload;
  ArticleCardWidget({super.key, this.model, this.isReload});
  ArticlesModel? model;

  @override
  State<ArticleCardWidget> createState() => _ArticleCardWidgetState();
}

class _ArticleCardWidgetState extends State<ArticleCardWidget> {
  APIService? apiService;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ), // press to open the article page
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ArticleDetails(
              model: widget.model,
            ),
          ));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                  child: FutureBuilder(
                    future: APIService.fetchWpPostImageUrl(
                        widget.model!.href.toString()),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Image.network(
                          snapshot.data!["guid"]["rendered"].toString(),
                          fit: BoxFit.cover,
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 13),
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Color(0xFF21C8DF),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: FutureBuilder(
                      future: APIService.fetchCategoryName(
                          widget.model!.categoryInfoHref.toString()),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          // Category Label Name **
                          return Text(
                            snapshot.data![0]["name"].toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Cairo',
                              fontSize: 15,
                            ),
                          );
                        }
                        return Text(
                          "Loading..",
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              color: Colors.black, fontFamily: 'Cairo'),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: HtmlWidget(
                      widget.model?.title.toString() ?? "First Title",
                      textStyle: TextStyle(
                        fontFamily: "Cairo",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // author name label
                      FutureBuilder(
                        future: APIService.fetchAoutherName(
                            widget.model!.aoutherLink.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Row(
                              children: [
                                Text(
                                  "${AppLocalizations.of(context)!.author} : ",
                                  style: TextStyle(fontFamily: "Cairo"),
                                ),
                                Text(
                                  snapshot.data!["name"].toString(),
                                  style: TextStyle(
                                    fontFamily: "Cairo",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            );
                          }
                          return Text(
                            "Loading..",
                            textDirection: TextDirection.ltr,
                          );
                        },
                      ),
                      LayoutUtil.iconText(
                        const Icon(Icons.calendar_month_outlined),
                        Text(
                          widget.model?.postedDate ?? 'no Date',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
