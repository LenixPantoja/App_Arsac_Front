import '/componentes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'carnet_asitencia_widget.dart' show CarnetAsitenciaWidget;
import 'package:flutter/material.dart';

class CarnetAsitenciaModel extends FlutterFlowModel<CarnetAsitenciaWidget> {
  ///  State fields for stateful widgets in this page.

  var scanner = '';
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
