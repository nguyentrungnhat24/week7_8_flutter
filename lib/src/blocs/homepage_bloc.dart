import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_week01/data/data.dart' as app_data;

// Events
abstract class HomepageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchDataEvent extends HomepageEvent {}

// States
abstract class HomepageState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomepageInitial extends HomepageState {}

class HomepageLoading extends HomepageState {}

class HomepageLoaded extends HomepageState {
  final List<Map<String, dynamic>> sections;
  final List<Map<String, String>> categories;

  HomepageLoaded({required this.sections, required this.categories});

  @override
  List<Object> get props => [sections, categories];
}

class HomepageError extends HomepageState {
  final String message;

  HomepageError(this.message);

  @override
  List<Object> get props => [message];
}

// BLoC
class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  HomepageBloc() : super(HomepageInitial()) {
    on<FetchDataEvent>(_onFetchData);
  }

  Future<void> _onFetchData(
    FetchDataEvent event,
    Emitter<HomepageState> emit,
  ) async {
    try {
      emit(HomepageLoading());

      // Giả sử đây là dữ liệu từ API hoặc database
      // Trong ví dụ này, tôi sẽ dùng dữ liệu từ file data.dart
      // Trong thực tế, bạn sẽ gọi API hoặc Repository ở đây

      // Giả lập việc lấy dữ liệu từ API
      await Future.delayed(const Duration(milliseconds: 500));

      // Lấy dữ liệu từ data.dart (trong thực tế, đây là từ API)

      emit(
        HomepageLoaded(
          sections: app_data.sections,
          categories: app_data.categories,
        ),
      );
    } catch (e) {
      emit(HomepageError(e.toString()));
    }
  }
}
