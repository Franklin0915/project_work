import 'package:image_picker/image_picker.dart';

abstract class AppEvents {}

class RecognizePlateEvent extends AppEvents {
  final XFile imageFile;
  RecognizePlateEvent(this.imageFile);
}
