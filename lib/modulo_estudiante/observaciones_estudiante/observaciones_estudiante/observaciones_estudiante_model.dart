import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/modulo_estudiante/submenu_estudiantes/menu_estudiantes/menu_estudiantes_widget.dart';
import 'observaciones_estudiante_widget.dart'
    show ObservacionesEstudianteWidget;
import 'package:flutter/material.dart';

class ObservacionesEstudianteModel
    extends FlutterFlowModel<ObservacionesEstudianteWidget> {
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
