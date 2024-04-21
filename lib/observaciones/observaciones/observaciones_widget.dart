import 'package:arsac_app/index.dart';

import '/componentes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'observaciones_model.dart';
export 'observaciones_model.dart';
import '/backend/api_requests/api_calls.dart';

class ObservacionesWidget extends StatefulWidget {
  const ObservacionesWidget({super.key});

  @override
  State<ObservacionesWidget> createState() => _ObservacionesWidgetState();
}

class _ObservacionesWidgetState extends State<ObservacionesWidget> {
  // Lista para almacenar las materias que dicta el docente
  List<dynamic> listaMateriasDocente = [];
  // Lista para almacenar los cursos a los cuales dicta clases el docente
  List<dynamic> listaCursosDocente = [];
  // Lista para almacenar los estudiantes matriucados a una materia y a un curso
  List<dynamic> listaEstudiantesMC = [];
  // Lista para almacenar la asitencia del estudiante
  List<dynamic> listaAsistenciaEstudiante = [];
  // Lista para almacenar las observaciones del estudiante
  List<dynamic> listaObservacionesEstudiante = [];
  // Guarda el nombre del curso seleccionado por el usuario
  String cursoSeleccionado = "";
  // Guarda el nombre de la materia seleccionada por el usuario
  String materiaSeleccionada = "";
  // Guarda el estudiante seleccionado por el usuario
  String estudianteSeleccionado = "";

  late ObservacionesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _fetchMateriasData() async {
    ApiMateriasPorDocenteCall apiCall = ApiMateriasPorDocenteCall();
    // Call the function to fetch subject data
    List<dynamic> data = await apiCall.fetchMaterias();
    setState(() {
      listaMateriasDocente = data;
    });
  }

  Future<void> _fetchCursosData() async {
    ApiCursoCall apiCall = ApiCursoCall();

    List<dynamic> data = await apiCall.fetchCursos();
    setState(() {
      listaCursosDocente = data;
    });
  }

  Future<void> _fetchEstudiantesData(int pMateria, int pCurso) async {
    ApiMateriaCursoEstudianteCall apiCall = ApiMateriaCursoEstudianteCall();

    List<dynamic> data = await apiCall.fetchEstudiantes(pMateria, pCurso);
    setState(() {
      listaEstudiantesMC = data;
      print(listaEstudiantesMC);
    });
  }

  Future<void> _fetchObservaciones(
      int pIdEstudiante, int pMateria, int pCurso) async {
    ApiObservacionesEstudianteCall apiCall = ApiObservacionesEstudianteCall();

    List<dynamic> data =
        await apiCall.getObservaciones(pIdEstudiante, pMateria, pCurso);
    setState(() {
      listaObservacionesEstudiante = data;
      print(listaObservacionesEstudiante);
    });
  }

