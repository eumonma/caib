import 'package:flutter/material.dart';

class TicketDataTable extends StatefulWidget {
  const TicketDataTable({Key? key}) : super(key: key);

  @override
  State<TicketDataTable> createState() => _TicketDataTableState();
}

class _TicketDataTableState extends State<TicketDataTable> {
  @override
  Widget build(BuildContext context) {
    final columns = [
      'Cod.Ticket',
      'Desc.Ticket',
      'H. Estimadas',
      'H. Consumidas',
      'Empresa',
      'Finalizada'
    ];

    return DataTable(
      columns: getColumns(columns),
      rows: [],
    );
  }

  List<DataColumn> getColumns(List<String> columns) =>
      columns.map((String column) => DataColumn(label: Text(column))).toList();
}
