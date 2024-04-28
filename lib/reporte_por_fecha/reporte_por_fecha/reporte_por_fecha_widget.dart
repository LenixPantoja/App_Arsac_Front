import 'dart:io';

import 'package:arsac_app/reporte_diario/reporte_diario/PDFGeneratorDiario%20copy.dart';
import 'package:path_provider/path_provider.dart';

import '/componentes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'reporte_por_fecha_model.dart';
export 'reporte_por_fecha_model.dart';
import '/backend/api_requests/api_calls.dart';
import 'package:intl/intl.dart';

class ReportePorFechaWidget extends StatefulWidget {
  const ReportePorFechaWidget({super.key});

  @override
  State<ReportePorFechaWidget> createState() => _ReportePorFechaWidgetState();
}

class _ReportePorFechaWidgetState extends State<ReportePorFechaWidget> {
    late DateTime selectedDateDesde = DateTime.now();
    String FechaDesdeFormateada = "";
    late DateTime selectedDateHasta = DateTime.now();
    String FechaHastaFormateada = "";
    // Lista para almacenar las materias que dicta el docente
    List<dynamic> listaMateriasDocente = [];
    // Lista para almacenar los cursos a los cuales dicta clases el docente
    List<dynamic> listaCursosDocente = [];
    //Lista para almacenar el reporte por curso
    List<dynamic> listaReporteCursos = [];
    // Guarda el nombre del curso seleccionado por el usuario
    String cursoSeleccionado = "";
    // Guarda el nombre de la materia seleccionada por el usuario
    String materiaSeleccionada = "";
    // Guarda el usuario del docente
    String usuarioDocente = "";

    Future<void> _selectDateDesde(BuildContext context) async {
      String soloFecha = "";
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDateDesde,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (picked != null && picked != selectedDateDesde) {
        final DateTime selectedDate =
            DateTime(picked.year, picked.month, picked.day);
        String fecha = selectedDate.toString();
        List<String> miLista = [];
        miLista.add(fecha);

        for (int i = 0; i < miLista.length; i++) {
          String fechaCompleta = miLista[i];
          soloFecha =
              fechaCompleta.split(' ')[0]; // Toma solo la parte de la fecha
          // Esto imprimirá solo la fecha, por ejemplo: 2024-04-17
        }

        setState(() {
          selectedDateDesde = selectedDate;
          FechaDesdeFormateada = soloFecha;
          print(FechaDesdeFormateada);
        });
      }
    }

    Future<void> _selectDateHasta(BuildContext context) async {
      String soloFecha = "";
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDateHasta,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (picked != null && picked != selectedDateHasta) {
        final DateTime selectedDate =
            DateTime(picked.year, picked.month, picked.day);
        String fecha = selectedDate.toString();
        List<String> miLista = [];
        miLista.add(fecha);

        for (int i = 0; i < miLista.length; i++) {
          String fechaCompleta = miLista[i];
          soloFecha =
              fechaCompleta.split(' ')[0]; // Toma solo la parte de la fecha
          // Esto imprimirá solo la fecha, por ejemplo: 2024-04-17
        }

        setState(() {
          selectedDateHasta = selectedDate;
          FechaHastaFormateada = soloFecha;
          print(FechaHastaFormateada);
        });
      }
    }

