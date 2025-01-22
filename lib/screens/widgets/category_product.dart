import 'package:flutter/material.dart';
import 'package:ui_task_1/data/category_food.dart';
import 'package:ui_task_1/data/model/category_wise_food_model.dart';
import 'package:ui_task_1/screens/widgets/custom_network_image.dart';
import 'package:ui_task_1/util/font_size.dart';
import 'package:ui_task_1/util/padding_size.dart';
import 'package:ui_task_1/util/style.dart';
import 'package:visibility_detector/visibility_detector.dart';

class CategoryProduct extends StatefulWidget {
  final List<GlobalKey> keys;
  final TabController categoryTabController;
  const CategoryProduct({super.key, required this.keys, required this.categoryTabController});

  @override
  State<CategoryProduct> createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> with SingleTickerProviderStateMixin {

  List<CategoryWiseFoodModel> categories = CategoryFood().categories;

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: categories.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(PaddingSize.medium),
      itemBuilder: (context, index) {
        return VisibilityDetector(
          key: widget.keys[index],
          onVisibilityChanged: (VisibilityInfo info) {
              double screenHeight = MediaQuery.of(context).size.height;
              double visibleAreaOnScreen =
                  info.visibleBounds.bottom - info.visibleBounds.top;
    
              if (info.visibleFraction > 0.5 ||
                  visibleAreaOnScreen > screenHeight * 0.5) {
                widget.categoryTabController.animateTo(index);
              }
            },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(categories[index].name, style: fontStyleBold, ),
              const SizedBox(height: PaddingSize.medium),
                
              GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                mainAxisSpacing: PaddingSize.medium,
                crossAxisSpacing: PaddingSize.medium, // Spacing between columns
                childAspectRatio: 0.85, // Aspect ratio of each grid item
              ),
              itemCount: categories[index].foodItems.length, // Number of items
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (context, i) {
                return Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(color: Theme.of(context).disabledColor.withValues(alpha: 0.1), blurRadius: 5)],
                  ),
                  padding: const EdgeInsets.all(PaddingSize.extraSmall),
                  child: Column(
                    children: [
                
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                          child: CustomNetworkImage(image: categories[index].foodItems[i].image, width: double.infinity, fit: BoxFit.fill,),
                        ),
                      ),
                
                      Text(
                        categories[index].foodItems[i].name,
                        style: fontStyleMedium,
                      ),
                
                      Text(
                        '\$${categories[index].foodItems[i].price}',
                        style: fontStyleNormal.copyWith(fontSize: FontSize.small),
                      ),
                    ],
                  ),
                );
              },
            ),
                
            const SizedBox(height: PaddingSize.medium),
                
            ],
          ),
        );
      },
    );
  }
}