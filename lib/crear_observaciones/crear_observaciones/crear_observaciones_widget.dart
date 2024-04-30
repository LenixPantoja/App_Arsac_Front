import '/componentes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'crear_observaciones_model.dart';
export 'crear_observaciones_model.dart';
import '/backend/api_requests/api_calls.dart';

class CrearObservacionesWidget extends StatefulWidget {
  const CrearObservacionesWidget({super.key});

  @override
  State<CrearObservacionesWidget> createState() =>
      _CrearObservacionesWidgetState();
}

class _CrearObservacionesWidgetState extends State<CrearObservacionesWidget> {
  late CrearObservacionesModel _model;
  // Lista para almacenar las materias que dicta el docente
  List<dynamic> listaMateriasDocente = [];
  // Lista para almacenar los cursos a los cuales dicta clases el docente
  List<dynamic> listaCursosDocente = [];
  // Lista para almacenar los estudiantes matriucados a una materia y a un curso
  List<dynamic> listaEstudiantesMC = [];
  // Lista para almacenar los estudiantes que dicta el alumno
  List<dynamic> listaAsistenciaEstudiante = [];
  // Guarda el nombre de la asistencia o data relacionada
  String asistenciaSeleccionada = "";
  // Guarda el nombre del curso seleccionado por el usuario
  String cursoSeleccionado = "";
  // Guarda el nombre de la materia seleccionada por el usuario
  String materiaSeleccionada = "";
  // Guarda el estudiante seleccionado por el usuario
  String estudianteSeleccionado = "";

