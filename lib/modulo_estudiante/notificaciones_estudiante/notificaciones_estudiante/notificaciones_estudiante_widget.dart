import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/modulo_estudiante/submenu_estudiantes/menu_estudiantes/menu_estudiantes_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'notificaciones_estudiante_model.dart';
export 'notificaciones_estudiante_model.dart';
import '/backend/api_requests/api_calls.dart';


class NotificacionesEstudianteWidget extends StatefulWidget {
  const NotificacionesEstudianteWidget({super.key});

  @override
  State<NotificacionesEstudianteWidget> createState() =>
      _NotificacionesEstudianteWidgetState();
}

class _NotificacionesEstudianteWidgetState
    extends State<NotificacionesEstudianteWidget>
    with TickerProviderStateMixin {
  late NotificacionesEstudianteModel _model;
   List<dynamic> listaNotificaciones = [];

  Future<void> _fetchNotificationsData() async {
    ApiNotificationsCall apiCall = ApiNotificationsCall();

    List<dynamic> data = await apiCall.fetchNotifications();
    setState(() {
      listaNotificaciones = data;
      print(listaNotificaciones);
    });
  }

  Future<void> _deleteNotification(int pIdNotification) async {
    ApiNotificationsCall apiCall = ApiNotificationsCall();

    String data = await apiCall.deleteNotifications(pIdNotification);

    List<dynamic> dataNotifications = await apiCall.fetchNotifications();
    setState(() {
      listaNotificaciones = dataNotifications;
    });
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _fetchNotificationsData();
    _model = createModel(context, () => NotificacionesEstudianteModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
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
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: 135.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: SvgPicture.asset(
                    'assets/images/Reporte_(8).svg',
                    width: 300.0,
                    height: 154.0,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 140.0, 0.0, 0.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: 2000.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(1.0, 0.0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 8.0, 10.0, 0.0),
                            child: Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                child: Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  elevation: 12.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: SvgPicture.asset(
                                      'assets/images/Diseo_sin_ttulo_(6).svg',
                                      width: 300.0,
                                      height: 200.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: 10.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Column(
                              children: [
                                Align(
                                  alignment: const Alignment(-1.0, 0),
                                  child: TabBar(
                                    isScrollable: true,
                                    labelColor: const Color(0xFF14181B),
                                    unselectedLabelColor: const Color(0xFF57636C),
                                    labelPadding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            24.0, 0.0, 24.0, 0.0),
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: const Color(0xFF14181B),
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                    unselectedLabelStyle: const TextStyle(),
                                    indicatorColor: const Color(0xFFFAD02C),
                                    indicatorWeight: 4.0,
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 0.0, 4.0),
                                    tabs: const [
                                      Tab(
                                        text: 'Nuevas',
                                      ),
                                      Tab(
                                        text: 'Todas',
                                      ),
                                    ],
                                    controller: _model.tabBarController,
                                    onTap: (i) async {
                                      [() async {}, () async {}][i]();
                                    },
                                  ),
                                ),
Expanded(
                                  child: TabBarView(
                                    controller: _model.tabBarController,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(0.0),
                                          bottomRight: Radius.circular(0.0),
                                          topLeft: Radius.circular(0.0),
                                          topRight: Radius.circular(0.0),
                                        ),
                                        child: Container(
                                          width: 100.0,
                                          height: 120.0,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(0.0),
                                              bottomRight: Radius.circular(0.0),
                                              topLeft: Radius.circular(0.0),
                                              topRight: Radius.circular(0.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(0.0),
                                          bottomRight: Radius.circular(0.0),
                                          topLeft: Radius.circular(0.0),
                                          topRight: Radius.circular(0.0),
                                        ),
                                        child: Container(
                                            width: 100.0,
                                            height: 100.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(0.0),
                                                bottomRight:
                                                    Radius.circular(0.0),
                                                topLeft: Radius.circular(0.0),
                                                topRight: Radius.circular(0.0),
                                              ),
                                            ),
                                            child: DataTable(
                                              columns: const [
                                                DataColumn(label: Text('')),
                                                DataColumn(label: Text('')),
                                              ],
                                              rows: listaNotificaciones
                                                  .map((notification) {
                                                return DataRow(
                                                  cells: [
                                                    DataCell(Text(notification[
                                                        'message'])),
                                                    DataCell(
                                                      IconButton(
                                                          icon: Icon(Icons
                                                              .disabled_by_default),
                                                          iconSize: 30,
                                                          color: Colors.red,
                                                          onPressed: () {
                                                            _deleteNotification(
                                                                notification[
                                                                    'id']);
                                                            setState(() {
                                                              ApiNotificationsCall
                                                                  miApi =
                                                                  ApiNotificationsCall();
                                                              List<dynamic>
                                                                  data =
                                                                  miApi.fetchNotifications()
                                                                      as List;
                                                              listaNotificaciones =
                                                                  data;
                                                            });
                                                          }),
                                                    ),
                                                  ],
                                                );
                                              }).toList(),
                                            )),
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
                ],
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
