import '/componentes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'seleccionar_reporte_widget.dart' show SeleccionarReporteWidget;
import 'package:flutter/material.dart';

class SeleccionarReporteModel
    extends FlutterFlowModel<SeleccionarReporteWidget> {
  ///  State fields for stateful widgets in this page.
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
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
