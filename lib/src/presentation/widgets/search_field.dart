import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_clean_architecture/src/data/bloc/weather_bloc.dart';

class SearchPanel extends StatefulWidget {
  const SearchPanel({Key? key}) : super(key: key);

  @override
  _SearchPanelState createState() => _SearchPanelState();
}

class _SearchPanelState extends State<SearchPanel> {
  late TextEditingController _textEditingController;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Form(
        key: _formKey,
        child: TextFormField(
          controller: _textEditingController,
          keyboardType: TextInputType.text,
          onFieldSubmitted: (_) => fetchWeather(),
          inputFormatters: [
            LengthLimitingTextInputFormatter(12),
            FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
          ],
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: fetchWeather,
            ),
            hintText: 'Enter City Name',
            border: OutlineInputBorder(
              borderSide: BorderSide(),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Fields should not be empty';
            }
          },
        ),
      ),
    );
  }

  void fetchWeather() {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<WeatherBloc>(context)
          .add(GetWeatherOfCity(_textEditingController.text));
      _textEditingController.clear();
    }
  }
}
