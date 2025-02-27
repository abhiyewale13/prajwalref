import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task2/presentation/home_screen/home_detail_screen/cubit/booking_cubit.dart';
import 'package:task2/presentation/home_screen/home_detail_screen/model/booking_model.dart';


Widget buildDateTimeView(BuildContext context) {
  final Size size = MediaQuery.of(context).size;
  return BlocBuilder<BookingCubit, BookingState>(
    builder: (context, state) {
      return Expanded( // Fix for layout overflow
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(), // Smooth scrolling
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMonthNavigator(context, state),
              SizedBox(height: size.height * 0.02),
              _buildDateScroller(context, state),
              SizedBox(height: 20,),
              buildTimeSelection(context, state), 
            ],
          ),
        ),
      );
    },
  );
}



Widget _buildMonthNavigator(BuildContext context, BookingState state) {
  final Size size = MediaQuery.of(context).size;
  double padding = size.width * 0.03;
  double fontSize = size.width * 0.05;
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: padding * 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white),
          onPressed: () => context.read<BookingCubit>().changeMonth(false),
        ),
        Text(
          DateFormat('MMMM yyyy').format(state.displayedMonth),
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontFamily: 'Switzer',
          ),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right, color: Colors.white),
          onPressed: () => context.read<BookingCubit>().changeMonth(true),
        ),
      ],
    ),
  );
}

Widget _buildDateScroller(BuildContext context, BookingState state) {
  final dates = _generateDatesForMonth(state.displayedMonth);
  final Size size = MediaQuery.of(context).size;
  double padding = size.width * 0.03;
  double fontSize = size.width * 0.05;
  return SizedBox(
    height: size.height * 0.1,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: padding),
      itemCount: dates.length,
      itemBuilder: (context, index) {
        final date = dates[index];
        final isSelected = _isSameDay(date, state.selectedDate);

        return Padding(
          padding: EdgeInsets.only(right: padding),
          child: GestureDetector(
            onTap: () => context.read<BookingCubit>().selectDate(date),
            child: Container(
              width: size.width * 0.20,
              decoration: BoxDecoration(
                color: isSelected ? Color(0xff3579DD) : const Color(0xFF2A2B2E),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('EEE').format(date),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey,
                      fontSize: fontSize,
                      fontFamily: 'Switzer',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('dd').format(date),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey,
                      fontSize: fontSize,
                      fontFamily: 'Switzer',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}



// Widget _buildTimeList(BuildContext context, BookingState state) {
//   final times = ['08:00', '10:00', '12:00', '14:00', '16:00', '18:00', '20:00', '22:00'];
//   final Size size = MediaQuery.of(context).size;
//   double padding = size.width * 0.03;
//   double fontSize = size.width * 0.05;

//   return Padding(
//     padding: EdgeInsets.symmetric(horizontal: padding),
//     child: GridView.builder(
//       physics: const NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 4,
//         crossAxisSpacing: 12,
//         mainAxisSpacing: 12,
//         childAspectRatio: 1.8,
//       ),
//       itemCount: times.length,
//       itemBuilder: (context, index) {
//         final time = times[index];
//         final parsedTime = _parseTime(time, state.selectedDate);

//         bool isStartSelected = state.selectedStartTime == parsedTime;
//         bool isEndSelected = state.selectedEndTime == parsedTime;
        
//         Color tileColor = isStartSelected || isEndSelected
//             ? const Color(0xff3579DD)
//             : const Color(0xFF2A2B2E);

//         return GestureDetector(
//           onTap: () {
//             if (state.selectedStartTime == null) {
//               context.read<BookingCubit>().selectTime(parsedTime, isStart: true);
//             } else if (state.selectedEndTime == null &&
//                 parsedTime.isAfter(state.selectedStartTime!)) {
//               context.read<BookingCubit>().selectTime(parsedTime, isStart: false);
//             }
//           },
//           child: Container(
//             decoration: BoxDecoration(
//               color: tileColor,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Center(
//               child: Text(
//                 time,
//                 style: TextStyle(
//                   color: (isStartSelected || isEndSelected) ? Colors.white : Colors.grey,
//                   fontSize: fontSize,
//                   fontFamily: 'Switzer',
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     ),
//   );
// }



Widget buildTimeSelection(BuildContext context, BookingState state) {
  final List<String> times = ['08:00', '10:00', '12:00', '14:00', '16:00', '18:00', '20:00', '22:00'];
  final Size size = MediaQuery.of(context).size;
  double padding = size.width * 0.03;
  double fontSize = size.width * 0.05;

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: padding),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Select Start Time", style: _headingStyle(fontSize)),
        _buildTimeGrid(context, state, times, isStartTime: true),
        SizedBox(height: 20),
        Text("Select End Time", style: _headingStyle(fontSize)),
        _buildTimeGrid(context, state, times, isStartTime: false),
        SizedBox(height: 50,)
      ],
    ),
  );
}

TextStyle _headingStyle(double fontSize) {
  return TextStyle(
    fontSize: fontSize,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: 'Switzer',
  );
}

// 🔹 Fixed UI Selection Logic for Start & End Time
Widget _buildTimeGrid(BuildContext context, BookingState state, List<String> times, {required bool isStartTime}) {
  return GridView.builder(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.8,
    ),
    itemCount: times.length,
    itemBuilder: (context, index) {
      final String time = times[index];
      final DateTime parsedTime = _parseTime(time, state.selectedDate);

    bool isSelected = isStartTime
    ? state.selectedStartTime != null && state.selectedStartTime!.isAtSameMomentAs(parsedTime)
    : state.selectedEndTime != null && state.selectedEndTime!.isAtSameMomentAs(parsedTime);


      bool isDisabled = !isStartTime &&
          (state.selectedStartTime == null || parsedTime.isBefore(state.selectedStartTime!.add(const Duration(minutes: 30))));

     
      Color tileColor = isSelected
    ? (isStartTime ? const Color(0xff3579DD) : Colors.green) // Start time -> Blue, End time -> Green
    : const Color(0xFF2A2B2E); // Default background


      Color textColor = isSelected ? Colors.white : Colors.white70;

      return GestureDetector(
        onTap: () {
          if (isStartTime) {
            context.read<BookingCubit>().selectTime(parsedTime, isStart: true);
          } else if (!isDisabled) {
            context.read<BookingCubit>().selectTime(parsedTime, isStart: false);
            context.read<BookingCubit>().changeView(BookingView.package); // Navigate on End Time selection
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: tileColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              time,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontFamily: 'Switzer',
              ),
            ),
          ),
        ),
      );
    },
  );
}






// Helper function to parse time string
DateTime _parseTime(String time, DateTime selectedDate) {
  final DateFormat formatter = DateFormat("HH:mm");
  final DateTime parsedTime = formatter.parse(time);
  return DateTime(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day,
    parsedTime.hour,
    parsedTime.minute,
  );
}





List<DateTime> _generateDatesForMonth(DateTime month) {
  DateTime today = DateTime.now();
  int daysInMonth = DateTime(month.year, month.month + 1, 0).day;
  
  return List.generate(daysInMonth, (index) {
    DateTime date = DateTime(month.year, month.month, index + 1);
    return date.isBefore(today) ? null : date;
  }).whereType<DateTime>().toList(); // Filter out null values
}

bool _isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}
