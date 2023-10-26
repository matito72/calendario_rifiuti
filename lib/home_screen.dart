import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  // const MyHomePage({required this.title, super.key});
  const HomeScreen({required this.title, super.key});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool goPrecSucc = true;
  DateTime _selectedDate = DateTime.now();
  final String _fileNameBase = 'assets/immagini/2023/DUE-CARRARE_calendario_2023-<M>.<N>.jpg';
  String _pathImage = "assets/immagini/2023/DUE-CARRARE_calendario_rifiuti.2023.jpg";

   @override
  void initState() {
    super.initState();
    _cambiaImmagine(_selectedDate);
  }

  void _getData(context) async {
    var fDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
    );
    //aggiornare lo stato
    if (fDate != null) {
      setState(() => _cambiaImmagine(fDate));
    }
  }

  _goToMonthSucc() {
    if (_selectedDate.month <= 12) {
      int day = (_selectedDate.day >= 16) ? 1 : 17;
      int month = (_selectedDate.day > 16) 
        ? (_selectedDate.month != 12) ? (_selectedDate.month + 1) : 12
        : _selectedDate.month;

      _selectedDate = DateTime(_selectedDate.year, month, day);
      setState(() => _cambiaImmagine(_selectedDate));
    }
  }

  _goToMonthPrec() {
    if (_selectedDate.month >= 1) {
      int day = (_selectedDate.day >= 16) ? 1 : 17;
      int month = (_selectedDate.day > 16) 
        ? _selectedDate.month
        : (_selectedDate.month != 1) ? (_selectedDate.month - 1) : 1;

      _selectedDate = DateTime(_selectedDate.year, month, day);
      setState(() => _cambiaImmagine(_selectedDate));
    }
  }

  _cambiaImmagine(var fDate) {
    _selectedDate = fDate;
    int month = _selectedDate.month;
    int day = _selectedDate.day;

    int m = month;
    int n = 1;
    if (day > 16) {
      n = 2;
    }
    _pathImage = _fileNameBase.replaceAll('<M>', m.toString()).replaceAll('<N>', n.toString());
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat df = DateFormat("dd/MM/yyyy");

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(6.0)),
              color: Colors.lightGreen.shade100,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Center(
                child: Column(
                    children: <Widget>[
                      Card(
                        elevation: 10,
                        color: Colors.green.shade700, 
                        child: SizedBox(
                          width: 350,
                          height:  (MediaQuery.of(context).size.height * 7 / 100),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                df.format(_selectedDate),
                                style: const TextStyle(color: Colors.white, fontSize: 25),
                              ),
                              IconButton(
                                icon: const Icon(Icons.date_range, size: 30, color: Colors.white),
                                onPressed: () => _getData(context),
                              )
                            ]
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 20)) ,
                      GestureDetector(
                        onHorizontalDragEnd: (dragDetail) {
                        if (goPrecSucc) {
                          if (dragDetail.primaryVelocity == null) return;
                            if (dragDetail.primaryVelocity! < 0) {
                              _goToMonthSucc();
                            } else {
                              _goToMonthPrec();
                            }
                          }
                        },
                        child: InteractiveViewer(
                          panEnabled: true,
                          minScale: 1,
                          maxScale: 2,
                          child: Container(
                            width: (MediaQuery.of(context).size.width * 95 / 100),
                            height: (MediaQuery.of(context).size.height * 80 / 100),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                scale: 0.9,
                                image: AssetImage(_pathImage),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
              ),
            ),
          ),
        ),
      ),
    );
  } //build context
}