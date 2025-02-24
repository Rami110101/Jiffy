import '../../../core/utils/assets.dart';
import '../models/product_model.dart';

class DummyData {
  static List<Product> products = [
    Product(
        category: 'Clothing',
        name: 'Black hoodie Premium',
        brand: 'ASICS',
        price: 84.61,
        weight: 35,
        imageUrl: AppAssets.hoodie),
    Product(
        category: 'Clothing',
        name: 'New Balance Man White Trainers',
        brand: 'New Balance',
        price: 74.21,
        weight: 55,
        imageUrl: AppAssets.trainers),
    Product(
        category: 'Pharmacy',
        name: 'Black hoodie Premium',
        brand: 'Johnson & Johnson',
        price: 30.57,
        weight: 65,
        imageUrl: AppAssets.headphones),
  ];
}
