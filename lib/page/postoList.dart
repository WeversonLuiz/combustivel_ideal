import 'package:combustivel_ideal/helper/posto_helper.dart';
import 'package:combustivel_ideal/model/posto.dart';
import 'package:combustivel_ideal/page/posto.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class PostoListPage extends StatefulWidget {
  @override
  _PostoListPageState createState() => _PostoListPageState();
}

class _PostoListPageState extends State<PostoListPage> {

  PostoHelper helper = PostoHelper();

  List<Posto> lsPostos = List();

  Widget buildAppBar(){
    return AppBar(
      title: Text("Postos de Combustíveis"),
      backgroundColor: Colors.redAccent,
      centerTitle: true,
    );
  }

  void _showPostoPage({Posto posto}) async {
    final regPosto = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PostoPage(posto: posto)
      ),
    );

    if (regPosto != null) {
      if (posto != null) {
        await helper.update(regPosto);
      } else {
        await helper.insert(regPosto);
      }
    }
  }

  Widget buildFloatingActionbutton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.redAccent,
      onPressed: (){
        _showPostoPage();
      },
    );
  }

  Widget buildCardPosto (BuildContext context, int index){
    return GestureDetector(
      child: Card(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/gas.png'),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(lsPostos[index].nome ?? "-",
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      Text("Alcool:   " + lsPostos[index].precoAlcool.toString() ?? "0.0",
                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      Text("Gasolina: " + lsPostos[index].precoGasolina.toString() ?? "0.0",
                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      /*Text("Consulta realizada em " + formatDate(lsPostos[index].instante,[dd, '/', mm, '/', yyyy]) ?? "2016-10-23 00:00:00",
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),*/
                    ],
                  ),
                )
              ],
            ),
          )
      ),
    );
  }

  Widget buildListView() {
    return ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: lsPostos.length,
        itemBuilder: (context, index) {
          return buildCardPosto(context, index);
        });
  }

  Widget bulidScaffold() {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Colors.white,
      floatingActionButton: buildFloatingActionbutton(),
      body: buildListView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return bulidScaffold();
  }

  void _loadAllPostos() {
    helper.selectAll().then((list) {
      setState(() {
        lsPostos = list;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _loadAllPostos();
  }
}
