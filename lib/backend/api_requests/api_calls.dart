// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:arsac_app/flutter_flow/flutter_flow_util.dart';
import 'package:http/http.dart' as http;

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

String username = "";
String token = "";
String identificacionDocente = "";

/// Start ApiArsac Group Code
class Usuario {
  String nombreUsuario = username;
  String tokenUsuario = token;
  String cedulaDocente = identificacionDocente;

  String getNombreUsuario() {
    return nombreUsuario;
  }

  String getTokenUsuario() {
    return tokenUsuario;
  }

  String getIdentificacionDocente() {
    return cedulaDocente;
  }
}

class matricula {
  int idMatricula = 0;

  int getIdMatricula() {
    return idMatricula;
  }
}

class ApiArsacGroup {
  static String baseUrl = 'https://b087-38-51-243-37.ngrok-free.app/';
  static Map<String, String> headers = {};
  static ApiLoginCall apiLoginCall = ApiLoginCall();
  static ApiGetUserCall apiGetUserCall = ApiGetUserCall();
  static ApiMateriaCursoEstudianteCall apiMateriaCursoEstudianteCall =
      ApiMateriaCursoEstudianteCall();
  static ApiHorarioDocenteCall apiHorarioDocenteCall = ApiHorarioDocenteCall();
  static ApiCrearPeriodoCall apiCrearPeriodoCall = ApiCrearPeriodoCall();
  static ApiCursoCall apiCrearCursoCall = ApiCursoCall();
  static ApiAsistenciaEstudianteCall apiAsistenciaEstudianteCall =
      ApiAsistenciaEstudianteCall();
  static ApiObservacionesEstudianteCall apiObservacionesEstudianteCall =
      ApiObservacionesEstudianteCall();
  static ApiMateriasPorDocenteCall ApiMateriasDocentes =
      ApiMateriasPorDocenteCall();
}

class ApiLoginCall {
  Future<ApiCallResponse> call({
    String? username = '',
    String? password = '',
  }) async {
    final ffApiRequestBody = '''
{
        "username": "$username",
        "password": "$password"
}   ''';
    final response = await ApiManager.instance.makeApiCall(
      callName: 'ApiLogin',
      apiUrl: '${ApiArsacGroup.baseUrl}api/Login/',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );

    if (response.statusCode == 200) {
      token = response.jsonBody["access"];
      print(token);
    } else {
      print(
          "Error al llamar a la API Login. Código de estado: ${response.statusCode}");
    }
    return response;
  }
}

// Api para obtener el nombre del usuario
class ApiGetUserCall {
  Future<Map<String, dynamic>> fetchUsername() async {
    try {
      final String apiUrl = '${ApiArsacGroup.baseUrl}/api/getUser/';
      final http.Response response = await http
          .get(Uri.parse(apiUrl), headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        username = jsonData["username"];
        return jsonData;
      } else {
        print(
            "Error al llamar a la API. Código de estado: ${response.statusCode}");
        return {};
      }
    } catch (error) {
      print("Error al llamar a la API obtener username: $error");
      return {};
    }
  }
}

class ApiMateriasPorDocenteCall {
  Future<List<dynamic>> fetchMaterias() async {
    try {
      final String apiUrl =
          '${ApiArsacGroup.baseUrl}/api/MateriasDocente/?pUser=$username';

      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        // Check if the response body is not empty
        if (response.body.isNotEmpty) {
          List<dynamic> jsonData = json.decode(response.body);
          return jsonData;
        } else {
          // Return an empty list if the response body is empty
          return [];
        }
      } else {
        // Handle non-200 status codes
        print(
            "Error al llamar a la API. Código de estado: ${response.statusCode}");
        return [];
      }
    } catch (error) {
      // Handle other exceptions
      print("Error al llamar a la API materias por Docente: $error");
      return [];
    }
  }
}

