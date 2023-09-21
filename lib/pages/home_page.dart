import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/cubit/weather_cubit.dart';
import 'search_page.dart';

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
        ],
      ),
      body: const Center(child: Text('Home')),
    );
  }
}
