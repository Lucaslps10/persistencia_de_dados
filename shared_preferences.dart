import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercício Shared Preferences',
      home: PreferencesPage(),
    );
  }
}

class PreferencesPage extends StatefulWidget {
  @override
  _PreferencesPageState createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  final TextEditingController _stringController = TextEditingController();
  final TextEditingController _intController = TextEditingController();
  final TextEditingController _doubleController = TextEditingController();
  bool _boolValue = false;

  String _savedString = '';
  int _savedInt = 0;
  double _savedDouble = 0.0;
  bool _savedBool = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    // TODO: Implementar a leitura dos valores salvos usando Shared Preferences
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _savedString = prefs.getString('stringKey') ?? '';
      _savedInt = prefs.getInt('intKey') ?? 0;
      _savedDouble = prefs.getDouble('doubleKey') ?? 0.0;
      _savedBool = prefs.getBool('boolKey') ?? false;
      _boolValue = _savedBool;
    });
  }  

  Future<void> _saveString() async {
    // TODO: Implementar o salvamento da String usando Shared Preferences~
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('stringKey', _stringController.text);
    setState(() {
      _savedString = _stringController.text;
    });
  }

  Future<void> _saveInt() async {
    // TODO: Implementar o salvamento do int usando Shared Preferences
    final prefs = await SharedPreferences.getInstance();
    final intValue = int.tryParse(_intController.text) ?? 0;
    await prefs.setInt('intKey', intValue);
    setState(() {
      _savedInt = intValue;
    });

  }

  Future<void> _saveDouble() async {
    // TODO: Implementar o salvamento do double usando Shared Preferences
    final prefs = await SharedPreferences.getInstance();
    final doubleValue = double.tryParse(_doubleController.text) ?? 0.0;
    await prefs.setDouble('doubleKey', doubleValue);
    setState(() {
      _savedDouble = doubleValue;
    });
  }

  Future<void> _saveBool() async {
    // TODO: Implementar o salvamento do bool usando Shared Preferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('boolKey', _boolValue);
    setState(() {
      _savedBool = _boolValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exercício Shared Preferences')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // String
              TextField(
                controller: _stringController,
                decoration: InputDecoration(labelText: 'Digite uma String'),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: _saveString,
                child: Text('Salvar String'),
              ),
              Text('String salva: $_savedString', style: TextStyle(fontSize: 16)),

              Divider(),

              // int
              TextField(
                controller: _intController,
                decoration: InputDecoration(labelText: 'Digite um inteiro'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: _saveInt,
                child: Text('Salvar Int'),
              ),
              Text('Int salvo: $_savedInt', style: TextStyle(fontSize: 16)),

              Divider(),

              // double
              TextField(
                controller: _doubleController,
                decoration: InputDecoration(labelText: 'Digite um double'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: _saveDouble,
                child: Text('Salvar Double'),
              ),
              Text('Double salvo: $_savedDouble', style: TextStyle(fontSize: 16)),

              Divider(),

              // bool
              Row(
                children: [
                  Text('Valor booleano:', style: TextStyle(fontSize: 16)),
                  Switch(
                    value: _boolValue,
                    onChanged: (value) {
                      setState(() {
                        _boolValue = value;
                      });
                    },
                  ),
                  ElevatedButton(
                    onPressed: _saveBool,
                    child: Text('Salvar Bool'),
                  ),
                ],
              ),
              Text('Bool salvo: $_savedBool', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