class ApiMateriasPorEstudianteCall {
  Future<List<dynamic>> fetchMaterias() async {
    try {
      final String apiUrl =
          '${ApiArsacGroup.baseUrl}/api/MateriasEstudiantes/?pUser=$username';

      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        // Check if the response body is not empty
        if (response.body.isNotEmpty) {
          List<dynamic> jsonData = json.decode(response.body);
          return jsonData;
        } else {
          // Return an empty list if the response body is empty
          return [];
        }
      } else {
        // Handle non-200 status codes
        print(
            "Error al llamar a la API. Código de estado: ${response.statusCode}");
        return [];
      }
    } catch (error) {
      // Handle other exceptions
      print("Error al llamar a la API materias por Docente: $error");
      return [];
    }
  }
}
class ApiCursosEstudiantesCall {
  Future<List<dynamic>> fetchCursos() async {
    try {
      final String apiUrl =
          '${ApiArsacGroup.baseUrl}/api/crearCursoEstudiante/?pUser=$username';

      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        // Check if the response body is not empty
        if (response.body.isNotEmpty) {
          List<dynamic> jsonData = json.decode(response.body);
          return jsonData;
        } else {
          // Return an empty list if the response body is empty
          return [];
        }
      } else {
        // Handle non-200 status codes
        print(
            "Error al llamar a la API. Código de estado: ${response.statusCode}");
        return [];
      }
    } catch (error) {
      // Handle other exceptions
      print("Error al llamar a la API materias por Estudiante: $error");
      return [];
    }
  }
}

class ApiCursoCall {
  Future<List<dynamic>> fetchCursos() async {
    try {
      final String apiUrl =
          '${ApiArsacGroup.baseUrl}/api/crearCurso/?pDocente=$username';

      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        // Check if the response body is not empty
        if (response.body.isNotEmpty) {
          List<dynamic> jsonData = json.decode(response.body);
          return jsonData;
        } else {
          // Return an empty list if the response body is empty
          return [];
        }
      } else {
        // Handle non-200 status codes
        print(
            "Error al llamar a la API. Código de estado: ${response.statusCode}");
        return [];
      }
    } catch (error) {
      // Handle other exceptions
      print("Error al llamar a la API cursos por Docente: $error");
      return [];
    }
  }
}

class ApiMateriaCursoEstudianteCall {
  Future<List<dynamic>> fetchEstudiantes(int pMateria, int pCurso) async {
    try {
      final String apiUrl =
          '${ApiArsacGroup.baseUrl}/api/EstudiantesCursoMaterias?pMateria=$pMateria&pCurso=$pCurso';

      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        // Check if the response body is not empty
        if (response.body.isNotEmpty) {
          List<dynamic> jsonData = json.decode(response.body);
          return jsonData;
        } else {
          // Return an empty list if the response body is empty
          return [];
        }
      } else {
        // Handle non-200 status codes
        print(
            "Error al llamar a la API. Código de estado: ${response.statusCode}");
        return [];
      }
    } catch (error) {
      // Handle other exceptions
      print("Error al llamar a la API estudiante por materia y curso: $error");
      return [];
    }
  }
}

class ApiAsistenciaEstudianteCall {
  Future<ApiCallResponse> callAsistencia(
      {String? tipoAsistencia = '',
      String? descripcion = '',
      String? horaLlegada = '',
      String? soporte,
      String? matriculaEstudiante = ''}) async {
    final Map<String, dynamic> requestBody = {
      "tipo_asistencia": tipoAsistencia,
      "descripcion": descripcion,
      "hora_llegada": horaLlegada,
      "soporte": soporte,
      "matricula_estudiante": matriculaEstudiante
    };
    print("pasa aqui");
    final String ffApiRequestBody = jsonEncode(requestBody);

    final response = await ApiManager.instance.makeApiCall(
      callName: 'ApiLogin',
      apiUrl: '${ApiArsacGroup.baseUrl}api/AsistenciaEstudiante/',
      callType: ApiCallType.POST,
      headers: {'Authorization': 'Bearer $token'},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
    print("antes de pasar por api");
    if (response.statusCode == 200) {
      print("Pasó por api");
      return response;
    } else {
      print(
          "Error al llamar a la API Asistencia Estudiantes. Código de estado: ${response.statusCode}");
    }
    print("no paso a la pai");
    return response;
  }

  Future<List<dynamic>> getAsistencia(
      int pEstudiante, int pMateria, int pCurso) async {
    try {
      final String apiUrl =
          '${ApiArsacGroup.baseUrl}/api/AsistenciaEstudiante/?pIdEstudiante=$pEstudiante&pIdMateria=$pMateria&pIdCurso=$pCurso';

      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );
      print("pEstudiante: $pEstudiante");
      print("pMateria: $pMateria");
      print("pCurso: $pCurso");

      if (response.statusCode == 200) {
        // Check if the response body is not empty
        if (response.body.isNotEmpty) {
          print(response.body);
          List<dynamic> jsonData = json.decode(response.body);
          return jsonData;
        } else {
          print("lista vacia");
          // Return an empty list if the response body is empty
          return [];
        }
      } else {
        // Handle non-200 status codes
        print(
            "Error al llamar a la API. Código de estado: ${response.statusCode}");
        return [];
      }
    } catch (error) {
      // Handle other exceptions
      print("Error al llamar a la API asistencia estudiante: $error");
      return [];
    }
  }