  // DATOS PARA MOSTRAR EN DATA ASISTENCIA
  String dataTipoAsistencia = "";
  String dataHoraLlegada = "";
  String dataCurso = "";
  String dataMateria = "";
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
    });
  }

  Future<void> _fetchAsistencia(
      int pIdEstudiante, int pIdMateria, int pIdCurso) async {
    ApiAsistenciaEstudianteCall apiCall = ApiAsistenciaEstudianteCall();

    List<dynamic> data =
        (await apiCall.getAsistencia(pIdEstudiante, pIdMateria, pIdCurso));
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
    String nombreMateria = "";
    for (int i = 0; i < listaMateriasDocente.length; i++) {
      if (listaMateriasDocente[i]["Materia"] == pMateria) {
        idMateria = listaMateriasDocente[i]["id"];
        nombreMateria = listaMateriasDocente[i]["Materia"];
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

  int obtenerIdAsistencia(String pAsistencia) {
    int idAsistencia = 0;
    for (int i = 0; i < listaAsistenciaEstudiante.length; i++) {
      String nombreAsistencia = listaAsistenciaEstudiante[i]['id'].toString() +
          ' ' +
          listaAsistenciaEstudiante[i]['Tipo_asistencia']+" | "+ listaAsistenciaEstudiante[i]['Hora_llegada'];
      dataTipoAsistencia = listaAsistenciaEstudiante[i]['Tipo_asistencia'];
      dataHoraLlegada = listaAsistenciaEstudiante[i]['Hora_llegada'];
      dataMateria = listaAsistenciaEstudiante[i]['Materia'];
      dataCurso = listaAsistenciaEstudiante[i]['Curso'];  

      if (nombreAsistencia == pAsistencia) {
        idAsistencia = listaAsistenciaEstudiante[i]["id"];
      }
    }
    return idAsistencia;
  }

  @override
  void initState() {
    super.initState();
    _fetchMateriasData();
    _fetchCursosData();
    _model = createModel(context, () => CrearObservacionesModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            primary: false,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: double.infinity,
                  height: 130.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0.0),
                    child: SvgPicture.asset(
                      'assets/images/Reporte_(14).svg',
                      width: 300.0,
                      height: 200.0,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(0.0, -1.0),
            child: Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(0.0, 150.0, 0.0, 0.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 0.0, 0.0),
                          child: FlutterFlowDropDown<String>(
                            controller: _model.dropDownValueController1 ??=
                                FormFieldController<String>(null),
                            options: listaCursosDocente
                                .map<String>((curso) => curso["nombre_curso"] +
                                    ' | ' +
                                    curso["materia"] as String)
                                .toList(),
                            onChanged: (String? val) {
                              setState(() => _model.dropDownValue1 = val);
                              cursoSeleccionado = val!;
                              int idCurso = obtenerIdCurso(cursoSeleccionado);
                              int idMateria =
                                  obtenerIdMateria(materiaSeleccionada);
                              _fetchEstudiantesData(idMateria, idCurso);

                              print(listaEstudiantesMC);
                            },
                            width: 300.0,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0.0,
                                ),
                            hintText: 'Seleccione Curso y materia',
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            elevation: 2.0,
                            borderColor: FlutterFlowTheme.of(context).alternate,
                            borderWidth: 2.0,
                            borderRadius: 8.0,
                            margin: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 4.0, 16.0, 4.0),
                            hidesUnderline: true,
                            isOverButton: true,
                            isSearchable: false,
                            isMultiSelect: false,
                            labelText: ' Curso y materia',
                            labelTextStyle: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 20.0, 0.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              'assets/images/grifo_(1).png',
                              width: 50.0,
                              height: 50.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 10.0, 0.0, 0.0),
                          child: FlutterFlowDropDown<String>(
                            controller: _model.dropDownValueController3 ??=
                                FormFieldController<String>(null),
                            options: listaEstudiantesMC
                                .map<String>((estudiante) => estudiante['id']
                                        .toString() +
                                    estudiante['Nombre_Estudiante'] as String)
                                .toList(),
                            onChanged: (String? val) {
                              setState(() => _model.dropDownValue3 = val);
                              estudianteSeleccionado = val!;
                              int idEstudiante =
                                  obtenerIdEstudiante(estudianteSeleccionado);
                              int idMateria =
                                  obtenerIdMateria(materiaSeleccionada);
                              int idCurso = obtenerIdCurso(cursoSeleccionado);

                              _fetchAsistencia(
                                  idEstudiante, idMateria, idCurso);
                            },
                            width: 300.0,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0.0,
                                ),
                            hintText: 'Seleccione Estudiante',
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            elevation: 2.0,
                            borderColor: FlutterFlowTheme.of(context).alternate,
                            borderWidth: 2.0,
                            borderRadius: 8.0,
                            margin: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 4.0, 16.0, 4.0),
                            hidesUnderline: true,
                            isOverButton: true,
                            isSearchable: false,
                            isMultiSelect: false,
                            labelText: 'Estudiante',
                            labelTextStyle: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 20.0, 0.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              'assets/images/estudiante.png',
                              width: 50.0,
                              height: 50.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 10.0, 0.0, 0.0),
                          child: FlutterFlowDropDown<String>(
                            controller: _model.dropDownValueController4 ??=
                                FormFieldController<String>(null),
                            options: listaAsistenciaEstudiante
                                .map<String>((asistencia) =>
                                    asistencia['id'].toString() +
                                        ' ' +
                                        asistencia['Tipo_asistencia'] +" | "+ asistencia['Hora_llegada'] as String)
                                .toList(),
                            onChanged: (String? val) {
                              setState(() => _model.dropDownValue4 = val);
                              asistenciaSeleccionada = val!;

                              obtenerIdAsistencia(asistenciaSeleccionada);
                            },
                            width: 300.0,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0.0,
                                ),
                            hintText: 'Seleccione Asistencia',
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            elevation: 2.0,
                            borderColor: FlutterFlowTheme.of(context).alternate,
                            borderWidth: 2.0,
                            borderRadius: 8.0,
                            margin: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 4.0, 16.0, 4.0),
                            hidesUnderline: true,
                            isOverButton: true,
                            isSearchable: false,
                            isMultiSelect: false,
                            labelText: 'Asistencia',
                            labelTextStyle: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 20.0, 0.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              'assets/images/estudiante.png',
                              width: 50.0,
                              height: 50.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: const AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 10.0, 0.0, 0.0),
                        child: Text(
                          'Datos asistencia',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          5.0, 0.0, 5.0, 0.0),
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Tipo asistencia: ',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 17.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  dataTipoAsistencia,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 15.0,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Hora llegada: ',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 17.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  dataHoraLlegada,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 15.0,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Curso: ',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 17.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  dataCurso,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 15.0,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Materia: ',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 17.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  dataMateria,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 15.0,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          10.0, 10.0, 10.0, 0.0),
                      child: TextFormField(
                        controller: _model.textController,
                        focusNode: _model.textFieldFocusNode,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Ingrese observación:',
                          labelStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.black,
                                    letterSpacing: 0.0,
                                  ),
                          hintStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFFFAD02C),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFFFAD02C),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              fontSize: 18.0,
                              letterSpacing: 0.0,
                            ),
                        maxLines: 16,
                        minLines: 1,
                        validator:
                            _model.textControllerValidator.asValidator(context),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 60.0, 0.0, 0.0),
                      child: Container(
                        width: double.infinity,
                        height: 63.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          elevation: 12.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    int id_asistencia = obtenerIdAsistencia(
                                        asistenciaSeleccionada);
                                    _model.apiResultnmd = await ApiArsacGroup
                                        .apiObservacionesEstudianteCall
                                        .callObservaciones(
                                            asistenciaEst: id_asistencia,
                                            observacionEst:
                                                _model.textController.text
                                                );

                                    if ((_model.apiResultnmd?.succeeded ??
                                        true)) {
                                      await showDialog(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: const Text('CORRECTO'),
                                            content: Text(
                                                'Se registró la observación del estudiante $estudianteSeleccionado'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext),
                                                child: const Text('Ok'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      print("errorrrrrrr");
                                    }
                                  },
                                  text: 'Guardar',
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: 40.0,
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            24.0, 0.0, 24.0, 0.0),
                                    iconPadding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                    color: const Color(0xFFFAD02C),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                        ),
                                    elevation: 3.0,
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
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
        ],
      ),
    );
  }
}
