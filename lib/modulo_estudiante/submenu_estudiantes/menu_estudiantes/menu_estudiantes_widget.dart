import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'menu_estudiantes_model.dart';
export 'menu_estudiantes_model.dart';

class MenuEstudiantesWidget extends StatefulWidget {
  const MenuEstudiantesWidget({super.key});

  @override
  State<MenuEstudiantesWidget> createState() => _MenuEstudiantesWidgetState();
}

class _MenuEstudiantesWidgetState extends State<MenuEstudiantesWidget> {
  late MenuEstudiantesModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MenuEstudiantesModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100.0,
      decoration: const BoxDecoration(
        color: Color(0xFFFAD02C),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                context.pushNamed('InicioEstudiante');
              },
              child: const Icon(
                Icons.home,
                color: Color(0xFF293035),
                size: 32.0,
              ),
            ),
          ),
          InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              context.pushNamed(
                'NotificacionesEstudiante',
                extra: <String, dynamic>{
                  kTransitionInfoKey: const TransitionInfo(
                    hasTransition: true,
                    transitionType: PageTransitionType.topToBottom,
                    duration: Duration(milliseconds: 300),
                  ),
                },
              );
            },
            child: const Icon(
              Icons.notifications,
              color: Color(0xFF293035),
              size: 43.0,
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 20.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                context.pushNamed('profileEstudiante');
              },
              child: const Icon(
                Icons.person,
                color: Color(0xFF293035),
                size: 45.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
