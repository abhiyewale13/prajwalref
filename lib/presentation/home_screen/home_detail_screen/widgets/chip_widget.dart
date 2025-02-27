import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/presentation/home_screen/home_detail_screen/cubit/booking_cubit.dart';
import 'package:task2/presentation/home_screen/home_detail_screen/model/booking_model.dart';

Widget buildNavigationChips(BuildContext context) {
  final Size size = MediaQuery.of(context).size;
  // double padding = size.width * 0.04;
  double spacing = size.width * 0.04;

  return BlocBuilder<BookingCubit, BookingState>(
    builder: (context, state) {
      return Wrap(
        spacing: spacing,
        alignment: WrapAlignment.center,
        children: [
          _buildChip(
            context,
            'Time and Date',
            BookingView.dateTime,
            state.currentView,
            size,
          ),
          _buildChip(
            context,
            'Affordable Package',
            BookingView.package,
            state.currentView,
            size,
          ),
          _buildChip(
            context,
            'Drink',
            BookingView.drink,
            state.currentView,
            size,
          ),
        ],
      );
    },
  );
}

Widget _buildChip(
  BuildContext context,
  String label,
  BookingView view,
  BookingView currentView,
  Size size,
) {
  final bool isSelected = view == currentView;
  double paddingH = size.width * 0.04;
  double paddingV = size.height * 0.015;
  double fontSize = size.width * 0.035;

  return GestureDetector(
    onTap: () => context.read<BookingCubit>().changeView(view),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: paddingH, vertical: paddingV),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? Color(0xff3579DD) : Colors.white70,
          width: 0.5,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Color(0xff3579DD) : Colors.white,
          fontSize: fontSize,
        ),
      ),
    ),
  );
}





