import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        home: Home(),
        debugShowCheckedModeBanner: false,
      ),
    );

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _precoAlcool = TextEditingController();
  TextEditingController _precoGasolina = TextEditingController();
  String _resultado;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    resetFields();
  }

  void resetFields() {
    _precoAlcool.text = '';
    _precoGasolina.text = '';
    setState(() {
      _resultado = 'O que vale mais a pena, Alcool ou Gasolina?\n';
    });
  }

  void calcular() {
    double alcool = double.parse(_precoAlcool.text);
    double gasolina = double.parse(_precoGasolina.text);
    double valeApena = gasolina * 0.7;
    setState(() {
      _resultado = "";
      //_resultado = "${valeApena.toStringAsFixed(2)}\n";
      if (valeApena >= alcool)
        _resultado += "Vale a pena abastecer com Gasolina";
      else
        _resultado += "vale a pena abastecer com Alcool";
    });
  }

  Widget buildCalculateButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      child: RaisedButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            calcular();
          }
        },
        child: Text("Calcular", style: TextStyle(color: Colors.white)),
        color: Colors.green[900],
      ),
    );
  }

  Widget buildTextResult() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      child: Text(
        _resultado,
        textAlign: TextAlign.center,
      ),
    );
  }

  Form buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildTextFormField(
              label: "Preço Gasolina:",
              error: "Informe preço da Gasolina",
              controller: _precoGasolina),
          buildTextFormField(
              label: "Preço Alcool",
              error: "Informe preço da Alcool",
              controller: _precoAlcool),
          buildTextResult(),
          buildCalculateButton(),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20.0), child: buildForm()));
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text("GasolinaVSAlcool"),
      backgroundColor: Colors.blue,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            resetFields(); //resetFields;
          },
        )
      ],
    );
  }

  TextFormField buildTextFormField(
      {TextEditingController controller, String error, String label}) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
      controller: controller,
      validator: (text) {
        return text.isEmpty ? error : null;
      },
    );
  }
}