  Future<List<dynamic>> getListaAsistenciaDocente(
      String pUser) async {
    try {
      final String apiUrl =
          '${ApiArsacGroup.baseUrl}/api/AsistenciaEstudiante/?pUser=$pUser';

      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );
      
      if (response.statusCode == 200) {
        // Check if the response body is not empty
        if (response.body.isNotEmpty) {
          print(response.body);
          List<dynamic> jsonData = json.decode(response.body);
          return jsonData;
        } else {
          print("lista vacia");
          // Return an empty list if the response body is empty
          return [];
        }
      } else {
        // Handle non-200 status codes
        print(
            "Error al llamar a la API. Código de estado: ${response.statusCode}");
        return [];
      }
    } catch (error) {
      // Handle other exceptions
      print("Error al llamar a la API asistencia estudiante: $error");
      return [];
    }
  }
}

class ApiObservacionesEstudianteCall {
  Future<ApiCallResponse> callObservaciones({
    int? asistenciaEst,
    String? observacionEst,
  }) async {
    final Map<String, dynamic> requestBody = {
      "asistenciaEst": asistenciaEst,
      "observacionEst": observacionEst,
    };

    final String ffApiRequestBody = jsonEncode(requestBody);

    final response = await ApiManager.instance.makeApiCall(
      callName: 'ApiObservacionesEstudianteCall',
      apiUrl: '${ApiArsacGroup.baseUrl}api/ObservacionesEstudiante/',
      callType: ApiCallType.POST,
      headers: {'Authorization': 'Bearer $token'},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      print(
          "Error al llamar a la API Crear Observaciones. Código de estado: ${response.statusCode}");
    }

    return response;
  }

  Future<List<dynamic>> getObservaciones(
      int pEstudiante, int pMateria, int pCurso) async {
    try {
      final String apiUrl =
          '${ApiArsacGroup.baseUrl}/api/ObservacionesEstudiante/?pIdEstudiante=$pEstudiante&pIdMateria=$pMateria&pIdCurso=$pCurso';

      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        // Check if the response body is not empty
        if (response.body.isNotEmpty) {
          List<dynamic> jsonData = json.decode(response.body);
          return jsonData;
        } else {
          // Return an empty list if the response body is empty
          return [];
        }
      } else {
        // Handle non-200 status codes
        print(
            "Error al llamar a la API. Código de estado: ${response.statusCode}");
        return [];
      }
    } catch (error) {
      // Handle other exceptions
      print("Error al llamar a la API Observaciones por estudiante: $error");
      return [];
    }
  }

  Future<String> deleteObservaciones(int pIdObservaciones) async {
    try {
      final String apiUrl =
          '${ApiArsacGroup.baseUrl}/api/ObservacionesEstudiante/$pIdObservaciones/';

      final http.Response response = await http.delete(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        // Parse the response body
        Map<String, dynamic> responseData = json.decode(response.body);
        // Extract the message from the response data
        String message = responseData['msg'];
        // Return the message
        return message;
      } else {
        // Handle non-200 status codes
        print(
            "Error al llamar a la API. Código de estado: ${response.statusCode}");
        return "Error al eliminar la observación.";
      }
    } catch (error) {
      // Handle other exceptions
      print("Error al eliminar la observacion API: $error");
      return "Error al eliminar la observación.";
    }
  }

  Future<ApiCallResponse> putObservaciones({
    int? pIdObservacion,
    int? asistenciaEst,
    String? observacionEst,
  }) async {
    final Map<String, dynamic> requestBody = {
      "asistenciaEst": asistenciaEst,
      "observacionEst": observacionEst,
    };

    final String ffApiRequestBody = jsonEncode(requestBody);

    final response = await ApiManager.instance.makeApiCall(
      callName: 'ApiObservacionesEstudianteCall',
      apiUrl:
          '${ApiArsacGroup.baseUrl}/api/ObservacionesEstudiante/$pIdObservacion/',
      callType: ApiCallType.PUT,
      headers: {'Authorization': 'Bearer $token'},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      print(
          "Error al llamar a la API Crear Observaciones. Código de estado: ${response.statusCode}");
    }

    return response;
  }
}

