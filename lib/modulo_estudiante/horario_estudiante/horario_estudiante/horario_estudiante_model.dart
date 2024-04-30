import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/modulo_estudiante/submenu_estudiantes/menu_estudiantes/menu_estudiantes_widget.dart';
import 'horario_estudiante_widget.dart' show HorarioEstudianteWidget;
import 'package:flutter/material.dart';

class HorarioEstudianteModel extends FlutterFlowModel<HorarioEstudianteWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Calendar widget.
  DateTimeRange? calendarSelectedDay;
  // Model for MenuEstudiantes component.
  late MenuEstudiantesModel menuEstudiantesModel;

  @override
  void initState(BuildContext context) {
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
    menuEstudiantesModel = createModel(context, () => MenuEstudiantesModel());
  }

  @override
  void dispose() {
    menuEstudiantesModel.dispose();
  }
}
