import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:should_know_app/controllers/posts_controller.dart';
import 'package:should_know_app/widget/article_card_widget.dart';

// ignore: must_be_immutable
class AtticlesPage extends StatefulWidget {
  int? categoryId;
  bool? isReload;
  AtticlesPage({super.key, this.categoryId, this.isReload});

  @override
  State<AtticlesPage> createState() => _AtticlesPageState();
}

class _AtticlesPageState extends State<AtticlesPage> {
  final PostsController postsController = Get.put(PostsController());
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      if (widget.isReload!) {
        await postsController.fetchPosts(categoryId: widget.categoryId!);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return articlesList();
  }

  Widget articlesList() {
    return Obx(
      () {
        if (postsController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return RefreshIndicator(
              key: refreshKey,
              onRefresh: () =>
                  postsController.fetchPosts(categoryId: widget.categoryId!),
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: postsController.postsList.length,
                itemBuilder: (context, index) {
                  return ArticleCardWidget(
                    model: postsController.postsList[index],
                  );
                },
              ));
        }
      },
    );
  }
}