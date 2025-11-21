import 'package:flutter/material.dart';

class RemindersPage extends StatefulWidget {
  const RemindersPage({super.key});

  @override
  State<RemindersPage> createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  bool reminderOn = true;
  List<String> days = ["S", "M", "T", "W", "T", "F", "Sa"];
  int selectedTimeHour = 8;
  int selectedTimeMinute = 0;
  bool isPM = true;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bgimage.png"),
            fit: BoxFit.cover,
          ),
        ),

        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: h * 0.07),

              // ⭐ StoryHug Logo
              Image.asset(
                "assets/images/favoritesimage.png", // replace with your asset
                height: h * 0.10,
              ),

              SizedBox(height: h * 0.02),

              // ⭐ Title
              Text(
                "Bedtime Reminder",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: h * 0.04),

              // ⭐ MAIN GLOWING CARD
              Container(
                width: w * 0.90,
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.45),
                    width: 1.3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.3),
                      blurRadius: 25,
                      spreadRadius: 2,
                    )
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ⭐ DAILY REMINDER + SWITCH
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.alarm, color: Colors.amber),
                            SizedBox(width: 8),
                            Text(
                              "Daily Story Reminder",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),

                        Switch(
                          value: reminderOn,
                          onChanged: (val) {
                            setState(() {
                              reminderOn = val;
                            });

                          },
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    Text(
                      "Set Time",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),

                    SizedBox(height: 5),

                    // ⭐ TIME TEXT
                    Center(
                      child: Text(
                        "${selectedTimeHour.toString().padLeft(2, '0')}:${selectedTimeMinute.toString().padLeft(2, '0')} ${isPM ? 'PM' : 'AM'}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    SizedBox(height: 15),

                    Text(
                      "Repeat",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),

                    SizedBox(height: 12),

                    // ⭐ WEEKDAY CIRCLES
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: days.map((day) {
                        return _buildDayBubble(day);
                      }).toList(),
                    ),

                    SizedBox(height: 20),

                    // ⭐ Sweet Dreams Box
                    Container(
                      padding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.20),
                        borderRadius: BorderRadius.circular(18),
                        border:
                        Border.all(color: Colors.white.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.nights_stay,
                              color: Colors.amber, size: 24),
                          SizedBox(width: 10),
                          Text(
                            "Sweet Dreams\nEvery Night",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              height: 1.2,
                            ),
                          )
                        ],
                      ),
                    ),

                    SizedBox(height: 25),

                    // ⭐ SAVE BUTTON
                    Center(
                      child: Container(
                        width: w * 0.80,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFFFD66E),
                              Color(0xFFFFC84F),
                            ],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Save Changes",
                            style: TextStyle(
                              fontFamily: "Arial Rounded MT Bold",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF24305B),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // ⭐ Day Circle Widget
  Widget _buildDayBubble(String day) {
    return Container(
      width: 42,
      height: 42,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.amber.withOpacity(0.12),
        border: Border.all(
          color: Colors.amber.withOpacity(0.35),
          width: 1.2,
        ),
      ),
      child: Text(
        day,
        style: TextStyle(color: Colors.amber, fontSize: 14),
      ),
    );
  }
}
