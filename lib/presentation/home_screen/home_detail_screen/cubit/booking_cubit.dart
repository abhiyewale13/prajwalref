import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/presentation/home_screen/home_detail_screen/model/booking_model.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit()
      : super(
          BookingState(
            currentView: BookingView.dateTime,
            selectedDate: DateTime.now(),
            displayedMonth: DateTime.now(),
            selectedStartTime: null, // No preselected time
            selectedEndTime: null, // No preselected time
          ),
        );

  // void changeView(BookingView view) {
  //   emit(state.copyWith(currentView: view));
  // }
 void changeView(BookingView view) {
  emit(state.copyWith(currentView: view));
}
 void selectDate(DateTime date) {
  if (date != state.selectedDate) {
    emit(state.copyWith(
      selectedDate: date,
      selectedStartTime: null, // Reset times when date changes
      selectedEndTime: null,
    ));
  }
}
   
  
  

  // void selectStartTime(DateTime startTime) {
  //   emit(state.copyWith(selectedStartTime: startTime, selectedEndTime: null));
  // }
void selectStartTime(DateTime time) {
  emit(state.copyWith(selectedStartTime: time, selectedEndTime: null));
}

  // void selectEndTime(DateTime endTime) {
  //   if (state.selectedStartTime != null && endTime.isAfter(state.selectedStartTime!)) {
  //     emit(state.copyWith(selectedEndTime: endTime));
  //     changeView(BookingView.package); // Move to package selection automatically
  //   }
  // }

//   void selectEndTime(DateTime time) {
//   if (state.selectedStartTime != null && time.isAfter(state.selectedStartTime!)) {
//     emit(state.copyWith(selectedEndTime: time));

//     // Ensure the view changes only when both start and end times are selected
//     if (state.selectedStartTime != null && state.selectedEndTime != null) {
//       changeView(BookingView.package);
//     }
//   }
// }
void selectEndTime(DateTime time) {
  if (state.selectedStartTime != null && time.isAfter(state.selectedStartTime!)) {
    emit(state.copyWith(selectedEndTime: time));
    
    // Move to the next screen when both times are selected
    if (state.selectedStartTime != null && state.selectedEndTime != null) {
      changeView(BookingView.package);
    }
  }
}
  void changeMonth(bool next) {
    final newMonth = DateTime(
      state.displayedMonth.year,
      state.displayedMonth.month + (next ? 1 : -1),
      1,
    );
    emit(state.copyWith(displayedMonth: newMonth));
  }



void selectTime(DateTime time, {bool isStart = true}) {
  if (isStart) {
    emit(state.copyWith(selectedStartTime: time)); 
  } else {
    if (state.selectedStartTime != null && time.isAfter(state.selectedStartTime!)) {
      emit(state.copyWith(selectedEndTime: time));

      // Move to the package section only if both start and end times are selected
      if (state.selectedStartTime != null && state.selectedEndTime != null) {
        changeView(BookingView.package);
      }
    }
  }
}


}

