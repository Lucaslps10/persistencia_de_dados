import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // Abre a box para cada tipo de dado
  await Hive.openBox('prefs');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercício Hive',
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

  Box get _box => Hive.box('prefs');

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    // TODO: Implementar a leitura dos valores salvos usando Hive
    setState(() {
      _savedString = _box.get('stringKey', defaultValue: '') as String;
      _savedInt = _box.get('intKey', defaultValue: 0) as int;
      _savedDouble = _box.get('doubleKey', defaultValue: 0.0) as double;
      _savedBool = _box.get('boolKey', defaultValue: false) as bool;
      _boolValue = _savedBool;
    });
  }

  Future<void> _saveString() async {
    // TODO: Implementar o salvamento da String usando Hive
    await _box.put('stringKey', _stringController.text);
    setState(() {
      _savedString = _stringController.text;
    });
  }

  Future<void> _saveInt() async {
    // TODO: Implementar o salvamento do int usando Hive
    final intValue = int.tryParse(_intController.text) ?? 0;
    await _box.put('intKey', intValue);
    setState(() {
      _savedInt = intValue;
    });
  }

  Future<void> _saveDouble() async {
    // TODO: Implementar o salvamento do double usando Hive
    final doubleValue = double.tryParse(_doubleController.text) ?? 0.0;
    await _box.put('doubleKey', doubleValue);
    setState(() {
      _savedDouble = doubleValue;
    });
  }

  Future<void> _saveBool() async {
    // TODO: Implementar o salvamento do bool usando Hive
    await _box.put('boolKey', _boolValue);
    setState(() {
      _savedBool = _boolValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exercício Hive')),
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
