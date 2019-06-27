import 'package:combustivel_ideal/helper/posto_helper.dart';
import 'package:combustivel_ideal/page/postoList.dart';
import 'package:flutter/material.dart';
import 'package:combustivel_ideal/model/posto.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';


class PostoPage extends StatefulWidget {

  final Posto posto;

  PostoPage({this.posto});

  @override
  _PostoPageState createState() => _PostoPageState();
}

class _PostoPageState extends State<PostoPage> {

  PostoHelper helper = PostoHelper();

  final _nameController = TextEditingController();
  TextEditingController _precoAlcoolController = TextEditingController();
  TextEditingController _precoGasolinaController = TextEditingController();

  final _nameFocus = FocusNode();

  bool _postoEdited = false;

  Posto _postoTemp;

  String combustivel = " ";

  void _resetFields() {
    _nameController.text = " ";
    _precoAlcoolController.text = " ";
    _precoGasolinaController.text = " ";
  }


  void _irPara(){
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PostoListPage()),
    );
  }


  void calcularCombustivel() {
    double alcool = double.parse(_precoAlcoolController.text);
    double gasolina = double.parse(_precoGasolinaController.text);

    double resultado = alcool / gasolina;

    if (resultado < 0.70) {
      combustivel = "o álcool";
    } else {
      combustivel = "a gasolina";
    }
    mensagemUsuario();
  }


  Future<void> mensagemUsuario() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Atenção!"),
          content: Text("Para o abastecimento $combustivel é mais vantajoso!"),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                salvarPosto(_postoTemp);
                Navigator.pop(context);
                _resetFields();
              },
            ),
          ],
        );
      },
    );
  }

  void salvarPosto(Posto _postoTemp){
    if(_postoTemp.id != null){
      helper.update(_postoTemp);
    }else{
      helper.insert(_postoTemp);
    }
  }

  Widget buildAppBar(){
    return AppBar(
      title: Text(_postoTemp.nome ?? "Novo Posto"),
      backgroundColor: Colors.black,
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.local_gas_station),
          onPressed: () {
            _irPara();
          },
        ),
      ],
    );
  }

  Widget buildFloatingActionbutton() {
    return FloatingActionButton(
      child: Icon(Icons.save),
      backgroundColor: Colors.black,
      onPressed: () {
        calcularCombustivel();
      },
    );
  }

  Widget buildContainerImagem() {
    return GestureDetector(
      child: Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: AssetImage("assets/images/gas.png")
          ),
        ),
      ),
    );
  }

  Future<bool> _requestPop() {
    if(_postoEdited) {
      showDialog(context: context,
          builder: (context){
            return AlertDialog(
              title: Text("Descartar alterações?"),
              content: Text("Se continuar as alterações serão perdidas."),
              actions: <Widget>[
                FlatButton(child: Text("Cancelar"),
                  onPressed: () {Navigator.pop(context);},
                ),
                FlatButton(child: Text("Continuar"),
                  onPressed: () {Navigator.pop(context);Navigator.pop(context);},
                ),
              ],
            );
          });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  Widget buildScaffold() {
    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          appBar: buildAppBar(),
          floatingActionButton: buildFloatingActionbutton(),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                buildContainerImagem(),
                TextField(
                  decoration: InputDecoration(labelText: "Nome",),
                  onChanged: (text) {
                    _postoEdited = true;
                    setState(() {
                      _postoTemp.nome = text;
                    });
                  },
                  controller: _nameController,
                  focusNode: _nameFocus,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Preço Alcool",),
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    _postoEdited = true;
                    _postoTemp.precoAlcool = double.parse(text);
                  },
                  controller: _precoAlcoolController =
                  new MaskedTextController(mask: '0.00'),
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Preço Gasolina",),
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    _postoEdited = true;
                    _postoTemp.precoGasolina = double.parse(text);
                  },
                  controller: _precoGasolinaController =
                  new MaskedTextController(mask: '0.00'),
                ),
              ],
            ),
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildScaffold();
  }

  @override
  void initState() {
    super.initState();
    if(widget.posto == null) {
      _postoTemp = Posto();
    } else {
      _postoTemp = Posto.fromMap(widget.posto.toMap());

      _nameController.text = _postoTemp.nome;
      _precoAlcoolController.text =  _postoTemp.precoAlcool as String;
      _precoGasolinaController.text = _postoTemp.precoGasolina as String;
    }
  }
}
