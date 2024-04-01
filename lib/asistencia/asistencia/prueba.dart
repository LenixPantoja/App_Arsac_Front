import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  // URL de la API
  String url = 'https://06e8-8-242-169-8.ngrok-free.app/api/AsistenciaEstudiante/';

  // Datos que enviarás en el cuerpo de la solicitud (en formato JSON)
  Map<String, dynamic> datos = {
    "tipo_asistencia": "tipoAsistencia",
    "descripcion": "descripcion",
    "hora_llegada": "2024-04-01 01:05",
    "soporte": null,
    "matricula_estudiante": 1
  };
  
  // Token de autorización
  String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzEyMDA1ODIzLCJpYXQiOjE3MTE5MzM4MjMsImp0aSI6IjkzZTg2YTNmN2IwMDRjYWJiZjdiOGJlMzc1NjA1NDEyIiwidXNlcl9pZCI6MX0.rHo0dROd6lfNykHbIBLIIZf9j68Qj7lAn-mHmgrfBUI';
  
  // Encabezados de la solicitud con el token de autorización
  Map<String, String> headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json' // Especificar el tipo de contenido JSON
  };

  // Realizar la solicitud POST enviando los datos en el cuerpo
  http.Response response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(datos));
  
  // Verificar el estado de la respuesta
  if (response.statusCode == 200) {
    // La solicitud fue exitosa
    Map<String, dynamic> respuestaApi = jsonDecode(response.body);
    print('Respuesta de la API: $respuestaApi');
  } else {
    // Hubo un error en la solicitud
    print('Error en la solicitud: ${response.statusCode}');
    print('Contenido de la respuesta: ${response.body}');
  }
}
