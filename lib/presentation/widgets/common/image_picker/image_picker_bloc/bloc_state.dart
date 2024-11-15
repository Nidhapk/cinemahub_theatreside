import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class ImagePickerState extends Equatable {
  const ImagePickerState();

  @override
  List<Object?> get props => [];
}

class ImagePickerInitial extends ImagePickerState {}

class ProfileImagePickedState extends ImagePickerState {
  final XFile? image;

  const ProfileImagePickedState(this.image);

  @override
  List<Object?> get props => [image];
}
