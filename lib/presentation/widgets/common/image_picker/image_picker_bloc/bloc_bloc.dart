import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/common/image_picker/image_picker_bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/common/image_picker/image_picker_bloc/bloc_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final ImagePicker _picker = ImagePicker();

  ImagePickerBloc() : super(ImagePickerInitial()) {
    on<ClearProfileImageEvent>((event, emit) {
      emit(ImagePickerInitial());
    });
    on<ProfileImagePickedEvent>(onProfilePickedEvent);
  }

  void onProfilePickedEvent(
      ProfileImagePickedEvent event, Emitter<ImagePickerState> emit) async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        emit(
          ProfileImagePickedState(pickedFile),
        );
      } else {
        emit(
          ImagePickerInitial(),
        );
      }
    } catch (e) {
      emit(
        ImagePickerInitial(),
      );
    }
  }
}
