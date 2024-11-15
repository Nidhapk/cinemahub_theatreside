import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';


abstract class ImagePickerEvent extends Equatable {
  const ImagePickerEvent();

  @override
  List<Object?> get props => [];
}

class ProfileImagePickedEvent extends ImagePickerEvent {
  final ImageSource source;

  const ProfileImagePickedEvent(this.source);

  @override
  List<Object?> get props => [source];
}

class ClearProfileImageEvent extends ImagePickerEvent{

}
