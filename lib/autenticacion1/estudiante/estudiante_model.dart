import '/componentes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'estudiante_widget.dart' show EstudianteWidget;
import 'package:flutter/material.dart';

class EstudianteModel extends FlutterFlowModel<EstudianteWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Pagina_Fotos_Secuenciales_1 widget.
  PageController? paginaFotosSecuenciales1Controller;

  int get paginaFotosSecuenciales1CurrentIndex =>
      paginaFotosSecuenciales1Controller != null &&
              paginaFotosSecuenciales1Controller!.hasClients &&
              paginaFotosSecuenciales1Controller!.page != null
          ? paginaFotosSecuenciales1Controller!.page!.round()
          : 0;
  // Model for Menu component.
  late MenuModel menuModel;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    menuModel = createModel(context, () => MenuModel());
  }

  @override
  void dispose() {
    menuModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
