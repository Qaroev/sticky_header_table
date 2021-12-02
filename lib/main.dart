import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

final _rowsCells = [
  [7, 8, 10, 8, 7, 10, 8, 7],
  [10, 10, 9, 6, 6, 10, 8, 7],
  [5, 4, 5, 7, 5, 10, 8, 7],
  [9, 4, 1, 7, 8, 10, 8, 7],
  [7, 8, 10, 8, 7, 10, 8, 7],
  [10, 10, 9, 6, 6, 10, 8, 7],
  [5, 4, 5, 7, 5, 10, 8, 7],
  [9, 4, 1, 7, 8, 10, 8, 7],
  [7, 8, 10, 8, 7, 10, 8, 7],
  [10, 10, 9, 6, 6, 10, 8, 7],
  [5, 4, 5, 7, 5, 10, 8, 7],
  [9, 4, 1, 7, 8, 10, 8, 7],
  [7, 8, 10, 8, 7, 10, 8, 7],
  [10, 10, 9, 6, 6, 10, 8, 7],
  [5, 4, 5, 7, 5, 10, 8, 7],
  [9, 4, 1, 7, 8, 10, 8, 7]
];
final _fixedColCells = [
  "Саидов Фарҳод",
  "Ҳаитов Салим",
  "тоҳирова Амина",
  "Аҳмади Аслам",
  "Нодираи Аслам",
  "Gustavo",
  "John",
  "Jack",
  "Pablo",
  "Gustavo",
  "John",
  "Jack",
  "Pablo",
  "Gustavo",
  "John",
  "Jack",
];
final _fixedRowCells = [
  "Холи миёна",
  "Чоряк",
  "Geography",
  "Physics",
  "Biology",
  "23",
  "24",
  "25"
];

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomDataTable(
        fixedCornerCell: "Ному Насаб",
        rowsCells: _rowsCells,
        fixedColCells: _fixedColCells,
        fixedRowCells: _fixedRowCells,
        cellBuilder: (data) {
          return Text('$data', style: const TextStyle(color: Colors.black));
        },
      ),
    );
  }
}

class CustomDataTable<T> extends StatefulWidget {
  final T? fixedCornerCell;
  final List<T>? fixedColCells;
  final List<T>? fixedRowCells;
  final List<List<T>>? rowsCells;
  final Widget Function(T data)? cellBuilder;
  final double fixedColWidth;
  final double cellWidth;
  final double cellHeight;
  final double cellMargin;
  final double cellSpacing;

  CustomDataTable({
    this.fixedCornerCell,
    this.fixedColCells,
    this.fixedRowCells,
    @required this.rowsCells,
    this.cellBuilder,
    this.fixedColWidth = 150.0,
    this.cellHeight = 150.0,
    this.cellWidth = 50.0,
    this.cellMargin = 0.0,
    this.cellSpacing = 10.0,
  });

  @override
  State<StatefulWidget> createState() => CustomDataTableState();
}

class CustomDataTableState<T> extends State<CustomDataTable<T>> {
  final _columnController = ScrollController();
  final _rowController = ScrollController();
  final _subTableYController = ScrollController();
  final _subTableXController = ScrollController();

  Widget _buildChild(double width, T data) => Container(
      width: width,
      padding: const EdgeInsets.only(left: 10, bottom: 10),
      child: widget.cellBuilder?.call(data) ?? Text('$data'));

  Widget _buildFixedCol() => widget.fixedColCells == null
      ? const SizedBox.shrink()
      : Material(
          color: Colors.white,
          child: DataTable(
              horizontalMargin: widget.cellMargin,
              headingRowHeight: widget.cellHeight,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: BorderRadius.circular(5),
              ),
              columns: [
                DataColumn(
                    label: _buildChild(
                        widget.fixedColWidth, widget.fixedColCells!.first))
              ],
              rows: widget.fixedColCells!
                  .sublist(widget.fixedRowCells == null ? 1 : 0)
                  .map((c) => DataRow(cells: [
                        DataCell(Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(width: 10),
                            Text('${widget.fixedColCells!.indexOf(c) + 1}'),
                            Container(
                              height: 80,
                              padding: const EdgeInsets.only(left: 10, top: 18),
                              color: Colors.white,
                              child: Text('$c'),
                            )
                          ],
                        ))
                      ]))
                  .toList()),
        );

  Widget _buildFixedRow() => widget.fixedRowCells == null
      ? const SizedBox.shrink()
      : Material(
          color: const Color(0xFF52B2ED),
          child: DataTable(
              horizontalMargin: widget.cellMargin,
              columnSpacing: widget.cellSpacing,
              headingRowHeight: widget.cellHeight,
              columns: widget.fixedRowCells!
                  .map((c) => DataColumn(
                          label: Container(
                        width: 50,
                        padding: const EdgeInsets.only(left: 10, bottom: 10),
                        height: double.infinity,
                        child: c == 'Холи миёна' || c == 'Чоряк'
                            ? RotatedBox(
                                quarterTurns: 3,
                                child: RichText(
                                  text: TextSpan(
                                    text: '$c',
                                    style: const TextStyle(color: Colors.black),
                                    children: const [],
                                  ),
                                ),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Text('4'),
                                  SizedBox(height: 5),
                                  Text('СШ'),
                                  SizedBox(height: 5),
                                  Icon(
                                    Icons.message,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                      )))
                  .toList(),
              rows: const []),
        );

  Widget _buildSubTable() => Material(
      color: Colors.white,
      child: DataTable(
          showBottomBorder: true,
          dividerThickness: 2.0,
          horizontalMargin: widget.cellMargin,
          columnSpacing: widget.cellSpacing,
          headingRowHeight: widget.cellHeight,
          decoration: BoxDecoration(
              border: Border.all(
            width: 1,
            color: Colors.black,
          )),
          columns: widget.rowsCells!.first
              .map((c) => DataColumn(label: _buildChild(widget.cellWidth, c)))
              .toList(),
          rows: widget.rowsCells!
              .sublist(widget.fixedRowCells == null ? 1 : 0)
              .map((row) => DataRow(
                  cells: row
                      .map((c) => DataCell(_buildChild(widget.cellWidth, c)))
                      .toList()))
              .toList()));

  Widget _buildCornerCell() =>
      widget.fixedColCells == null || widget.fixedRowCells == null
          ? const SizedBox.shrink()
          : Material(
              color: const Color(0xFF52B2ED),
              child: DataTable(
                  horizontalMargin: widget.cellMargin,
                  columnSpacing: widget.cellSpacing,
                  headingRowHeight: widget.cellHeight,
                  dataRowHeight: widget.cellHeight,
                  columns: [
                    DataColumn(
                        label: Container(
                            width: widget.fixedColWidth,
                            padding: EdgeInsets.only(left: 10),
                            child: Text('${widget.fixedCornerCell!}'))),
                  ],
                  rows: const []),
            );

  @override
  void initState() {
    super.initState();
    _subTableXController.addListener(() {
      _rowController.jumpTo(_subTableXController.position.pixels);
    });
    _subTableYController.addListener(() {
      _columnController.jumpTo(_subTableYController.position.pixels);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Row(
          children: <Widget>[
            SingleChildScrollView(
              controller: _columnController,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              child: _buildFixedCol(),
            ),
            Flexible(
              child: SingleChildScrollView(
                controller: _subTableXController,
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  controller: _subTableYController,
                  scrollDirection: Axis.vertical,
                  child: _buildSubTable(),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            _buildCornerCell(),
            Flexible(
              child: SingleChildScrollView(
                controller: _rowController,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                child: _buildFixedRow(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
