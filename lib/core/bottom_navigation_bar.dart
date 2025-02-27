import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:task2/presentation/history_screen/history_screen.dart';
import 'package:task2/presentation/music_screen/view/music_screen.dart';
import 'package:task2/presentation/home_screen/home_screen/view/home_screen.dart';

class BottomNavScreen extends StatefulWidget {
  final int initialIndex;
  final bool showSnackbar;
  final DateTime? selectedDate;
  final String? selectedStartTime;
   final String? selectedEndTime;


  const BottomNavScreen({
    super.key,
    this.initialIndex = 0,
    this.showSnackbar = false,
    this.selectedDate,
    this.selectedStartTime,
    this.selectedEndTime
  });

  @override
  BottomNavScreenState createState() => BottomNavScreenState();
}

class BottomNavScreenState extends State<BottomNavScreen> {
  late int _selectedIndex;
  late List<Widget> _screens;

  final List<String> _iconPaths = [
    "assets/home_assets/home.svg",
    "assets/home_assets/receipt.svg",
    "assets/home_assets/music.svg",
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;

    _screens = [
      HomeScreen(
        showSnackbar: widget.showSnackbar,
        selectedDate: widget.selectedDate,
        selectedStartTime: widget.selectedStartTime,
         selectedEndTime: widget.selectedEndTime,
      ),
      const HistoryScreen(),
      MusicScreen(),
    ];
    String getDaySuffix(int day) {
      if (day >= 11 && day <= 13) {
        return "th";
      }
      switch (day % 10) {
        case 1:
          return "st";
        case 2:
          return "nd";
        case 3:
          return "rd";
        default:
          return "th";
      }
    }

    String getFormattedDate(DateTime date) {
      String day = DateFormat("d").format(date);
      String suffix = getDaySuffix(int.parse(day));
      String formattedDate = DateFormat("a d'${suffix}' MMM").format(date);
      return formattedDate;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Size size = MediaQuery.of(context).size;
      double fontSize = size.width * 0.05;
      if (widget.showSnackbar &&
          _selectedIndex == 0 &&
          widget.selectedDate != null &&
          widget.selectedStartTime != null && widget.selectedEndTime !=null) {
        final formattedDate = getFormattedDate(widget.selectedDate!);
        final message =
            "You have a booking at ${widget.selectedStartTime} $formattedDate ";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color(0xff3579DD),
            content: Row(
              children: [
                SvgPicture.asset(
                  "assets/home_assets/barcode.svg",
                  height: size.height * 0.03,
                ),
                SizedBox(width: size.width * 0.02),
                Text(message, style: TextStyle(fontSize: fontSize * 0.7)),
              ],
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color(0xff090D14),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: const Color(0xff3579DD),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: List.generate(3, (index) {
            return BottomNavigationBarItem(
              icon: SvgPicture.asset(
                _iconPaths[index],
                colorFilter: ColorFilter.mode(
                  _selectedIndex == index ? Colors.blue : Colors.grey,
                  BlendMode.srcIn,
                ),
                width: 24,
                height: 24,
              ),
              label: ['Home', 'History', 'Music'][index],
            );
          }),
        ),
      ),
    );
  }
}
