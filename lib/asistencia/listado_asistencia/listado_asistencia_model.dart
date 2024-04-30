import '/componentes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'listado_asistencia_widget.dart' show ListadoAsistenciaWidget;
import 'package:flutter/material.dart';

class ListadoAsistenciaModel extends FlutterFlowModel<ListadoAsistenciaWidget> {
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
