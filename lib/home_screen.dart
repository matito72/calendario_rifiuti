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
    cambiaImmagine(_selectedDate);
  }

  void getData(context) async {
    var fDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
    );
    //aggiornare lo stato
    if (fDate != null) {
      setState(() => cambiaImmagine(fDate));
    }
  }

  goToMonthSucc() {
    if (_selectedDate.month < 12) {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day + 15);
      setState(() => cambiaImmagine(_selectedDate));
    }
  }

  goToMonthPrec() {
    if (_selectedDate.month > 1) {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day - 15);
      setState(() => cambiaImmagine(_selectedDate));
    }
  }

  cambiaImmagine(var fDate) {
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
    final transformationController = TransformationController();
    late TapDownDetails doubleTapDetails;

    void handleDoubleTapDown(TapDownDetails details) {
      doubleTapDetails = details;
    }

    void handleDoubleTap() {
      if (transformationController.value != Matrix4.identity()) {
        goPrecSucc = true;
        transformationController.value = Matrix4.identity();
      } else {
        goPrecSucc = false;
        final position = doubleTapDetails.localPosition;
        // For a 3x zoom
        transformationController.value = Matrix4.identity()
          ..translate(-position.dx, -position.dy)
          ..scale(2.0);
        // Fox a 3x zoom
        // ..translate(-position.dx * 2, -position.dy * 2)
        // ..scale(3.0);
      }
    }

    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(title: Text(widget.title)),
        body: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(6.0)),
            color: Colors.lightGreen.shade100,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6.0)),
                        color: Colors.lightGreen.shade100,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Column(
                          children: <Widget>[
                            Card(
                              elevation: 10,
                              color: Colors.green.shade700, // Theme.of(context).colorScheme.surfaceVariant,
                              child: SizedBox(
                                // width: 300,
                                height:  (MediaQuery.of(context).size.height * 8 / 100),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        df.format(_selectedDate),
                                        style: const TextStyle(color: Colors.white, fontSize: 25),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.date_range, size: 30, color: Colors.white),
                                        onPressed: () => getData(context),
                                      )
                                    ]),
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 30),
                      ),
                      GestureDetector(
                        onHorizontalDragEnd: (dragDetail) {
                          if (goPrecSucc) {
                            if (dragDetail.primaryVelocity == null) return;
                              if (dragDetail.primaryVelocity! < 0) {
                                goToMonthSucc();
                              } else {
                                goToMonthPrec();
                              }
                          }
                        },
                        onDoubleTapDown: handleDoubleTapDown,
                        onDoubleTap: handleDoubleTap,
                        child: InteractiveViewer(transformationController:
                                transformationController,
                            panEnabled: false, // Set it to false to prevent panning.
                            // boundaryMargin: const EdgeInsets.all(40),
                            minScale: 0.5,
                            maxScale: 4,
                            child: SizedBox(
                              width: (MediaQuery.of(context).size.height * 95 / 100), //avremmo potuto usare  width.toDouble(), 
                              height: (MediaQuery.of(context).size.height * 80 / 100), // necessario
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Image.asset(_pathImage),
                              ),
                            )
                          ),
                      )
                            /* Center(
                              child: Zoom(
                                initTotalZoomOut: true,
                                child: Center(
                                  child: Image.asset(_pathImage),
                                ),
                              )
                            ), */
                          ],
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  } //build context
}