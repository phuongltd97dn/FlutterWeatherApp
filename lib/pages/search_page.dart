import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    void submit() {
      setState(() => autovalidateMode = AutovalidateMode.always);

      final form = _formKey.currentState;

      if (form != null && form.validate()) {
        form.save();
        Navigator.pop(context, _name?.trim());
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Form(
        key: _formKey,
        autovalidateMode: autovalidateMode,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 60.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                autofocus: true,
                style: const TextStyle(fontSize: 18.0),
                decoration: const InputDecoration(
                  labelText: 'City name',
                  hintText: 'more than 2 characters',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                validator: (String? input) {
                  if (input == null || input.trim().length < 2) {
                    return 'City name must be at least 2 characters long';
                  }

                  return null;
                },
                onSaved: (String? input) => _name = input,
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: submit,
              child: const Text(
                'How\'s the weather',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
