import 'package:competition/core/utils/assets.dart';
import 'package:competition/core/utils/strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../states/state_home.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  // Slider-related state
  final List<String> sliderImagePaths = [
    AppAssets.offerImage1,
    AppAssets.offerImage2,
    AppAssets.offerImage3,
    AppAssets.offerImage4,
  ];

  int _currentSliderIndex = 0;

  int get currentSliderIndex => _currentSliderIndex;

  // Home-related state
  List<Map<String, dynamic>> categories = [];
  List<Map<String, dynamic>> recommended = [];
  List<Map<String, dynamic>> mostRequested = [];

  // Fetch categories and recommended items
  Future<void> fetchCategories() async {
    emit(HomeLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));

      // Dummy DATA
      categories = [
        {
          'image': AppAssets.restaurantsIcon,
          'text': AppStrings.restaurants.tr()
        },
        {
          'image': AppAssets.supermarketIcon,
          'text': AppStrings.supermarket.tr()
        },
        {'image': AppAssets.pharmacyIcon, 'text': AppStrings.pharmacy.tr()},
        {'image': AppAssets.stationeryIcon, 'text': AppStrings.stationery.tr()},
        {
          'image': AppAssets.medSuppliesIcon,
          'text': AppStrings.medSupplies.tr()
        },
        {'image': AppAssets.libraryIcon, 'text': AppStrings.library.tr()},
        {'image': AppAssets.sportIcon, 'text': AppStrings.sports.tr()},
        {'image': AppAssets.giftIcon, 'text': AppStrings.gift.tr()},
        {'image': AppAssets.clothIcon, 'text': AppStrings.cloth.tr()},
      ];

      final List<String> recommended = [
        AppAssets.recommendedImage1,
        AppAssets.recommendedImage3,
        AppAssets.recommendedImage2,
        AppAssets.recommendedImage4,
        AppAssets.recommendedImage5,
      ];

      final List<String> mostRequested = [
        AppAssets.mostRequestedImage1,
        AppAssets.mostRequestedImage2,
        AppAssets.mostRequestedImage3,
        AppAssets.mostRequestedImage4,
        AppAssets.mostRequestedImage5,
      ];

      emit(HomeSuccess(
          categories, recommended, mostRequested, sliderImagePaths));
    } catch (e) {
      emit(HomeFailure('Failed to load categories: ${e.toString()}'));
    }
  }

  // Slider functionality
  void updateSliderIndex(int index) {
    _currentSliderIndex = index;
    emit(HomeSliderUpdated(_currentSliderIndex));
  }

  void autoChangeSliderImages(Duration duration) {
    Future.delayed(duration, () {
      _currentSliderIndex = (_currentSliderIndex + 1) % sliderImagePaths.length;
      emit(HomeSliderUpdated(_currentSliderIndex));
      autoChangeSliderImages(duration);
    });
  }
}
