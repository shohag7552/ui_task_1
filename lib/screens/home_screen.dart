import 'package:flutter/material.dart';

import 'package:ui_task_1/data/category_food.dart';
import 'package:ui_task_1/data/model/category_wise_food_model.dart';
import 'package:ui_task_1/screens/widgets/category_product.dart';
import 'package:ui_task_1/screens/widgets/popular_foods.dart';
import 'package:ui_task_1/util/font_size.dart';
import 'package:ui_task_1/util/padding_size.dart';
import 'package:ui_task_1/util/radius_size.dart';
import 'package:ui_task_1/util/style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  List<CategoryWiseFoodModel> categories = CategoryFood().categories;
  ScrollController scrollController = ScrollController();
  bool pinAppBar = true;
  List<GlobalKey> _key = [];

  late TabController _categoryTabController;
  // final List<dynamic> _tabInfoList = [];

  void _initTabList() {
    for (int i = 0; i < categories.length; i++) {
      _key.add(GlobalKey());
      // _tabInfoList.add({
      //   'key': new GlobalKey(),
      //   'label': categories[i].name,
      // });
    }
  }
  

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if(scrollController.position.pixels > 580) {
        setState(() {
          pinAppBar = false;
        });
      } else {
        setState(() {
          pinAppBar = true;
        });
      }
    });
    
    _initTabList();
    _categoryTabController = TabController(length: categories.length, vsync: this);

  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: scrollController,
          slivers: [

            /// App Bar
            SliverAppBar(
              floating: true,
              elevation: 0,
              automaticallyImplyLeading: false,
              surfaceTintColor: Theme.of(context).colorScheme.surface,
              backgroundColor: Theme.of(context).colorScheme.surface,
              title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Find Your \nFavourite Food', style: fontStyleBold.copyWith(fontSize: FontSize.large)),
              
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).disabledColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(PaddingSize.extraSmall),
                  child: Icon(Icons.notifications_outlined, size: 24),
                ),
              ]),
              actions: const [SizedBox()],
            ),

            SliverPersistentHeader(
              pinned: pinAppBar,
              delegate: SliverDelegate(height: 60, child: Container(
                color: Theme.of(context).colorScheme.surface,
                padding: const EdgeInsets.only(top: PaddingSize.medium, left: PaddingSize.medium, right: PaddingSize.medium),
                child: Row(spacing: FontSize.medium, children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).disabledColor.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(RadiusSize.medium),
                        // boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.1), spreadRadius: 1, blurRadius: 10, offset: const Offset(0, 1))],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: PaddingSize.small, vertical: PaddingSize.small),
                      child: Row(children: [
                        Icon(Icons.search, size: 25),
                        const SizedBox(width: PaddingSize.small),
                                  
                        Text('Search for restaurants, dishes...', style: fontStyleNormal.copyWith(fontSize: FontSize.small)),
                      ]),
                    ),
                  ), 
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).disabledColor.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(PaddingSize.small),
                    child: Icon(Icons.tune_outlined, size: 28),
                  ),
                ]),
              )),
            ),

            SliverToBoxAdapter(
              child: Column(spacing: PaddingSize.medium, children: [
                
                const SizedBox(height: PaddingSize.extraSmall),
                
                PopularFoods(),

                const SizedBox(height: PaddingSize.extraSmall),
                
              ]),
            ),

            SliverPersistentHeader(
              pinned: true,
              delegate: SliverDelegate(
                height: 30, child: ColoredBox(
                  color: Theme.of(context).cardColor,
                  child: TabBar(
                  controller: _categoryTabController,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  indicator: BoxDecoration(
                    color: Theme.of(context).primaryColor.withValues(alpha: 0.5), // Background color of the selected tab
                    borderRadius: BorderRadius.circular(5), // Rounded corners
                  ),
                  labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
                  labelPadding: const EdgeInsets.fromLTRB(20, 5, 20, 2),
                  padding: EdgeInsets.zero,
                  indicatorPadding: EdgeInsets.zero,
                  indicatorSize: TabBarIndicatorSize.tab,
                  onTap: (index) {
                    GlobalKey globalKey = _key[index];
                    Scrollable.ensureVisible(
                      globalKey.currentContext!,
                      duration: const Duration(milliseconds: 250),
                    );
                  },
                  tabs: List.generate(categories.length, (index) {
                    return SizedBox(
                      height: 30,
                      child: Text(
                        categories[index].name,
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }),
                ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: CategoryProduct(keys: _key, categoryTabController: _categoryTabController),
            ),
        
          ],
        ),
      ),
    );
  }

}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  double height;

  SliverDelegate({required this.child, this.height = 50});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != height || oldDelegate.minExtent != height || child != oldDelegate.child;
  }
}