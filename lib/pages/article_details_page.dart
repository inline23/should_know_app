import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:share_plus/share_plus.dart';
import 'package:should_know_app/model/articles_model.dart';
import 'package:should_know_app/services/api_services.dart';
import 'package:should_know_app/utilities/layout_util.dart';

// ignore: must_be_immutable
class ArticleDetails extends StatefulWidget {
  ArticlesModel? model;
  ArticleDetails({
    super.key,
    this.model,
  });

  @override
  State<ArticleDetails> createState() => _ArticleDetailsState();
}

class _ArticleDetailsState extends State<ArticleDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              background: FutureBuilder(
                future: APIService.fetchWpPostImageUrl(
                    widget.model!.href.toString()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Image.network(
                      snapshot.data!["guid"]["rendered"].toString(),
                      fit: BoxFit.cover,
                    );
                  }
                  return Center(
                    child: SizedBox(
                        width: 35,
                        child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.surface)),
                  );
                },
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 4,
            expandedHeight: 250,
          ),
          SliverFillRemaining(
            child: SingleChildScrollView(child: aritcleDetailSection()),
          )
        ],
      ),
    );
  }

  Widget aritcleDetailSection() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          row1(),
          const SizedBox(height: 15),
          Directionality(
            textDirection: TextDirection.rtl,
            child: HtmlWidget(
              widget.model?.title.toString() ?? "First Title",
              textStyle: TextStyle(
                fontFamily: "Cairo",
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF21C8DF),
              ),
            ),
          ),
          const SizedBox(
            width: 100,
            child: Divider(color: Color(0xFF21C8DF), thickness: 2),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: HtmlWidget(
              widget.model!.postContent.toString(),
              textStyle: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget row1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: LayoutUtil.iconText(
              const Icon(Icons.calendar_month_outlined),
              Text(
                widget.model!.postedDate.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              )),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Row(
            children: [
              // dark mode switch button
              // IconButton(
              //   icon: Provider.of<ThemeProvider>(context).themeData == lightMode
              //       ? Icon(Icons.dark_mode)
              //       : Icon(Icons.light_mode),
              //   onPressed: () {
              //     Provider.of<ThemeProvider>(context, listen: false)
              //         .toggleTheme();
              //   },
              // ),
              IconButton(
                onPressed: () {
                  Share.share(widget.model!.link.toString());
                },
                icon: Icon(
                  Icons.share,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
