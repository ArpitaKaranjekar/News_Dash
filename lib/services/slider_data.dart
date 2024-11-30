import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_dash/models/slider_model.dart';

class Sliders {
  List<sliderModel> sliders = [];

  Future<void> getSlider() async {
    String url =
        "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=c8623c7c0be241918c29aa291b06b182";
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          sliderModel slidermodel = sliderModel(
            author: element["author"],
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
          );
          sliders.add(slidermodel);
        }
      });
    }
  }
}
