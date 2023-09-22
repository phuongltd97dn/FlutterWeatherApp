import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/cubits/temp_settings/temp_settings_cubit.dart';

import '../cubits/weather/weather_cubit.dart';
import '../widgets/error_dialog.dart';
import 'search_page.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _name;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        actions: [
          IconButton(
            onPressed: () async {
              _name = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );

              if (_name != null && context.mounted) {
                context.read<WeatherCubit>().fetchWeather(_name!);
              }
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: _showWeather(),
    );
  }

  Widget _showWeather() {
    return BlocConsumer<WeatherCubit, WeatherState>(
      listener: (context, state) {
        if (state.status == WeatherStatus.error) {
          errorDialog(context, state.error.errMsg);
        }
      },
      builder: (context, state) {
        if (state.status == WeatherStatus.initial) {
          return const Center(
            child: Text('Select a city', style: TextStyle(fontSize: 20.0)),
          );
        }

        if (state.status == WeatherStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == WeatherStatus.error &&
            state.weather.temperature == 100.0) {
          return const Center(
            child: Text('Select a city', style: TextStyle(fontSize: 20.0)),
          );
        }

        return ListView(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 6),
            Text(
              state.geocoding.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              '${state.geocoding.country} (${state.geocoding.countryCode})',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              showDateTime(state.weather.time),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 10.0),
            Text(
              showDateTime(state.weather.lastUpdate),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 40.0),
            Text(
              showTemperature(state.weather.temperature),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Windspeed: ${state.weather.windspeed}',
                  style: const TextStyle(fontSize: 22.0),
                ),
                Text(
                  'Wind direction: ${state.weather.windDirection}',
                  style: const TextStyle(fontSize: 22.0),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  Widget _showIcon(String abbr) {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/images/loading.gif',
      image: '',
      width: 64,
      height: 64,
    );
  }

  String showTemperature(double temperature) {
    final tempUnit = context.watch<TempSettingsCubit>().state.tempUnit;

    if (tempUnit == TempUnit.fahrenheit) {
      return '${((temperature * 9 / 5) + 32).toStringAsFixed(1)}°F';
    }

    return '${temperature.toStringAsFixed(1)}°C';
  }

  String showDateTime(DateTime dt) {
    return DateFormat('dd/MM/yyyy HH:mm a').format(dt);
  }
}
