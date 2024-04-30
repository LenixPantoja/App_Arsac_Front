import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/modulo_estudiante/submenu_estudiantes/menu_estudiantes/menu_estudiantes_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'asistencia_estudiantes_model.dart';
export 'asistencia_estudiantes_model.dart';
import '/backend/api_requests/api_calls.dart';

class AsistenciaEstudiantesWidget extends StatefulWidget {
  const AsistenciaEstudiantesWidget({super.key});

  @override
  State<AsistenciaEstudiantesWidget> createState() =>
      _AsistenciaEstudiantesWidgetState();
}

class _AsistenciaEstudiantesWidgetState
    extends State<AsistenciaEstudiantesWidget> {
  int getIdCurso = 0;
  int getIdMateria = 0;

  // Lista para almacenar las materias que dicta el docente
  List<dynamic> listaMateriasEstudiante = [];
  // Lista para almacenar los cursos a los cuales dicta clases el docente
  List<dynamic> listaCursosEstudiante = [];
  // Lista para almacenar los estudiantes matriucados a una materia y a un curso
  String cursoSeleccionado = "";
  // Guarda el nombre de la materia seleccionada por el usuario
  String materiaSeleccionada = "";
  // Guarda el usuario que inicia sesion
  String user = "";
  // Lista para almacenar la asistencia del estudiante
  List<dynamic> listaAsistenciaEstudiante = [];

  Future<void> _fetchMateriasData() async {
    ApiMateriasPorEstudianteCall apiCall = ApiMateriasPorEstudianteCall();
    // Call the function to fetch subject data
    List<dynamic> data = await apiCall.fetchMaterias();
    setState(() {
      listaMateriasEstudiante = data;
    });
  }

  Future<void> _fetchCursosData() async {
    ApiCursosEstudiantesCall apiCall = ApiCursosEstudiantesCall();
    // Call the function to fetch subject data
    List<dynamic> data = await apiCall.fetchCursos();
    setState(() {
      listaCursosEstudiante = data;
    });
  }

  Future<void> _fetchConsultaAsistenciaEstudiante(
      String pUser, int pMateria, int pCurso) async {
    ApiConsultarAsistenciaEstudianteCall apiCall =
        ApiConsultarAsistenciaEstudianteCall();

    List<dynamic> data =
        await apiCall.fetchConsultaAsistEstudiante(pUser, pMateria, pCurso);
    setState(() {
      listaAsistenciaEstudiante = data;
      print(listaAsistenciaEstudiante);
    });
  }

  // Método para obtener el id del curso dado el nombre del curso
  // @ Proceso:
  // 1.- El usuario selecciona el curso de la lista desplegable
  // 2.- Se obtiene el nombre del curso
  // 3.- Se toma el nombre del curso y se pasa el nombre del curso como parámetro al metodo @obtenerIdCurso(pCurso)
  //     para obtener el id del curso y pasarlo a la método @_fetchEstudiantesData(pMateria, pCurso)
  int obtenerIdCurso(String pCurso) {
    int idCurso = 0;
    for (int i = 0; i < listaCursosEstudiante.length; i++) {
      String cursoMateria = listaCursosEstudiante[i]["nombre_curso"] +
          ' | ' +
          listaCursosEstudiante[i]["materia"];
      if (cursoMateria == pCurso) {
        idCurso = listaCursosEstudiante[i]["id"];
        materiaSeleccionada = listaCursosEstudiante[i]["materia"];
      }
    }
    return idCurso;
  }

// Método para obtener el id del materia dado el nombre de la materia
  // @ Proceso:
  // 1.- El usuario selecciona la materia de la lista desplegable
  // 2.- Se obtiene el nombre del materia
  // 3.- Se toma el nombre del curso y se pasa el nombre de la materia como parámetro al metodo @obtenerIdMateria(pMateria)
  //     para obtener el id de la materia y pasarlo a la método @_fetchEstudiantesData(pMateria, pCurso)
  int obtenerIdMateria(String pMateria) {
    int idMateria = 0;
    for (int i = 0; i < listaMateriasEstudiante.length; i++) {
      if (listaMateriasEstudiante[i]["Materia"] == pMateria) {
        idMateria = listaMateriasEstudiante[i]["id"];
        //print(listaMateriasEstudiante[i]["Materia"]);
      }
    }
    return idMateria;
  }

  late AsistenciaEstudiantesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Usuario miUser = Usuario();
    user = miUser.nombreUsuario;
    _fetchMateriasData();
    _fetchCursosData();
    _model = createModel(context, () => AsistenciaEstudiantesModel());
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
        ),
        child: SingleChildScrollView(
          primary: false,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: 127.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: SvgPicture.asset(
                    'assets/images/Reporte_(25).svg',
                    width: 300.0,
                    height: 222.0,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 700.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  elevation: 12.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 20.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 149.0,
                              height: 73.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Card(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      elevation: 12.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: FFButtonWidget(
                                        onPressed: () {
                                          print('Button pressed ...');
                                        },
                                        text: 'Desde',
                                        icon: const Icon(
                                          Icons.calendar_month,
                                          size: 30.0,
                                        ),
                                        options: FFButtonOptions(
                                          height: 40.0,
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(24.0, 0.0, 24.0, 0.0),
                                          iconPadding:
                                              const EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .titleSmall
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                letterSpacing: 0.0,
                                              ),
                                          elevation: 3.0,
                                          borderSide: const BorderSide(
                                            color: Colors.transparent,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: Container(
                                width: 162.0,
                                height: 74.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Card(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        elevation: 12.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: FFButtonWidget(
                                          onPressed: () {
                                            print('Button pressed ...');
                                          },
                                          text: 'Hasta',
                                          icon: const Icon(
                                            Icons.calendar_month,
                                            size: 30.0,
                                          ),
                                          options: FFButtonOptions(
                                            height: 40.0,
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(24.0, 0.0, 24.0, 0.0),
                                            iconPadding:
                                                const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      letterSpacing: 0.0,
                                                    ),
                                            elevation: 3.0,
                                            borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
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
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 12.0, 0.0, 0.0),
                        child: Container(
                          width: 380.0,
                          height: 72.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  elevation: 12.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: FlutterFlowDropDown<String>(
                                    controller:
                                        _model.dropDownValueController ??=
                                            FormFieldController<String>(null),
                                    options: listaCursosEstudiante
                                        .map<String>((curso) =>
                                            curso["nombre_curso"] +
                                                ' | ' +
                                                curso["materia"] as String)
                                        .toList(),
                                    onChanged: (String? val) {
                                      setState(
                                          () => _model.dropDownValue = val);
                                      cursoSeleccionado = val!;
                                      getIdCurso =
                                          obtenerIdCurso(cursoSeleccionado);
                                      getIdMateria =
                                          obtenerIdMateria(materiaSeleccionada);
                                      print(getIdCurso);
                                      print(getIdMateria);
                                    },
                                    width: 292.0,
                                    height: 43.0,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0.0,
                                        ),
                                    hintText: 'Seleccione Materias',
                                    fillColor: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    elevation: 2.0,
                                    borderColor:
                                        FlutterFlowTheme.of(context).alternate,
                                    borderWidth: 2.0,
                                    borderRadius: 8.0,
                                    margin:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            16.0, 4.0, 16.0, 4.0),
                                    hidesUnderline: true,
                                    isOverButton: true,
                                    isSearchable: false,
                                    isMultiSelect: false,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 12.0, 0.0, 12.0),
                        child: FFButtonWidget(
                          onPressed: () {
                            _fetchConsultaAsistenciaEstudiante(
                                user, getIdMateria, getIdCurso);
                          },
                          text: 'Generar',
                          options: FFButtonOptions(
                            height: 40.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: const Color(0xFF57E84E),
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                ),
                            elevation: 3.0,
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 12.0, 0.0, 12.0),
                        child: Container(
                          width: double.infinity,
                          height: 50.0,
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
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Align(
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: Text(
                                'Lista de asistencia',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 20.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: SingleChildScrollView(
                            primary: false,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 12.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Flexible(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Align(
                                              alignment:
                                                  const AlignmentDirectional(
                                                      0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Nombres',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        child: Align(
                                          alignment: const AlignmentDirectional(
                                              1.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          1.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                            20.0, 0.0),
                                                    child: Text(
                                                      'Elegir Opciones',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Readex Pro',
                                                            fontSize: 16.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                Container(
                                  width: double
                                      .infinity, // Ancho máximo disponible
                                  child: Expanded(
                                    child: SingleChildScrollView(
                                      physics:
                                          const AlwaysScrollableScrollPhysics(), // Ajustar al contenido disponible
                                      child: DataTable(
                                        columns: const [
                                          DataColumn(label: Text('Tipo')),
                                          DataColumn(label: Text('Hora')),
                                          DataColumn(label: Text('Materia'))
                                        ],
                                        rows: listaAsistenciaEstudiante
                                            .map((item) {
                                          return DataRow(
                                            cells: [
                                              DataCell(Text(
                                                  item['Tipo_asistencia'])),
                                              DataCell(
                                                  Text(item['Hora_llegada'])),
                                              DataCell(Text(item['Materia']))
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 12.0, 0.0, 0.0),
                        child: Container(
                          width: 150.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            elevation: 12.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
        ),
      ),
    );
  }
}
