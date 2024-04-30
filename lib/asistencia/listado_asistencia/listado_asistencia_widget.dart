import '/componentes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'listado_asistencia_model.dart';
export 'listado_asistencia_model.dart';
import '/backend/api_requests/api_calls.dart';

class ListadoAsistenciaWidget extends StatefulWidget {
  const ListadoAsistenciaWidget({super.key});

  @override
  State<ListadoAsistenciaWidget> createState() =>
      _ListadoAsistenciaWidgetState();
}

class _ListadoAsistenciaWidgetState extends State<ListadoAsistenciaWidget> {
  late ListadoAsistenciaModel _model;

  String user = "";
  List<dynamic> listaAsistencia = [];

  Future<void> _fetchAsistencia(String pUser) async {
    ApiAsistenciaEstudianteCall apiCall = ApiAsistenciaEstudianteCall();

    List<dynamic> data = await apiCall.getListaAsistenciaDocente(pUser);
    setState(() {
      listaAsistencia = data;
    });
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Usuario miUser = Usuario();
    user = miUser.nombreUsuario;
    _fetchAsistencia(user);
    _model = createModel(context, () => ListadoAsistenciaModel());
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
                                'Listado Asistencia',
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
                        child: SingleChildScrollView(
                          physics:
                              const AlwaysScrollableScrollPhysics(), // Ajustar al contenido disponible
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('Tipo de Asistencia')),
                              DataColumn(label: Text('Curso')),
                              DataColumn(label: Text('Hora')),
                              DataColumn(label: Text('Materia')),
                              DataColumn(label: Text('Estudiante')),
                            ],
                            rows: listaAsistencia.map((item) {
                              return DataRow(
                                cells: [
                                  DataCell(Text(item['Tipo_asistencia'])),
                                  DataCell(Text(item['Curso'])),
                                  DataCell(Text(item['Hora_llegada'])),
                                  DataCell(Text(item['Materia'])),
                                  DataCell(Text(item['Estudiante'])),
                                ],
                              );
                            }).toList(),
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
