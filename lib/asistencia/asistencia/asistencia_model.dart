import '/backend/api_requests/api_calls.dart';
import '/componentes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'asistencia_widget.dart' show AsistenciaWidget;
import 'package:flutter/material.dart';

class AsistenciaModel extends FlutterFlowModel<AsistenciaWidget> {
  ///  State fields for stateful widgets in this page.
  var scanner = '';
  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;
  // State field(s) for DropDown widget.
  String? dropDownValue3;
  FormFieldController<String>? dropDownValueController3;
  // Model for Menu component.
  late MenuModel menuModel;
  // Stores action output result for [Backend Call - API (ApiAsistenciaEstudiante)] action in Button widget.
  ApiCallResponse? apiResultnmd;


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