class ApiHorarioDocenteCall {
  Future<List<dynamic>> getHorarioDocente(pUserDocente) async {
    try {
      final String apiUrl =
          '${ApiArsacGroup.baseUrl}/api/HorarioDocente/?pUser=$pUserDocente';

      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        // Check if the response body is not empty
        if (response.body.isNotEmpty) {
          List<dynamic> jsonData = json.decode(response.body);
          return jsonData;
        } else {
          // Return an empty list if the response body is empty
          return [];
        }
      } else {
        // Handle non-200 status codes
        print(
            "Error al llamar a la API. Código de estado: ${response.statusCode}");
        return [];
      }
    } catch (error) {
      // Handle other exceptions
      print("Error al llamar a la API horario del docente: $error");
      return [];
    }
  }
}

class ApiCrearPeriodoCall {
  Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'ApiCrearPeriodo',
      apiUrl: '${ApiArsacGroup.baseUrl}api/crearPeriodo/',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiReporteDiarioCall {
  Future<List<dynamic>> fetchReporteDiario(
      String pRango1, String pRango2, String pUser) async {
    try {
      final String apiUrl =
          '${ApiArsacGroup.baseUrl}/api/reportePorDiario?pRango1=$pRango1&pRango2=$pRango2&pUser=$pUser';

      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        // Check if the response body is not empty
        if (response.body.isNotEmpty) {
          List<dynamic> jsonData = json.decode(response.body);
          return jsonData;
        } else {
          // Return an empty list if the response body is empty
          return [];
        }
      } else {
        // Handle non-200 status codes
        print(
            "Error al llamar a la API. Código de estado: ${response.statusCode}");
        return [];
      }
    } catch (error) {
      // Handle other exceptions
      print("Error al llamar a la API cursos por Docente: $error");
      return [];
    }
  }
}

class ApiReporteDiarioCallPdf {
  Future<List<int>> fetchReporteDiario(
      String pRango1, String pRango2, String pUser) async {
    try {
      final String apiUrl =
          '${ApiArsacGroup.baseUrl}/api/reportePorDiarioPDF?pRango1=$pRango1&pRango2=$pRango2&pUser=$pUser';

      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        // Verifica si la respuesta es un archivo PDF (en formato binario)
        if (response.headers['content-type'] == 'application/pdf') {
          // Devuelve los bytes del PDF
          return response.bodyBytes;
        } else {
          print("La API no devolvió un archivo PDF");
          return [];
        }
      } else {
        print(
            "Error al llamar a la API Rerporte. Código de estado: ${response.statusCode}");
        print("Cuerpo de la respuesta: ${response.body}");
        return [];
      }
    } catch (error) {
      print("Error al llamar a la API: $error");
      return [];
    }
  }
}

class ApiReporteFechasPorCursoCall {
  Future<List<dynamic>> fetchReportePorCurso(int pCurso, int pMateria,
      String pRango1, String pRango2, String pUser) async {
    try {
      final String apiUrl =
          '${ApiArsacGroup.baseUrl}/api/reportePorCurso?pMateria=$pMateria&pCurso=$pCurso&pRango1=$pRango1&pRango2=$pRango2&pUser=$pUser';

      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );
    
      if (response.statusCode == 200) {
        // Check if the response body is not empty
        if (response.body.isNotEmpty) {
          List<dynamic> jsonData = json.decode(response.body);
          return jsonData;
        } else {
          // Return an empty list if the response body is empty
          return [];
        }
      } else {
        // Handle non-200 status codes
        print(
            "Error al llamar a la API. Código de estado: ${response.statusCode}");
        return [];
      }
    } catch (error) {
      // Handle other exceptions
      print("Error al llamar a la API cursos por Docente: $error");
      return [];
    }
  }
}

