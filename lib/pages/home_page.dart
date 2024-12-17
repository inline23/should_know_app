import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:should_know_app/controllers/categories_controller.dart';
import 'package:should_know_app/pages/atticles_page.dart';
import 'package:should_know_app/pages/settings_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<Widget> tabs = [];

  final CategoriesController categoriesController =
      Get.put(CategoriesController());

  @override
  void initState() {
    super.initState();
    // tabs.add(tab("kitchen"));
    // tabs.add(tab("Business"));
    // tabs.add(tab("Entertainment"));
    // tabs.add(tab("sports"));
    // tabs.add(tab("helth"));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Obx(() {
        if (categoriesController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return DefaultTabController(
            length: categoriesController.categoriesList.length,
            child: Scaffold(
              drawer: Drawer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        DrawerHeader(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF1D5079), Color(0xFF0A2141)]),
                          ),
                          child: Center(
                            child: ListTile(
                              leading: Image.asset(
                                'assets/LOGO-WEB-30-47.png',
                                width: 20,
                              ),
                              title: Text(
                                AppLocalizations.of(context)!.appTitle,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Cairo',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.homeLabel,
                            style: TextStyle(fontFamily: 'Cairo'),
                          ),
                          leading: Icon(Icons.home_filled),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.settingsLabel,
                            style: TextStyle(fontFamily: 'Cairo'),
                          ),
                          leading: Icon(Icons.settings),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SettingsPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${AppLocalizations.of(context)!.toContact} : ",
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                ),
                              ),
                              Text(
                                'info@p.team',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text(
                            "https://should-know.com",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              appBar: AppBar(
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF1D5079), Color(0xFF0A2141)]),
                  ),
                ),
                elevation: 0,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 24.0, left: 24.0),
                    child: Image.asset(
                      'assets/LOGO-WEB-30-47.png',
                      // color: Colors.white,
                      width: 23,
                    ),
                  ),
                ],
                // title: const Text("يجب أن تعلم"),
                bottom: TabBar(
                  tabs: categoriesController.categoriesList
                      .map((model) => tab(model.categoryName!))
                      .toList(),
                  isScrollable: true,
                  dividerColor: Color(0xFF21C8DF),
                  labelColor: Colors.white,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                  unselectedLabelColor:
                      const Color.fromARGB(255, 226, 226, 226),
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: const Color(0xFF21C8DF),
                ),
              ),
              body: SafeArea(
                child: TabBarView(
                  children: categoriesController.categoriesList
                      .map((model) => AtticlesPage(
                            categoryId: model.categoryId,
                            isReload: true,
                          ))
                      .toList(),
                ),
              ),
            ),
          );
        }
      }),
    );
  }

  Widget tab(String tabName) {
    return Tab(
      text: tabName,
    );
  }
}
