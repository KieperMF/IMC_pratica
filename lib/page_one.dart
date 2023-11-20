import 'package:flutter/material.dart';

class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  State<PageOne> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PageOne> {
  final TextEditingController _controller = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  var imc;
  var classif;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Calcule seu IMC'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(padding: EdgeInsets.all(20)),
          TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Informe seu Peso:'),
            autofocus: true,
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _controller2,
            decoration: const InputDecoration(hintText: 'Informe sua Altura:'),
            keyboardType: TextInputType.number,
            onChanged: (text) {
              if (text.length == 3 && !text.contains('.')) {
                _controller2.text =
                    '${text.substring(0, 1)}.${text.substring(1)}';
                _controller2.selection = TextSelection.fromPosition(
                  TextPosition(offset: text.length + 1),
                );
              }
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(padding: EdgeInsets.all(18)),
              ElevatedButton(
                onPressed: () {
                  calcule();
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue)),
                child: const Icon(Icons.calculate_sharp),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  reset();
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red)),
                child: const Icon(Icons.clear),
              ),
            ],
          ),
          if (imc != null)
            Text('IMC: $imc', style: const TextStyle(fontSize: 20)),
          if (imc == null) const Text('IMC:', style: TextStyle(fontSize: 20)),
          if (classif != null)
            Text('Classificação: $classif',
                style: const TextStyle(fontSize: 20)),
          if (classif == null)
            const Text('Classificação:', style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }

  void calcule() {
    double peso = double.parse(_controller.text);
    double altura = double.parse(_controller2.text);
    imc = peso / (altura * altura);

    if (imc < 16.9) {
      classif = 'Muito abixo do peso.';
    } else if (imc >= 17 && imc <= 18.4) {
      classif = 'Abaixo do Peso';
    } else if (imc >= 18.5 && imc <= 24.9) {
      classif = 'Peso normal';
    } else if (imc >= 25 && imc <= 29.9) {
      classif = 'Acima do peso';
    } else if (imc >= 30 && imc <= 34.9) {
      classif = 'Obesidade grau I';
    } else if (imc >= 35 && imc <= 40) {
      classif = 'Obesidade grau II';
    } else if (imc > 40) {
      classif = 'Obesidade grau III';
    }

    imc = imc.toStringAsFixed(2);
    setState(() {
      imc;
      classif;
    });
  }

  void reset() {
    _controller.clear();
    _controller2.clear();
    imc = null;
    classif = null;
    setState(() {
      imc;
      classif;
    });
  }
}