  Future<void> eliminarObservacion(int pIdObservacion) async {
    ApiObservacionesEstudianteCall apiCall = ApiObservacionesEstudianteCall();

    String data = await apiCall.deleteObservaciones(pIdObservacion);
    ApiObservacionesEstudianteCall apiCallObservaciones =
        ApiObservacionesEstudianteCall();

    int id_estudiante = obtenerIdEstudiante(estudianteSeleccionado);
    int id_materia = obtenerIdMateria(materiaSeleccionada);
    int id_curso = obtenerIdCurso(cursoSeleccionado);
    List<dynamic> dataObservaciones =
        await apiCall.getObservaciones(id_estudiante, id_materia, id_curso);
    setState(() {
      listaObservacionesEstudiante = dataObservaciones;
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
    for (int i = 0; i < listaCursosDocente.length; i++) {
      String cursoMateria = listaCursosDocente[i]["nombre_curso"] +
          ' | ' +
          listaCursosDocente[i]["materia"];
      if (cursoMateria == pCurso) {
        idCurso = listaCursosDocente[i]["id"];
        materiaSeleccionada = listaCursosDocente[i]["materia"];
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
    for (int i = 0; i < listaMateriasDocente.length; i++) {
      if (listaMateriasDocente[i]["Materia"] == pMateria) {
        idMateria = listaMateriasDocente[i]["id"];
      }
    }
    return idMateria;
  }

  int obtenerIdEstudiante(String pNombre) {
    int idEstudiante = 0;
    for (int i = 0; i < listaEstudiantesMC.length; i++) {
      String nombreEstudiante = listaEstudiantesMC[i]["id"].toString() +
          listaEstudiantesMC[i]["Nombre_Estudiante"];
      if (nombreEstudiante == pNombre) {
        idEstudiante = listaEstudiantesMC[i]["id_estudiante"];
      }
    }
    return idEstudiante;
  }

  @override
  void initState() {
    super.initState();
    _fetchMateriasData();
    _fetchCursosData();

    _model = createModel(context, () => ObservacionesModel());
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
      floatingActionButton: Align(
        alignment: const AlignmentDirectional(1.0, -1.0),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
          child: FloatingActionButton(
            onPressed: () async {
              context.pushNamed(
                'CrearObservaciones',
                extra: <String, dynamic>{
                  kTransitionInfoKey: const TransitionInfo(
                    hasTransition: true,
                    transitionType: PageTransitionType.bottomToTop,
                    duration: Duration(milliseconds: 300),
                  ),
                },
              );
            },
            backgroundColor: FlutterFlowTheme.of(context).info,
            elevation: 20.0,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/images/Diseo_sin_ttulo_(2).png',
                fit: BoxFit.fill,
                alignment: const Alignment(0.0, 0.0),
              ),
            ),
          ),
        ),
      ),
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
                height: 152.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: SvgPicture.asset(
                    'assets/images/Reporte_(12).svg',
                    width: 300.0,
                    height: 188.0,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 1056.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: const AlignmentDirectional(0.0, 1.0),
                        child: Container(
                          width: double.infinity,
                          height: 1050.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Container(
                            width: 100.0,
                            height: 209.0,
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
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      height: 965.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0.0, 12.0, 0.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      0.0, 12.0, 0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      width: 100.0,
                                                      height: 100.0,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                      child: Card(
                                                        clipBehavior: Clip
                                                            .antiAliasWithSaveLayer,
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      0.0),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  12.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Expanded(
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                            0.0,
                                                                            8.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              149.0,
                                                                          height:
                                                                              73.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryBackground,
                                                                          ),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              Expanded(
                                                                                child: Card(
                                                                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                  elevation: 12.0,
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                  ),
                                                                                  child: FlutterFlowDropDown<String>(
                                                                                    controller: _model.dropDownValueController1 ??= FormFieldController<String>(null),
                                                                                    options: listaCursosDocente.map<String>((curso) => curso["nombre_curso"] + ' | ' + curso["materia"] as String).toList(),
                                                                                    onChanged: (String? val) {
                                                                                      setState(() => _model.dropDownValue1 = val);
                                                                                      cursoSeleccionado = val!;
                                                                                      int idCurso = obtenerIdCurso(cursoSeleccionado);
                                                                                      int idMateria = obtenerIdMateria(materiaSeleccionada);
                                                                                      _fetchEstudiantesData(idMateria, idCurso);

                                                                                      print(listaEstudiantesMC);
                                                                                    },
                                                                                    width: 292.0,
                                                                                    height: 53.0,
                                                                                    textStyle: FlutterFlowTheme.of(context).bodyMedium,
                                                                                    hintText: 'Materia',
                                                                                    icon: Icon(
                                                                                      Icons.date_range_sharp,
                                                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                                                      size: 24.0,
                                                                                    ),
                                                                                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                    elevation: 2.0,
                                                                                    borderColor: FlutterFlowTheme.of(context).alternate,
                                                                                    borderWidth: 2.0,
                                                                                    borderRadius: 8.0,
                                                                                    margin: const EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
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
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      0.0, 12.0, 0.0, 0.0),
                                              child: Container(
                                                width: double.infinity,
                                                height: 84.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Card(
                                                      clipBehavior: Clip
                                                          .antiAliasWithSaveLayer,
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      elevation: 12.0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      child:
                                                          FlutterFlowDropDown<
                                                              String>(
                                                        controller: _model
                                                                .dropDownValueController3 ??=
                                                            FormFieldController<
                                                                String>(null),
                                                        options: listaEstudiantesMC
                                                            .map<String>((estudiante) =>
                                                                estudiante['id']
                                                                        .toString() +
                                                                    estudiante[
                                                                        'Nombre_Estudiante'] as String)
                                                            .toList(),
                                                        onChanged:
                                                            (String? val) {
                                                          setState(() => _model
                                                                  .dropDownValue2 =
                                                              val);
                                                          estudianteSeleccionado =
                                                              val!;
                                                        },
                                                        width: 365.0,
                                                        height: 61.0,
                                                        searchHintTextStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium,
                                                        searchTextStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium,
                                                        hintText:
                                                            'Lista Estudiantes',
                                                        searchHintText:
                                                            'Lista Estudiantes',
                                                        icon: Icon(
                                                          Icons.arrow_drop_down,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          size: 24.0,
                                                        ),
                                                        fillColor: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        elevation: 2.0,
                                                        borderColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                        borderWidth: 2.0,
                                                        borderRadius: 8.0,
                                                        margin:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(16.0,
                                                                4.0, 16.0, 4.0),
                                                        hidesUnderline: true,
                                                        isOverButton: true,
                                                        isSearchable: true,
                                                        isMultiSelect: false,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      0.0, 12.0, 0.0, 0.0),
                                              child: Container(
                                                width: 320.0,
                                                height: 73.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Expanded(
                                                          child: Card(
                                                            clipBehavior: Clip
                                                                .antiAliasWithSaveLayer,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            elevation: 12.0,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          14.0),
                                                            ),
                                                            child:
                                                                FFButtonWidget(
                                                              onPressed: () {
                                                                int idEstudiante =
                                                                    obtenerIdEstudiante(
                                                                        estudianteSeleccionado);
                                                                int idMateria =
                                                                    obtenerIdMateria(
                                                                        materiaSeleccionada);
                                                                int idCurso =
                                                                    obtenerIdCurso(
                                                                        cursoSeleccionado);

                                                                _fetchObservaciones(
                                                                    idEstudiante,
                                                                    idMateria,
                                                                    idCurso);
                                                              },
                                                              text:
                                                                  'Generar Lista',
                                                              options:
                                                                  FFButtonOptions(
                                                                height: 40.0,
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                                iconPadding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                                color: const Color(
                                                                    0xFF57E84E),
                                                                textStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          'Readex Pro',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                    ),
                                                                elevation: 3.0,
                                                                borderSide:
                                                                    const BorderSide(
                                                                  color: Colors
                                                                      .transparent,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment:
                                                  const AlignmentDirectional(
                                                      0.0, 0.0),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0.0, 0.0, 0.0, 0.0),
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 62.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        const AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Card(
                                                      clipBehavior: Clip
                                                          .antiAliasWithSaveLayer,
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      elevation: 4.0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      child: Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Text(
                                                          'Lista De Observaciones Estudiante',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Readex Pro',
                                                                fontSize: 20.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
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
                                                      DataColumn(
                                                          label:
                                                              Text('Nombres')),
                                                      DataColumn(
                                                          label:
                                                              Text('Opciones')),
                                                    ],
                                                    rows:
                                                        listaObservacionesEstudiante
                                                            .map((item) {
                                                      return DataRow(
                                                        cells: [
                                                          DataCell(Text(item[
                                                              'Descripcion'])),
                                                          DataCell(
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    int miIdObservacion = item['id'];
                                                                    int miAsistencia = item['id_asistencia'];
                                                                    String miDescripcion = item['Descripcion'];
                                                                    Navigator.of(
                                                                            context)
                                                                        .push(MaterialPageRoute<Null>(builder:
                                                                            (BuildContext
                                                                                context) {
                                                                      return EditarObservacionWidget(
                                                                          miIdObservacion: miIdObservacion,
                                                                          miAsistencia : miAsistencia,
                                                                          miDescripcion: miDescripcion);
                                                                    }));
                                                                  },
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/lapiz__2_-removebg-preview.png',
                                                                    width: 38.0,
                                                                    height:
                                                                        40.0,
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width:
                                                                        10), // Espacio entre los botones
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    var confirmDialogResponse =
                                                                        await showDialog<bool>(
                                                                              context: context,
                                                                              builder: (alertDialogContext) {
                                                                                return AlertDialog(
                                                                                  title: const Text('Eliminar Observación'),
                                                                                  content: const Text('¿Está seguro de eliminar la observación del estudiante?'),
                                                                                  actions: [
                                                                                    TextButton(
                                                                                      onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                      child: const Text('Cancelar'),
                                                                                    ),
                                                                                    TextButton(
                                                                                      onPressed: () {
                                                                                        int id_observacion = item["id"];
                                                                                        eliminarObservacion(id_observacion);
                                                                                        Navigator.pop(alertDialogContext, true);
                                                                                      },
                                                                                      child: const Text('Confirmar'),
                                                                                    ),
                                                                                  ],
                                                                                );
                                                                              },
                                                                            ) ??
                                                                            false;
                                                                  },
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/delete_5610967.png',
                                                                    width: 38.0,
                                                                    height:
                                                                        40.0,
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
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
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ].divide(const SizedBox(height: 30.0)),
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
                        model: _model.menuModel,
                        updateCallback: () => setState(() {}),
                        child: const MenuWidget(),
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
