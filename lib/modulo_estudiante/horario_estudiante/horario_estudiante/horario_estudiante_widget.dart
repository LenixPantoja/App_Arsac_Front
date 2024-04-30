import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/modulo_estudiante/submenu_estudiantes/menu_estudiantes/menu_estudiantes_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'horario_estudiante_model.dart';
export 'horario_estudiante_model.dart';
import '/backend/api_requests/api_calls.dart';

class HorarioEstudianteWidget extends StatefulWidget {
  const HorarioEstudianteWidget({super.key});

  @override
  State<HorarioEstudianteWidget> createState() =>
      _HorarioEstudianteWidgetState();
}

class _HorarioEstudianteWidgetState extends State<HorarioEstudianteWidget> {
  // Lista para guardar el horario del docente
  String miMateria = "";
  String miDia = "";
  List<dynamic> listaHorarioEstudiante = [];
  List<dynamic> listaHorarioPorDia = [];

  Future<void> _fetchHorarioEstudiante(String pUserEstudiante) async {
    ApiHorarioEstudianteCall apiCall = ApiHorarioEstudianteCall();
    // Call the function to fetch subject data
    List<dynamic> data = await apiCall.fetchHorarioEstudiante(pUserEstudiante);
    setState(() {
      listaHorarioEstudiante = data;
    });
  }

  void informacionHorario(String pDia) {
    for (int i = 0; i < listaHorarioEstudiante.length; i++) {
      if (listaHorarioEstudiante[i]["Dia"] == pDia) {
        print(pDia);
        miMateria = listaHorarioEstudiante[i]["Materia"];
        listaHorarioPorDia.add({
          "Materia": listaHorarioEstudiante[i]["Materia"],
          "Docente": listaHorarioEstudiante[i]["Docente"],
          "Dia": listaHorarioEstudiante[i]["Dia"],
          "Hora_inicio": listaHorarioEstudiante[i]["Hora_inicio"],
          "Hora_fin": listaHorarioEstudiante[i]["Hora_fin"]
        });
        print(listaHorarioPorDia);
      }
    }
  }

  void _mostrarInformacionClase(BuildContext context, DateTime selectedDate) {
    // Obtenemos el nombre del día de la semana
    String dayOfWeek = '';
    switch (selectedDate.weekday) {
      case 1:
        listaHorarioPorDia.clear();
        dayOfWeek = 'LUNES';
        informacionHorario(dayOfWeek);
        break;
      case 2:
        listaHorarioPorDia.clear();
        dayOfWeek = 'MARTES';
        informacionHorario(dayOfWeek);
        break;
      case 3:
        listaHorarioPorDia.clear();
        dayOfWeek = 'MIERCOLES';
        informacionHorario('MIERCOLES');
        break;
      case 4:
        listaHorarioPorDia.clear();
        dayOfWeek = 'JUEVES';
        informacionHorario('JUEVES');
        break;
      case 5:
        listaHorarioPorDia.clear();
        dayOfWeek = 'VIERNES';
        informacionHorario('VIERNES');
        break;
      case 6:
        listaHorarioPorDia.clear();
        dayOfWeek = 'SABADO';
        informacionHorario('SABADO');
        break;
      case 7:
        listaHorarioPorDia.clear();
        dayOfWeek = 'DOMINGO';
        informacionHorario('DOMINGO');
        break;
    }

    // Mostramos la ventana emergente con la información de la clase y el día de la semana
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Horario del Estudiante'),
          content: SizedBox(
            width: double.maxFinite,
            height: 300,
            child: ListView.builder(
              itemCount: listaHorarioPorDia.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> horario = listaHorarioPorDia[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Materia: ${horario["Materia"]}'),
                    Text('Profesor: ${horario["Docente"]}'),
                    Text('Día: ${horario["Dia"]}'),
                    Text('Hora inicio: ${horario["Hora_inicio"]}'),
                    Text('Hora fin: ${horario["Hora_fin"]}'),
                    Divider(), // Separador entre cada elemento
                  ],
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  late HorarioEstudianteModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Usuario dataUser = Usuario();
    _fetchHorarioEstudiante(dataUser.nombreUsuario);
    _model = createModel(context, () => HorarioEstudianteModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Stack(
        children: [
          SingleChildScrollView(
            primary: false,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  height: 143.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAD02C),
                    border: Border.all(
                      color: const Color(0xFFFAD02C),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: SvgPicture.asset(
                      'assets/images/Reporte_(9).svg',
                      width: 300.0,
                      height: 239.0,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 650.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Container(
                            width: 360.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              elevation: 4.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.0),
                              ),
                              child: SingleChildScrollView(
                                primary: false,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    FlutterFlowCalendar(
                                      color: const Color(0xFFFF0716),
                                      iconColor: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      weekFormat: false,
                                      weekStartsMonday: false,
                                      rowHeight: 64.0,
                                      onChange:
                                          (DateTimeRange? newSelectedDate) {
                                        if (newSelectedDate != null) {
                                          // Llamamos al método para mostrar la información de la clase y el día de la semana

                                          _mostrarInformacionClase(
                                              context, newSelectedDate.start);

                                          setState(() {
                                            _model.calendarSelectedDay =
                                                newSelectedDate;
                                          });
                                        }
                                      },
                                      titleStyle: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .override(
                                            fontFamily: 'Outfit',
                                            letterSpacing: 0.0,
                                          ),
                                      dayOfWeekStyle:
                                          FlutterFlowTheme.of(context)
                                              .labelLarge
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                letterSpacing: 0.0,
                                              ),
                                      dateStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            letterSpacing: 0.0,
                                          ),
                                      selectedDateStyle:
                                          FlutterFlowTheme.of(context)
                                              .titleSmall
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                letterSpacing: 0.0,
                                              ),
                                      inactiveDateStyle:
                                          FlutterFlowTheme.of(context)
                                              .labelMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                letterSpacing: 0.0,
                                              ),
                                    ),
                                  ].divide(const SizedBox(height: 12.0)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                height: 70.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: wrapWithModel(
                        model: _model.menuEstudiantesModel,
                        updateCallback: () => setState(() {}),
                        child: const MenuEstudiantesWidget(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