class ApiReporteFechasPorCursoCallPdf {
  Future<List<int>> fetchReporteFechasPorDiario(int pCurso, int pMateria,
      String pRango1, String pRango2, String pUser) async {
    try {
      final String apiUrl =
          '${ApiArsacGroup.baseUrl}/api/reportePorCursoPDF?pMateria=$pMateria&pCurso=$pCurso&pRango1=$pRango1&pRango2=$pRango2&pUser=$pUser';

      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        // Verifica si la respuesta es un archivo PDF (en formato binario)
        if (response.headers['content-type'] == 'application/pdf') {
          // Devuelve los bytes del PDF
          return response.bodyBytes;
        } else {
          print("La API no devolvió un archivo PDF");
          return [];
        }
      } else {
        print(
            "Error al llamar a la API Rerporte. Código de estado: ${response.statusCode}");
        print("Cuerpo de la respuesta: ${response.body}");
        return [];
      }
    } catch (error) {
      print("Error al llamar a la API: $error");
      return [];
    }
  }
}

class ApiReportePorEstudianteCall {
  Future<List<dynamic>> fetchReportePorEstudiante(
      String pNumeroDocumento,
      int pCurso,
      int pMateria,
      String pRango1,
      String pRango2,
      String pUser) async {
    try {
      final String apiUrl =
          '${ApiArsacGroup.baseUrl}/api/reporteEstudiante?pNumeroDocumento=$pNumeroDocumento&pMateria=$pMateria&pCurso=$pCurso&pRango1=$pRango1&pRango2=$pRango2&pUser=$pUser';

      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        // Check if the response body is not empty
        if (response.body.isNotEmpty) {
          List<dynamic> jsonData = json.decode(response.body);
          return jsonData;
        } else {
          // Return an empty list if the response body is empty
          return [];
        }
      } else {
        // Handle non-200 status codes
        print(
            "Error al llamar a la API. Código de estado: ${response.statusCode}");
        return [];
      }
    } catch (error) {
      // Handle other exceptions
      print("Error al llamar a la API reporte por estudiante: $error");
      return [];
    }
  }
}

class ApiReportePorEstudianteCallPdf {
  Future<List<int>> fetchReportePorEstudiante(
      String pNumeroDocumento,
      int pCurso,
      int pMateria,
      String pRango1,
      String pRango2,
      String pUser) async {
    try {
      final String apiUrl =
          '${ApiArsacGroup.baseUrl}/api/reporteEstudiantePDF?pNumeroDocumento=$pNumeroDocumento&pMateria=$pMateria&pCurso=$pCurso&pRango1=$pRango1&pRango2=$pRango2&pUser=$pUser';

      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        // Verifica si la respuesta es un archivo PDF (en formato binario)
        if (response.headers['content-type'] == 'application/pdf') {
          // Devuelve los bytes del PDF
          return response.bodyBytes;
        } else {
          print("La API no devolvió un archivo PDF");
          return [];
        }
      } else {
        print(
            "Error al llamar a la API Rerporte. Código de estado: ${response.statusCode}");
        print("Cuerpo de la respuesta: ${response.body}");
        return [];
      }
    } catch (error) {
      print("Error al llamar a la API: $error");
      return [];
    }
  }
}

class ApiNotificationsCall {
  Future<List<dynamic>> fetchNotifications() async {
    try {
      final String apiUrl =
          '${ApiArsacGroup.baseUrl}/notify/notifications/';

      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        // Check if the response body is not empty
        if (response.body.isNotEmpty) {
          List<dynamic> jsonData = json.decode(response.body);
          return jsonData;
        } else {
          // Return an empty list if the response body is empty
          return [];
        }
      } else {
        // Handle non-200 status codes
        print(
            "Error al llamar a la API. Código de estado: ${response.statusCode}");
        return [];
      }
    } catch (error) {
      // Handle other exceptions
      print("Error al llamar a la API notificaciones: $error");
      return [];
    }
  }

  Future<String> deleteNotifications(int pIdNotification) async {
    try {
      final String apiUrl =
          '${ApiArsacGroup.baseUrl}/notify/notifications/$pIdNotification/';

      final http.Response response = await http.delete(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        // Parse the response body
        Map<String, dynamic> responseData = json.decode(response.body);
        // Extract the message from the response data
        String message = responseData['msg'];
        // Return the message
        return message;
      } else {
        // Handle non-200 status codes
        print(
            "Error al llamar a la API. Código de estado: ${response.statusCode}");
        return "Error al eliminar la observación.";
      }
    } catch (error) {
      // Handle other exceptions
      print("Error al eliminar la notificacion API: $error");
      return "Error al eliminar la notificación.";
    }
  }

}

