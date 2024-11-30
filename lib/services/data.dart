import 'package:news_dash/models/category_model.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> category = [];
  CategoryModel categoryModel = CategoryModel();

  categoryModel.categoryName = "Business";
  categoryModel.image = "images/business.png";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Entertainment";
  categoryModel.image = "images/entertainment.png";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = "General";
  categoryModel.image = "images/general.png";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Health";
  categoryModel.image = "images/health.png";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Science";
  categoryModel.image = "images/science.png";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Sports";
  categoryModel.image = "images/sports.png";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  return category;
}
