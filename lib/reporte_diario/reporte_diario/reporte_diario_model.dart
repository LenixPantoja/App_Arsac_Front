import '/componentes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'reporte_diario_widget.dart' show ReporteDiarioWidget;
import 'package:flutter/material.dart';

class ReporteDiarioModel extends FlutterFlowModel<ReporteDiarioWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for Menu component.
  late MenuModel menuModel;

  @override
  void initState(BuildContext context) {
    menuModel = createModel(context, () => MenuModel());
  }

  @override
  void dispose() {
    menuModel.dispose();
  }
}
