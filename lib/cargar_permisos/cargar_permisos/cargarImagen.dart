import 'package:image_picker/image_picker.dart';

Future<XFile?> getImage() async {
  final ImagePicker picker = ImagePicker();
  // Lanza la ejecución para abrir la galeria y cargar la imagen
  
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  return image;
}