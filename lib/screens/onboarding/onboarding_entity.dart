class OnBoardingEntity {
  final String? image;
  final String? title;
  final String? description;

  OnBoardingEntity({this.image, this.title, this.description});

  static List<OnBoardingEntity> onBoardingData = [
    OnBoardingEntity(
        image: "onboarding_3.png",
        title: "Live track\nyour shipments",
        description:
            "See a realtime view of your courier\non the map on the day of delivery."),
  ];
}
