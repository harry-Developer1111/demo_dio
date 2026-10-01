import 'package:demo_dio/core/network/api_endpoints.dart';
import 'package:demo_dio/core/network/api_service.dart';
import 'package:demo_dio/models/products_model.dart';

class HomeRepositary {
  final ApiService apiService;

  HomeRepositary(this.apiService);


  Future<ProductModel> createProduct({
    required String category,
    required String name,
    required int year,
    required double price,
  }) async {

    final response = await apiService.post(
      ApiEndpoints.products(category),
      data: {
        'name': name,
        'data': {
          'category': category,
          'year': year,
          'price': price,
        },
      },
    );

    return ProductModel.fromJson(response.data);
  }

  //home page data in list in 3 tabs
  Future<List<ProductModel>> getProducts({
    required String category,
  }) async {
    final response = await apiService.get(
      ApiEndpoints.products(category),
    );

    final data = response.data;

    return List<ProductModel>.from(
      data.map(
            (product) => ProductModel.fromJson(product),
      ),
    );
  }


}