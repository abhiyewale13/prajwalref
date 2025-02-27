import 'package:equatable/equatable.dart';

enum BookingView { dateTime, package, drink }

// class BookingState extends Equatable {
//   final BookingView currentView;
//   final DateTime selectedDate;
//   final DateTime? selectedStartTime;
//   final DateTime? selectedEndTime;
//   final DateTime displayedMonth;
  

//   const BookingState({
//     required this.currentView,
//     required this.selectedDate,
//     this.selectedStartTime,
//     this.selectedEndTime,
//     required this.displayedMonth,
    
//   });

//   BookingState copyWith({
//     BookingView? currentView,
//     DateTime? selectedDate,
//     DateTime? selectedStartTime,
//     DateTime? selectedEndTime,
//     DateTime? displayedMonth,
    
//   }) {
//     return BookingState(
//       currentView: currentView ?? this.currentView,
//       selectedDate: selectedDate ?? this.selectedDate,
//       selectedStartTime: selectedStartTime ?? this.selectedStartTime,
//       selectedEndTime: selectedEndTime ?? this.selectedEndTime,
//       displayedMonth: displayedMonth ?? this.displayedMonth,

//     );
//   }

//   @override
//   List<Object?> get props => [
//         currentView,
//         selectedDate,
//         selectedStartTime,
//         selectedEndTime,
//         displayedMonth,
       
//       ];
// }


class BookingState extends Equatable {
  final BookingView currentView;
  final DateTime selectedDate;
  final DateTime? selectedStartTime;
  final DateTime? selectedEndTime;
  final DateTime displayedMonth;

  const BookingState({
    required this.currentView,
    required this.selectedDate,
    required this.displayedMonth,
    this.selectedStartTime,
    this.selectedEndTime,
  });

  BookingState copyWith({
    BookingView? currentView,
    DateTime? selectedDate,
    DateTime? selectedStartTime,
    DateTime? selectedEndTime,
    DateTime? displayedMonth,
  }) {
    return BookingState(
      currentView: currentView ?? this.currentView,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedStartTime: selectedStartTime ?? this.selectedStartTime, // ✅ Fix here
      selectedEndTime: selectedEndTime ?? this.selectedEndTime, // ✅ Fix here
      displayedMonth: displayedMonth ?? this.displayedMonth,
    );
  }

  @override
  List<Object?> get props => [
        currentView,
        selectedDate,
        selectedStartTime,
        selectedEndTime,
        displayedMonth,
      ];
}
