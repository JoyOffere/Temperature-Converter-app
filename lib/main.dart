import 'package:flutter/material.dart';

void main() => runApp(const OffereTempConverterApp());

class OffereTempConverterApp extends StatelessWidget {
  const OffereTempConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(), // Switch to light theme for variation
      home: const CustomThemeConverterScreen(),
    );
  }
}

class CustomThemeConverterScreen extends StatefulWidget {
  const CustomThemeConverterScreen({super.key});

  @override
  _CustomThemeConverterScreenState createState() =>
      _CustomThemeConverterScreenState();
}

class _CustomThemeConverterScreenState extends State<CustomThemeConverterScreen> {
  String _currentConversion = 'Fahrenheit to Celsius';
  final TextEditingController _inputController = TextEditingController();
  String _outputValue = '';
  final List<String> _history = [];

  void _performConversion() {
    double inputTemperature = double.tryParse(_inputController.text) ?? 0.0;
    double resultTemperature;
    String historyItem;

    if (_currentConversion == 'Fahrenheit to Celsius') {
      resultTemperature = (inputTemperature - 32) * 5 / 9;
      historyItem = 'F to C: $inputTemperature => ${resultTemperature.toStringAsFixed(2)}';
    } else {
      resultTemperature = (inputTemperature * 9 / 5) + 32;
      historyItem = 'C to F: $inputTemperature => ${resultTemperature.toStringAsFixed(2)}';
    }

    setState(() {
      _outputValue = resultTemperature.toStringAsFixed(2);
      _history.insert(0, historyItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offere Temp Converter'),
        centerTitle: true,
        backgroundColor: Colors.indigo, // Changed to indigo
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo[300]!, Colors.purple[800]!], // New gradient colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(Icons.thermostat_outlined, color: Colors.orange, size: 30), // Changed icon color
                Radio<String>(
                  value: 'Fahrenheit to Celsius',
                  groupValue: _currentConversion,
                  onChanged: (value) {
                    setState(() {
                      _currentConversion = value!;
                    });
                  },
                ),
                const Text('F to C', style: TextStyle(fontSize: 18)),
                const SizedBox(width: 10),
                const Icon(Icons.thermostat, color: Colors.green, size: 30), // Changed icon color
                Radio<String>(
                  value: 'Celsius to Fahrenheit',
                  groupValue: _currentConversion,
                  onChanged: (value) {
                    setState(() {
                      _currentConversion = value!;
                    });
                  },
                ),
                const Text('C to F', style: TextStyle(fontSize: 18)),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _inputController,
              decoration: InputDecoration(
                labelText: 'Enter Temperature',
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Colors.purple[200], // Changed text field color
              ),
              style: const TextStyle(color: Colors.black),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _performConversion,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent, // Changed button color
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text('CONVERT', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 20),
            Text(
              'Converted Value: $_outputValue',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.yellow, // Changed text color
              ),
            ),
            const Divider(color: Colors.white),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading:
                        const Icon(Icons.history, color: Colors.cyan), // Changed icon color
                    title: Text(
                      _history[index],
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
