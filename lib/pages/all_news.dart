import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_dash/models/article_model.dart';
import 'package:news_dash/models/slider_model.dart';
import 'package:news_dash/pages/article_view.dart';
import 'package:news_dash/services/news.dart';
import 'package:news_dash/services/slider_data.dart';

class AllNews extends StatefulWidget {
  String news;
  AllNews({required this.news});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  List<sliderModel> sliders = [];
  List<ArticleModel> articles = [];
  void initState() {
    getSlider();
    getNews();
    super.initState();
  }

  getNews() async {
    News newsclass = News();
    await newsclass.getNews();
    articles = newsclass.news;
    setState(() {});
  }

  getSlider() async {
    Sliders slider = Sliders();
    await slider.getSlider();
    sliders = slider.sliders;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.news + " News",
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: widget.news == "Breaking"
              ? sliders.length
              : widget.news == "Trending"
                  ? sliders.length
                  : articles.length,
          itemBuilder: (context, index) {
            return AllNewsSection(
              Image: widget.news == "Breaking"
                  ? sliders[index].urlToImage!
                  : widget.news == "Trending"
                      ? sliders[index].urlToImage!
                      : articles[index].urlToImage!,
              desc: widget.news == "Breaking"
                  ? sliders[index].description!
                  : widget.news == "Trending"
                      ? sliders[index].description!
                      : articles[index].description!,
              title: widget.news == "Breaking"
                  ? sliders[index].title!
                  : widget.news == "Trending"
                      ? sliders[index].title!
                      : articles[index].title!,
              url: widget.news == "Breaking"
                  ? sliders[index].url!
                  : widget.news == "Trending"
                      ? sliders[index].url!
                      : articles[index].url!,
            );
          },
        ),
      ),
    );
  }
}

class AllNewsSection extends StatelessWidget {
  String Image, desc, title, url;
  AllNewsSection(
      {required this.Image,
      required this.desc,
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
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: Image,
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              title,
              maxLines: 2,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              desc,
              maxLines: 3,
            ),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
