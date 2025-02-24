abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<Map<String, dynamic>> categories;
  final List<String> recommended;
  final List<String> mostRequested;
  final List<String> sliderImagePaths;

  HomeSuccess(this.categories, this.recommended, this.mostRequested,
      this.sliderImagePaths);
}

class HomeFailure extends HomeState {
  final String error;

  HomeFailure(this.error);
}

class HomeSliderUpdated extends HomeState {
  final int currentSliderIndex;

  HomeSliderUpdated(this.currentSliderIndex);
}
