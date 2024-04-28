//ignore_for_file: sort_child_properties_last, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:share/share.dart';

class PDFGeneratorDiario extends StatelessWidget {
  final String pdfPath;

  const PDFGeneratorDiario({required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REPORTE PDF', style: TextStyle(color: Colors.white)),
        backgroundColor:
            Color.fromARGB(214, 255, 217, 3),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text('Compartir'),
                  value: 'opcion1',
                ),
              ];
            },
            onSelected: (result) {
              if (result == 'opcion1') {
                _compartirPDF(pdfPath);
              }
            },
          ),
        ],
      ),
      body: PDFView(
        filePath: pdfPath,
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageSnap: true,
        pageFling: false,
        onRender: (pages) {
          // Lógica después de renderizar el PDF
          print('PDF renderizado con $pages páginas');
        },
        onError: (error) {
          // Manejar errores al cargar el PDF
          print('Error al cargar el PDF: $error');
        },
      ),
    );
  }

  void _compartirPDF(String filePath) {
    Share.shareFiles([filePath], text: 'Compartir PDF');
  }
}
