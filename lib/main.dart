import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

void main() {
  runApp(MaterialApp(
    home: App(),
  ));
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  GoogleTranslator translator = GoogleTranslator();
  String translatedText = ''; // Inicializa con una cadena vacía
  final lang = TextEditingController();
  String selectedLanguage = 'es'; // Idioma predeterminado (hindi)

  Map<String, String> languageOptions = {
    'es': 'Español',
    'fr': 'Francés',
    'en': 'Inglés',
    'hi': 'Hindi',
    // Agrega más idiomas aquí según la imagen
  };

  void translateText() {
    final inputText = lang.text;

    if (inputText.isNotEmpty) {
      translator.translate(inputText, to: selectedLanguage).then((output) {
        setState(() {
          translatedText = output.toString(); // Convierte a cadena
        });
        print(translatedText);
      });
    } else {
      setState(() {
        translatedText = 'Ingrese un texto para traducir'; // Mensaje de error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TRADUCTOR", style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: lang,
              decoration: InputDecoration(
                hintText: 'Ingresa un texto para traducir',
              ),
            ),
            DropdownButton<String>(
              value: selectedLanguage,
              onChanged: (newValue) {
                setState(() {
                  selectedLanguage = newValue!;
                });
              },
              items: languageOptions.keys.map<DropdownMenuItem<String>>((key) {
                return DropdownMenuItem<String>(
                  value: key,
                  child: Text(languageOptions[key]!),
                );
              }).toList(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 3, 3, 3),
              ),
              onPressed: translateText,
              child: Text("Traducir",style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
            ),
            SizedBox(height: 16.0),
            Text(translatedText), // Muestra el texto traducido
          ],
        ),
      ),
    );
  }
}