    Future<void> _fetchReportePorCursos(int pCurso, int pMateria, String pRango1,
        String pRango2, String pUser) async {
      ApiReporteFechasPorCursoCall apiCall = ApiReporteFechasPorCursoCall();

      List<dynamic> data = await apiCall.fetchReportePorCurso(
          pCurso, pMateria, pRango1, pRango2, pUser);
      setState(() {
        listaReporteCursos = data;
        print(listaReporteCursos);
        if (listaReporteCursos.isEmpty) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("!Ups!"),
                content: Text("No hay datos para generar el reporte."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Aceptar"),
                  ),
                ],
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("!Éxito!"),
                content: Text("El reporte esta listo para genera."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Aceptar"),
                  ),
                ],
              );
            },
          );
        }
      });
    }

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

  late ReportePorFechaModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _fetchMateriasData();
    _fetchCursosData();
    selectedDateDesde = DateTime.now();
    selectedDateHasta = DateTime.now();
    Usuario miUser = Usuario();
    usuarioDocente = miUser.nombreUsuario;
    _model = createModel(context, () => ReportePorFechaModel());
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
                  height: 116.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: SvgPicture.asset(
                      'assets/images/Reporte_(23).svg',
                      width: 300.0,
                      height: 200.0,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 65.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          elevation: 12.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Align(
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            child: Text(
                              'Seleccione Por Curso',
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
                    ],
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0.0, 1.0),
                  child: Container(
                    width: double.infinity,
                    height: 644.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Container(
                      width: 100.0,
                      height: 100.0,
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
                        child: SingleChildScrollView(
                          primary: false,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 276.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 12.0, 0.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        alignment: const AlignmentDirectional(
                                            0.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Align(
                                                alignment:
                                                    const AlignmentDirectional(
                                                        0.0, 0.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Container(
                                                      width: 149.0,
                                                      height: 73.0,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
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
                                                                            8.0),
                                                              ),
                                                              child:
                                                                  FFButtonWidget(
                                                                onPressed: () {
                                                                  _selectDateDesde(
                                                                      context);
                                                                },
                                                                text: 'Desde',
                                                                icon:
                                                                    const Icon(
                                                                  Icons
                                                                      .calendar_month,
                                                                  size: 30.0,
                                                                ),
                                                                options:
                                                                    FFButtonOptions(
                                                                  height: 40.0,
                                                                  padding:
                                                                      const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                          24.0,
                                                                          0.0,
                                                                          24.0,
                                                                          0.0),
                                                                  iconPadding:
                                                                      const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  textStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        fontFamily:
                                                                            'Readex Pro',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                  elevation:
                                                                      3.0,
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
                                                    ),
                                                    Container(
                                                      width: 149.0,
                                                      height: 73.0,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
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
                                                                            8.0),
                                                              ),
                                                              child:
                                                                  FFButtonWidget(
                                                                onPressed: () {
                                                                  _selectDateHasta(
                                                                      context);
                                                                },
                                                                text: 'Hasta',
                                                                icon:
                                                                    const Icon(
                                                                  Icons
                                                                      .calendar_month,
                                                                  size: 30.0,
                                                                ),
                                                                options:
                                                                    FFButtonOptions(
                                                                  height: 40.0,
                                                                  padding:
                                                                      const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                          24.0,
                                                                          0.0,
                                                                          24.0,
                                                                          0.0),
                                                                  iconPadding:
                                                                      const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  textStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        fontFamily:
                                                                            'Readex Pro',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                  elevation:
                                                                      3.0,
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
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0.0, 12.0, 0.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Container(
                                                    width: 350.0,
                                                    height: 73.0,
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
                                                                .dropDownValueController ??=
                                                            FormFieldController<
                                                                String>(null),
                                                        options: listaCursosDocente
                                                            .map<String>((curso) =>
                                                                curso["nombre_curso"] +
                                                                        ' | ' +
                                                                        curso[
                                                                            "materia"]
                                                                    as String)
                                                            .toList(),
                                                        onChanged:
                                                            (String? val) {
                                                          setState(() => _model
                                                                  .dropDownValue =
                                                              val);
                                                          cursoSeleccionado =
                                                              val!;
                                                          int idCurso =
                                                              obtenerIdCurso(
                                                                  cursoSeleccionado);
                                                          int idMateria =
                                                              obtenerIdMateria(
                                                                  materiaSeleccionada);
                                                        },
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                        hintText: 'Materias',
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
                                                        isSearchable: false,
                                                        isMultiSelect: false,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0.0, 12.0, 0.0, 0.0),
                                        child: Container(
                                          width: 150.0,
                                          height: 50.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                          ),
                                          child: Card(
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            elevation: 12.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14.0),
                                            ),
                                            child: FFButtonWidget(
                                              onPressed: () {
                                                int id_curso = obtenerIdCurso(
                                                    cursoSeleccionado);
                                                int id_materia =
                                                    obtenerIdMateria(
                                                        materiaSeleccionada);
                                                _fetchReportePorCursos(
                                                    id_curso,
                                                    id_materia,
                                                    FechaDesdeFormateada,
                                                    FechaHastaFormateada,
                                                    usuarioDocente);

                                                print(listaReporteCursos);
                                              },
                                              text: 'Buscar',
                                              icon: FaIcon(
                                                FontAwesomeIcons.search,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                size: 20.0,
                                              ),
                                              options: FFButtonOptions(
                                                height: 40.0,
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        24.0, 0.0, 24.0, 0.0),
                                                iconPadding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0.0, 0.0, 0.0, 0.0),
                                                color: const Color(0xFFFFD70B),
                                                textStyle: FlutterFlowTheme.of(
                                                        context)
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
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: const AlignmentDirectional(0.0, 1.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 200.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Align(
                                    alignment:
                                        const AlignmentDirectional(0.0, 1.0),
                                    child: Container(
                                      width: double.infinity,
                                      height: 154.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                    0.0, 1.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                FlutterFlowIconButton(
                                                  borderColor:
                                                      const Color(0xFFFBFAFF),
                                                  borderRadius: 122.0,
                                                  borderWidth: 1.0,
                                                  buttonSize: 80.0,
                                                  fillColor:
                                                      const Color(0xE0EA0B1A),
                                                  icon: Icon(
                                                    Icons
                                                        .picture_as_pdf_rounded,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    size: 50.0,
                                                  ),
                                                  onPressed: () async {
                                                    // Obteniendo la fecha y hora actual
                                                    int id_curso =
                                                        obtenerIdCurso(
                                                            cursoSeleccionado);
                                                    int id_materia =
                                                        obtenerIdMateria(
                                                            materiaSeleccionada);
                                                    ApiReporteFechasPorCursoCallPdf
                                                        reporteData =
                                                        ApiReporteFechasPorCursoCallPdf();
                                                    List<dynamic> reporte =
                                                        await reporteData
                                                            .fetchReporteFechasPorDiario(
                                                                id_curso,
                                                                id_materia,
                                                                FechaDesdeFormateada,
                                                                FechaHastaFormateada,
                                                                usuarioDocente);
                                                    await _savePDFToFile(
                                                        reporte
                                                            .map(
                                                                (e) => e as int)
                                                            .toList(),
                                                        'Reporte $materiaSeleccionada $cursoSeleccionado $FechaDesdeFormateada | $FechaHastaFormateada');
                                                  },
                                                ),
                                                FlutterFlowIconButton(
                                                  borderColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                  borderRadius: 122.0,
                                                  borderWidth: 1.0,
                                                  buttonSize: 80.0,
                                                  fillColor:
                                                      const Color(0xC626E11B),
                                                  icon: Icon(
                                                    Icons.explicit,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    size: 50.0,
                                                  ),
                                                  onPressed: () async {
                                                    int id_curso =
                                                        obtenerIdCurso(
                                                            cursoSeleccionado);
                                                    int id_materia =
                                                        obtenerIdMateria(
                                                            materiaSeleccionada);
                                                    String url =
                                                        'https://06e8-8-242-169-8.ngrok-free.app/api/reportePorCursoXLSX?pMateria=$id_materia&pCurso=$id_curso&pRango1=$FechaDesdeFormateada&pRango2=$FechaHastaFormateada&pUser=$usuarioDocente';
                                                    print(url);

                                                    await launchURL(
                                                        'https://06e8-8-242-169-8.ngrok-free.app/api/reportePorCursoXLSX?pMateria=$id_materia&pCurso=$id_curso&pRango1=$FechaDesdeFormateada&pRango2=$FechaHastaFormateada&pUser=$usuarioDocente');
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                'Descargar PDF',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                              ),
                                              Text(
                                                'Descargar Excel',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                              ),
                                            ],
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
                      ),
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
              Align(
                alignment: const AlignmentDirectional(0.0, 1.0),
                child: Container(
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
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Funcion para descargar el pdf
  Future<void> _savePDFToFile(List<int> pdfBytes, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName.pdf');
    await file.writeAsBytes(pdfBytes);
    print('PDF guardado en: ${file.path}');

    // Mostrar alerta
    await showDialog(
      context: context,
      builder: (alertDialogContext) {
        return AlertDialog(
          title: Text('Éxito'),
          content: Text('Se ha generado el PDF correctamente ✅.'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(alertDialogContext);
                  // Abrir el PDF después de mostrar la alerta
                  _openPDF(file.path);
                },
                child: Text(
                  'Continuar',
                  style: TextStyle(color: Color(0xFC16397E)),
                )),
          ],
        );
      },
    );
  }

  void _openPDF(String filePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFGeneratorDiario(pdfPath: filePath),
      ),
    );
  }
}
