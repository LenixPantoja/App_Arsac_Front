import '/flutter_flow/flutter_flow_util.dart';
import '/modulo_estudiante/submenu_estudiantes/menu_estudiantes/menu_estudiantes_widget.dart';
import 'notificaciones_estudiante_widget.dart'
    show NotificacionesEstudianteWidget;
import 'package:flutter/material.dart';

class NotificacionesEstudianteModel
    extends FlutterFlowModel<NotificacionesEstudianteWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // Model for MenuEstudiantes component.
  late MenuEstudiantesModel menuEstudiantesModel;

  @override
  void initState(BuildContext context) {
    menuEstudiantesModel = createModel(context, () => MenuEstudiantesModel());
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    menuEstudiantesModel.dispose();
  }
}
