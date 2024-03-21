import 'package:flutter/material.dart';
import 'package:flutter_course/src/features/menu/view/widgets/models.dart';

class CustomSliverAppBar extends StatelessWidget {
  final List<Category> categories;
  final int selectedCategoryIndex;
  final Function(int) onCategorySelected;

  const CustomSliverAppBar({
    Key? key,
    required this.categories,
    required this.selectedCategoryIndex,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Color(0xFFF7FAF8),
      floating: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Row(
              children: List.generate(categories.length, (index) {
                final categoryName = categories[index].name;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextButton(
                    onPressed: () {
                      onCategorySelected(index);
                    },
                    child: Text(
                      categoryName,
                      style: TextStyle(
                        color: selectedCategoryIndex == index
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        selectedCategoryIndex == index
                            ? Colors.blue
                            : Colors.white,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
