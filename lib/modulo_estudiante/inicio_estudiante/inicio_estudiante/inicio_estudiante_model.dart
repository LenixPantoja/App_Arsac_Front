import '/flutter_flow/flutter_flow_util.dart';
import '/modulo_estudiante/submenu_estudiantes/menu_estudiantes/menu_estudiantes_widget.dart';
import 'inicio_estudiante_widget.dart' show InicioEstudianteWidget;
import 'package:flutter/material.dart';

class InicioEstudianteModel extends FlutterFlowModel<InicioEstudianteWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Pagina_Fotos_Secuenciales_1 widget.
  PageController? paginaFotosSecuenciales1Controller;

  int get paginaFotosSecuenciales1CurrentIndex =>
      paginaFotosSecuenciales1Controller != null &&
              paginaFotosSecuenciales1Controller!.hasClients &&
              paginaFotosSecuenciales1Controller!.page != null
          ? paginaFotosSecuenciales1Controller!.page!.round()
          : 0;
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
