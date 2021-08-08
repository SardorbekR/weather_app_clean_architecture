import 'package:equatable/equatable.dart';
import 'package:weather_app_clean_architecture/src/domain/entities/weather_data.dart';

class WeatherDataModel extends WeatherData {
  WeatherDataModel({
    required List<WeatherDescription> weather,
    required String name,
    required Temperature temperature,
  }) : super(weather: weather, cityName: name, temperature: temperature);

  factory WeatherDataModel.fromJson(Map<String, dynamic> json) =>
      WeatherDataModel(
        weather: List<WeatherDescription>.from(
            json["weather"].map((x) => WeatherDescription.fromJson(x))),
        name: json["name"],
        temperature: Temperature.fromJson(json["main"]),
      );
}

class Temperature extends Equatable {
  final double? temp;

  Temperature({
    this.temp,
  });

  factory Temperature.fromJson(Map<String, dynamic> json) => Temperature(
        temp: json["temp"].toDouble(),
      );

  @override
  List<Object?> get props => [this.temp];
}

class WeatherDescription extends Equatable {
  WeatherDescription({
    this.description,
  });

  final String? description;

  factory WeatherDescription.fromJson(Map<String, dynamic> json) =>
      WeatherDescription(
        description: json["description"],
      );

  @override
  List<Object?> get props => [this.description];
}
