import 'dart:convert';
import 'dart:io';

import 'package:mini_catalog_app/models/product_model.dart';

class ProductService {
  static const Duration _requestTimeout = Duration(seconds: 10);
  static final Uri _productsUri = Uri.parse(
    'https://fakestoreapi.com/products',
  );

  static Future<List<ProductModel>> fetchProducts() async {
    final client = HttpClient();

    try {
      final request = await client.getUrl(_productsUri).timeout(
        _requestTimeout,
      );
      final response = await request.close().timeout(_requestTimeout);

      if (response.statusCode != HttpStatus.ok) {
        throw HttpException(
          'Products could not be loaded (${response.statusCode}).',
          uri: _productsUri,
        );
      }

      final responseBody = await response
          .transform(utf8.decoder)
          .join()
          .timeout(_requestTimeout);
      final jsonList = jsonDecode(responseBody) as List<dynamic>;

      return jsonList
          .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } finally {
      client.close();
    }
  }
}
