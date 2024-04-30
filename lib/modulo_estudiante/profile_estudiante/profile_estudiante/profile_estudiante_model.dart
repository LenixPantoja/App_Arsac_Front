import '/flutter_flow/flutter_flow_util.dart';
import '/modulo_estudiante/submenu_estudiantes/menu_estudiantes/menu_estudiantes_widget.dart';
import 'profile_estudiante_widget.dart' show ProfileEstudianteWidget;
import 'package:flutter/material.dart';

class ProfileEstudianteModel extends FlutterFlowModel<ProfileEstudianteWidget> {
  ///  State fields for stateful widgets in this page.

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
