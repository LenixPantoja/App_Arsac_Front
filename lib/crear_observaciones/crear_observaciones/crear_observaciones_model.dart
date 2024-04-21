import '/componentes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'crear_observaciones_widget.dart' show CrearObservacionesWidget;
import 'package:flutter/material.dart';
import '/backend/api_requests/api_calls.dart';


class CrearObservacionesModel
    extends FlutterFlowModel<CrearObservacionesWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;
  // State field(s) for DropDown widget.
  String? dropDownValue3;
  FormFieldController<String>? dropDownValueController3;
  // State field(s) for TextField widget.
  String? dropDownValue4;
  FormFieldController<String>? dropDownValueController4;

  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Model for Menu component.
  late MenuModel menuModel;
    // Stores action output result for [Backend Call - API (ApiAsistenciaEstudiante)] action in Button widget.
  ApiCallResponse? apiResultnmd;

  @override
  void initState(BuildContext context) {
    menuModel = createModel(context, () => MenuModel());
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();

    menuModel.dispose();
  }
}