class ApiInformationDocenteCall {
  Future<List<dynamic>> fetchInformationTeacher(String pUser) async {
    try {
      final String apiUrl =
          '${ApiArsacGroup.baseUrl}/profile/InformationProfile?pUser=$pUser';

      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        // Check if the response body is not empty
        if (response.body.isNotEmpty) {
          List<dynamic> jsonData = json.decode(response.body);
          return jsonData;
        } else {
          // Return an empty list if the response body is empty
          return [];
        }
      } else {
        // Handle non-200 status codes
        print(
            "Error al llamar a la API. Código de estado: ${response.statusCode}");
        return [];
      }
    } catch (error) {
      // Handle other exceptions
      print("Error al llamar a la API ifnormaction docente: $error");
      return [];
    }
  }
}


class ApiHorarioEstudianteCall {
  Future<List<dynamic>> fetchHorarioEstudiante(String pUser) async {
    try {
      final String apiUrl =
          '${ApiArsacGroup.baseUrl}/api/HorarioEstudiante/?pUser=$pUser';

      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        // Check if the response body is not empty
        if (response.body.isNotEmpty) {
          List<dynamic> jsonData = json.decode(response.body);
          return jsonData;
        } else {
          // Return an empty list if the response body is empty
          return [];
        }
      } else {
        // Handle non-200 status codes
        print(
            "Error al llamar a la API. Código de estado: ${response.statusCode}");
        return [];
      }
    } catch (error) {
      // Handle other exceptions
      print("Error al llamar a la API HORARIO ESTUDIANTE $error");
      return [];
    }
  }
}

class ApiConsultarAsistenciaEstudianteCall {
  Future<List<dynamic>> fetchConsultaAsistEstudiante(String pUser, int pMateria, int pCurso) async {
    try {
      final String apiUrl =
          '${ApiArsacGroup.baseUrl}/api/ConsultarAsistenciaEstudiante/?pUser=$pUser&pIdMateria=$pMateria&pIdCurso=$pCurso';

      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );
        print(pUser);
        print("mater:$pMateria");
        print("Curso: $pCurso");

      if (response.statusCode == 200) {
        // Check if the response body is not empty
        if (response.body.isNotEmpty) {
          List<dynamic> jsonData = json.decode(response.body);
          return jsonData;
        } else {
          // Return an empty list if the response body is empty
          return [];
        }
      } else {
        // Handle non-200 status codes
        print(
            "Error al llamar a la API. Código de estado: ${response.statusCode}");
        return [];
      }
    } catch (error) {
      // Handle other exceptions
      print("Error al llamar a la API HORARIO ESTUDIANTE $error");
      return [];
    }
  }
}

class ApiConsultarObservacionesEstudianteCall {
  Future<List<dynamic>> fetchConsultaObserEstudiante(String pUser, int pMateria, int pCurso) async {
    try {
      final String apiUrl =
          '${ApiArsacGroup.baseUrl}/api/ConsultarObservacionesEstudiante/?pUser=$pUser&pIdMateria=$pMateria&pIdCurso=$pCurso';

      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );
        print(pUser);
        print("mater:$pMateria");
        print("Curso: $pCurso");

      if (response.statusCode == 200) {
        // Check if the response body is not empty
        if (response.body.isNotEmpty) {
          List<dynamic> jsonData = json.decode(response.body);
          return jsonData;
        } else {
          // Return an empty list if the response body is empty
          return [];
        }
      } else {
        // Handle non-200 status codes
        print(
            "Error al llamar a la API. Código de estado: ${response.statusCode}");
        return [];
      }
    } catch (error) {
      // Handle other exceptions
      print("Error al llamar a la API HORARIO ESTUDIANTE $error");
      return [];
    }
  }
}



/// End ApiArsac Group Code

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}
