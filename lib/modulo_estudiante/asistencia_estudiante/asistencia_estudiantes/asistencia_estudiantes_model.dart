import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/modulo_estudiante/submenu_estudiantes/menu_estudiantes/menu_estudiantes_widget.dart';
import 'asistencia_estudiantes_widget.dart' show AsistenciaEstudiantesWidget;
import 'package:flutter/material.dart';

class AsistenciaEstudiantesModel
    extends FlutterFlowModel<AsistenciaEstudiantesWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Model for MenuEstudiantes component.
  late MenuEstudiantesModel menuEstudiantesModel;

  @override
  void initState(BuildContext context) {
    menuEstudiantesModel = createModel(context, () => MenuEstudiantesModel());
  }

  @override
  void dispose() {
    menuEstudiantesModel.dispose();
  }
}
