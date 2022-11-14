import 'package:diabeta_app/components/constants.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {
  final String title;
  final String imgPath;
  const CategoryCard({Key? key, required this.title, required this.imgPath}) : super(key: key);

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height/5,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.imgPath),
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter,
                    ),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Center(),
                ),
                Container(
                  width: double.infinity,
                  height: 30,
                  decoration: const BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Center(
                    child: Text(
                      widget.title,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
