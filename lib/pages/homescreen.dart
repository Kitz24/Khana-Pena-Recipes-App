
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:khana_peena_recipes/Components/searchBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:like_button/like_button.dart';
import 'package:khana_peena_recipes/pages/favouritesScreen.dart';
import '../Components/searchBar.dart';

class HomeScreen extends StatefulWidget {
  final List<String> category;

  HomeScreen({required this.category});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Variable to store the favourited image index
  int _favouriteIndex = -1; // Initialize to -1 (not favourited)
  @override
  Widget build(BuildContext context) {
    final category = widget.category; // Access category list here

    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            CustomSearchBar(),
            Divider(height: 30),
            Row(children: <Widget>[
              Expanded(child: Divider()),
              Text(
                "FOOD FOR YOU",
                style: TextStyle(color: Colors.grey.shade500),
              ),
              Expanded(child: Divider()),
            ]),
            Container(
              height: 180.h,
              child: GridView.count(
                scrollDirection: Axis.horizontal,
                crossAxisCount: 2,
                children: List.generate(category.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      print("Image ${category[index]} clicked!");
                    },
                    child: Column(
                      children: [
                        SizedBox(height: 6.h),
                        Container(
                          height: 50.h,
                          child: Image.asset(
                            "assets/homepage/frame${index + 1}.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                        Text(
                          "${category[index]}",
                          style: const TextStyle(fontSize: 16, letterSpacing: 1),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            Row(children: <Widget>[
              Expanded(child: Divider()),
              Text(
                "NEW ARRIVALS",
                style: TextStyle(color: Colors.grey.shade500),
              ),
              Expanded(child: Divider()),
            ]),
            ListView.builder(
              itemCount: 2,
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: GestureDetector(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Restaurant Details"),
                        content: Text(
                          "You tapped on restaurant card at index $index.",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Close"),
                          ),
                        ],
                      ),
                    ),
                    child: Card(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                    height: 200.h,
                                    width: double.infinity,
                                    child: Opacity(
                                      opacity: 1,
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10.r),
                                            topLeft: Radius.circular(10.r),
                                          ),
                                          child: Image.asset(
                                            "assets/homepage/frame${index + 1}.png",
                                            fit: BoxFit.fill,
                                          )),
                                    )),
                                Padding(
                                  padding: EdgeInsets.only(top: 100.h),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Icon(
                                            Icons.alarm,
                                            color: Colors.green,
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text("35-40 min"),
                                          Spacer(),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),

                            Positioned(
                              top: 10.h,
                              right: 10.w,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    // Toggle favourite state based on current index
                                    _favouriteIndex = _favouriteIndex == index ? -1 : index;
                                  });
                                  // Implement your favourite animation here
                                  print("Favourite icon tapped for image at index: $_favouriteIndex");
                                },
                                child: LikeButton(

                                ),
                                // child: Icon(
                                //   _favouriteIndex == index ? Icons.favorite : Icons.favorite_outline,
                                //   size: 20.sp,
                                //   color: Colors.red, // Adjust colour for favourited state
                                // ),
                              ),
                            ),
                            Positioned(
                                bottom: 90.h,
                                left: 10.w,
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Placeholder Recipe",
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "PlaceHolder ● Placeholder ● Placeholder",
                                            style:
                                            TextStyle(color: Colors.black),
                                          ),
                                          SizedBox(
                                            width: 100.w,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(10.r),
                                                color: Colors.green),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.w),
                                              child: Text(
                                                "4.0★",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )),
                            Positioned(
                                left: 10.w,
                                bottom: 40.h,
                                child: Container(
                                  height: 40.h,
                                  width: 310.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.indigo,
                                        Colors.indigoAccent
                                      ],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.percent,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "NEW ARRIVAL",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 150.w,
                                      ),
                                      Card(

                                        color: Colors.indigo,

                                        child: Text(
                                          "+1",
                                          style:
                                          TextStyle(color: Colors.white),
                                        ),

                                      ),
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}