class Weather {
  const Weather(
      {required this.cityName,
      required this.temprature,
      required this.mainCondition});
  final String cityName;
  final double temprature;
  final String mainCondition;

factory Weather. fromJson (Map<String, dynamic> json) {
return Weather (
cityName: json[ 'name'],
temprature: json[ 'main'] ['temp']. toDouble(),
mainCondition: json ['weather'] [0]['main'],
) ;
}
}