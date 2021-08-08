import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_clean_architecture/src/core/config/theme/textstyle.dart';
import 'package:weather_app_clean_architecture/src/core/network_state/network_state.dart';
import 'package:weather_app_clean_architecture/src/data/bloc/weather_bloc.dart';
import 'package:weather_app_clean_architecture/src/data/data_sources/local_datasources.dart';
import 'package:weather_app_clean_architecture/src/data/data_sources/remote_datasources.dart';
import 'package:weather_app_clean_architecture/src/data/repositories/weather_repository.dart';
import 'package:weather_app_clean_architecture/src/presentation/widgets/search_field.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WeatherBloc, WeatherState>(
        bloc: BlocProvider.of<WeatherBloc>(context),
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (state is WeatherLoading)
                CircularProgressIndicator()
              else if (state is WeatherLoaded) ...[
                Text(state.weatherData.cityName, style: CustomStyle32px),
                Text(
                  "${state.weatherData.temperature.temp?.ceilToDouble()}",
                  style: CustomStyle32px,
                ),
                Text(
                  "${state.weatherData.weather[0].description}",
                  style: CustomStyle32px,
                ),
              ] else if (state is WeatherFetchFailed)
                Text("Failed to fetch Weather", style: CustomStyle32px),

              const SearchPanel(),
              //
            ],
          );
        },
      ),
    );
  }
}
