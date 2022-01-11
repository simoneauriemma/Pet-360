import 'package:flutter/material.dart';

class TerminiCodizioni_screen extends StatefulWidget {
  const TerminiCodizioni_screen({Key? key}) : super(key: key);

  @override
  _TerminiCodizioni_screenState createState() =>
      _TerminiCodizioni_screenState();
}

class _TerminiCodizioni_screenState extends State<TerminiCodizioni_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Termini & Condizioni"),
        centerTitle: true,
        elevation: 4,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          child: Text(
            "Superbusque et cycnos. Fugienteque solique purpureisque aut pugnabitis. "
            "Sperabitisque haeduoque metalloque in abeatis e augure potenti conlocaret "
            "profabamur clam thymoque, desertaeque clam ex exspirantesque, quietaret delegimusque"
            " declaraveritis amnemque reddamusque, delegissentque. Consanguineorum expectetque. "
            "Videri aut et conquiritur arcebatque aut expectavitque uisuramque morarem, "
            "quercuique. Clauderis cum adstaboque, in aut ob aborigines describentque "
            "cum coacturosque a resonaboque reponamusque a aut procumbetque. Anguem "
            "et vigiles, attulitque legabamque iuvaveramque e convenissemusque sileo. "
            "Adnaverimque praestaretque populabant, pro eiceresque, et conciliata. "
            "Ociusque demonstro uenissemque processerit certabunt, aut monumenteque "
            "conuerterentque, aut orantes, et ad de pro gerentis per in sulcumque dolavimus,"
            " adaequavisset ibatis ob ad temptavissetis arbitrorumque muris pisoni, ab vertor"
            " cernemus decernero, dubitabo et caeruleaque vicerisque paramini celeraverantque "
            "interrogandoque in e e campe egentemque usurorumque. Cognoscendum dantur hac. "
            "Excusseramque memoravisseque. Iurabitis a aut gyaro, effereturque, averterenturque, "
            "stabo iuli. Meminerimque et necisque. Recedatis praedixitque, pervenio solvar. "
            "Ministris indicemque pulsisque, sanxeramusque, ferebant et mirantibus foret soleo "
            "putaveruntque paratique natusque. Superbusque et cycnos. Fugienteque solique purpureisque aut pugnabitis. "
            "Sperabitisque haeduoque metalloque in abeatis e augure potenti conlocaret "
            "profabamur clam thymoque, desertaeque clam ex exspirantesque, quietaret delegimusque"
            "declaraveritis amnemque reddamusque, delegissentque. Consanguineorum expectetque. "
            "Videri aut et conquiritur arcebatque aut expectavitque uisuramque morarem, "
            "quercuique. Clauderis cum adstaboque, in aut ob aborigines describentque "
            "cum coacturosque a resonaboque reponamusque a aut procumbetque. Anguem "
            "et vigiles, attulitque legabamque iuvaveramque e convenissemusque sileo. "
            "Adnaverimque praestaretque populabant, pro eiceresque, et conciliata. "
            "Ociusque demonstro uenissemque processerit certabunt, aut monumenteque "
            "conuerterentque, aut orantes, et ad de pro gerentis per in sulcumque dolavimus,"
            " adaequavisset ibatis ob ad temptavissetis arbitrorumque muris pisoni, ab vertor"
            " cernemus decernero, dubitabo et caeruleaque vicerisque paramini celeraverantque "
            "interrogandoque in e e campe egentemque usurorumque. Cognoscendum dantur hac. "
            "Excusseramque memoravisseque. Iurabitis a aut gyaro, effereturque, averterenturque, "
            "stabo iuli. Meminerimque et necisque. Recedatis praedixitque, pervenio solvar. "
            "Ministris indicemque pulsisque, sanxeramusque, ferebant et mirantibus foret soleo "
            "putaveruntque paratique natusque.",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
