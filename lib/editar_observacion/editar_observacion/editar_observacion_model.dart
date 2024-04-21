import '/componentes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'editar_observacion_widget.dart' show EditarObservacionWidget;
import 'package:flutter/material.dart';
import '/backend/api_requests/api_calls.dart';

class EditarObservacionModel extends FlutterFlowModel<EditarObservacionWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Model for Menu component.
  
  // Stores action output result for [Backend Call - API (ApiAsistenciaEstudiante)] action in Button widget.
  ApiCallResponse? apiResultnmd;
  late MenuModel menuModel;

  /// Initialization and disposal methods.

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

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
