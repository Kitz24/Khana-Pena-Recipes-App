import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:like_button/like_button.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});
  Future<bool> onLikeButtonTapped(bool isLiked) async{
    /// send your request here
    // final bool success= await sendRequest();
    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;

    return !isLiked;
  }


  @override
  Widget build(BuildContext context) {

    var searchOutlineInputBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide.none,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextFormField(
              onChanged: (value) {},
              decoration: InputDecoration(
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                border: searchOutlineInputBorder,
                focusedBorder: searchOutlineInputBorder,
                enabledBorder: searchOutlineInputBorder,
                hintText: "Search product",
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          const SizedBox(width: 30),
          IconButton(onPressed: () {}, icon: Icon(Icons.list_rounded,size: 32.w,))
        ],
      ),
    );
  }
}
