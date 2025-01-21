import 'package:flutter/material.dart';
import 'package:ui_task_1/data/food.dart';
import 'package:ui_task_1/screens/widgets/custom_network_image.dart';
import 'package:ui_task_1/util/font_size.dart';
import 'package:ui_task_1/util/padding_size.dart';
import 'package:ui_task_1/util/style.dart';

class PopularFoods extends StatelessWidget {
const PopularFoods({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
    
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: PaddingSize.medium),
          child: Text(
            'Popular food', style: fontStyleLarge,
          ),
        ),
    
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: popularFoods.length,
            padding: EdgeInsets.only(left: PaddingSize.small),
            itemBuilder: (context, index) {
              return Container(
                width: 150,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(color: Theme.of(context).disabledColor.withValues(alpha: 0.1), blurRadius: 5)],
                ),
                margin: const EdgeInsets.all(PaddingSize.small),
                child: Column(children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                      child: CustomNetworkImage(image: popularFoods[index].imageUrl, height: 100, width: 150, fit: BoxFit.cover,),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(popularFoods[index].name, style: fontStyleMedium),
                  Text('\$${popularFoods[index].price}', style: fontStyleNormal.copyWith(fontSize: FontSize.small)),
                  const SizedBox(height: PaddingSize.small),
                  
                ]),
              );
            },
          ),
        ),
      ],
    );
  }
}