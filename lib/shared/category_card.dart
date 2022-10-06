import 'package:flutter/material.dart';
import '../utils/category.dart';

class CategoryCard extends StatefulWidget {
  CategoryMock categoryDetails;

  CategoryCard({
    Key? key,
    required this.categoryDetails,
  }) : super(key: key);

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            widget.categoryDetails.image,
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          widget.categoryDetails.category,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
