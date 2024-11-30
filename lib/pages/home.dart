import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_dash/models/article_model.dart';
import 'package:news_dash/models/category_model.dart';
import 'package:news_dash/models/slider_model.dart';
import 'package:news_dash/pages/all_news.dart';
import 'package:news_dash/pages/article_view.dart';
import 'package:news_dash/pages/category_news.dart';
import 'package:news_dash/services/data.dart';
import 'package:news_dash/services/news.dart';
import 'package:news_dash/services/slider_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = [];
  List<sliderModel> sliders = [];
  List<ArticleModel> articles = [];
  bool _loading = true;

  int activeIndex = 0;
  @override
  void initState() {
    categories = getCategories();
    getSlider();
    getNews();
    super.initState();
  }

  getNews() async {
    News newsclass = News();
    await newsclass.getNews();
    articles = newsclass.news;
    setState(() {
      _loading = false;
    });
  }

  getSlider() async {
    Sliders slider = Sliders();
    await slider.getSlider();
    sliders = slider.sliders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "NEWS DASH",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 15.0),
                      height: 70,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return CategoryTile(
                              image: categories[index].image,
                              categoryName: categories[index].categoryName,
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Breaking News!",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AllNews(news: "Breaking")));
                            },
                            child: const Text(
                              "View All",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    if (sliders.isNotEmpty)
                      CarouselSlider.builder(
                          itemCount: 5,
                          itemBuilder: (context, index, realIndex) {
                            String? res = sliders[index].urlToImage;
                            String? res1 = sliders[index].title;
                            return buildImage(res!, index, res1!);
                          },
                          options: CarouselOptions(
                              height: 250,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              enlargeStrategy: CenterPageEnlargeStrategy.height,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  activeIndex = index;
                                });
                              }))
                    else
                      const Center(child: Text("No sliders available.")),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Center(child: buildIndicator()),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Trending News!",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AllNews(news: "Trending")));
                            },
                            child: const Text(
                              "View All",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // const SizedBox(
                    //   height: 10.0,
                    // ),
                    // GestureDetector(
                    //   onTap: () {},
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    //     child: Material(
                    //       elevation: 3.0,
                    //       borderRadius: BorderRadius.circular(10),
                    //       child: Padding(
                    //         padding: const EdgeInsets.symmetric(
                    //             vertical: 10.0, horizontal: 5.0),
                    //         child: Row(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Container(
                    //               child: ClipRRect(
                    //                 borderRadius: BorderRadius.circular(10),
                    //                 child: Image.asset(
                    //                   "images/sports.png",
                    //                   height: 120,
                    //                   width: 120,
                    //                   fit: BoxFit.contain,
                    //                 ),
                    //               ),
                    //             ),
                    //             const SizedBox(
                    //               width: 8.0,
                    //             ),
                    //             Column(
                    //               children: [
                    //                 Container(
                    //                   width: MediaQuery.of(context).size.width /
                    //                       1.7,
                    //                   child: const Text(
                    //                     "Rui Costa breakaway",
                    //                     style: TextStyle(
                    //                         color: Colors.black,
                    //                         fontWeight: FontWeight.w500,
                    //                         fontSize: 17.0),
                    //                   ),
                    //                 ),
                    //                 const SizedBox(
                    //                   height: 7.0,
                    //                 ),
                    //                 Container(
                    //                   width: MediaQuery.of(context).size.width /
                    //                       1.8,
                    //                   child: const Text(
                    //                     "then it was allover tthe internet",
                    //                     style: TextStyle(
                    //                         color: Colors.black54,
                    //                         fontWeight: FontWeight.w500,
                    //                         fontSize: 16.0),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    const SizedBox(
                      height: 10.0,
                    ),
                    if (sliders.isNotEmpty)
                      Container(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: sliders.length,
                          itemBuilder: (context, index) {
                            return BlogTile(
                                url: sliders[index].url!,
                                desc: sliders[index].description!,
                                imageUrl: sliders[index].urlToImage!,
                                title: sliders[index].title!);
                          },
                        ),
                      )
                    else
                      const Center(child: Text("No news articles available.")),
                  ],
                ),
              ),
            ),
    );
  }

  Widget buildImage(String image, int index, String name) => Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Stack(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            height: 250,
            fit: BoxFit.contain,
            width: MediaQuery.of(context).size.width,
            imageUrl: image,
          ),
        ),
        Container(
          height: 250,
          padding: const EdgeInsets.only(left: 10.0),
          margin: const EdgeInsets.only(top: 170),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          child: Text(
            name,
            maxLines: 2,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
        )
      ]));
  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: 5,
        effect: const SlideEffect(
            dotWidth: 15, dotHeight: 15, activeDotColor: Colors.black),
      );
}

class CategoryTile extends StatelessWidget {
  final image, categoryName;
  const CategoryTile({super.key, this.categoryName, this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(name: categoryName)));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                image,
                width: 120,
                height: 60,
                fit: BoxFit.contain,
              ),
            ),
            Container(
              width: 120,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black38,
              ),
              child: Center(
                child: Text(
                  categoryName,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  String imageUrl, title, desc, url;
  BlogTile(
      {required this.desc,
      required this.imageUrl,
      required this.title,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ArticleView(blogUrl: url)));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Material(
            elevation: 3.0,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        height: 120,
                        width: 120,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.7,
                        child: Text(
                          title,
                          maxLines: 2,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.0),
                        ),
                      ),
                      const SizedBox(
                        height: 7.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: Text(
                          desc,
                          maxLines: 3,
                          style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
