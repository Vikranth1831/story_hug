import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
  List<bool> selectedDays = List.generate(7, (index) => false);

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

              Image.asset(
                "assets/images/favoritesimage.png",
                height: h * 0.10,
              ),

              SizedBox(height: h * 0.02),

              Text(
                "Bedtime Reminder",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Arial'
                ),
              ),

              SizedBox(height: h * 0.04),

              // ⭐ MAIN GLOW CARD
              Container(
                width: w * 0.90,
                padding: EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(26),

                  // 🔥 Outer Glow
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.10),
                      blurRadius: 50,
                      spreadRadius: 5,
                      offset: Offset(0, 0),
                    ),
                  ],

                  // 🔹 Outline Border
                  border: Border.all(
                    color: Colors.white.withOpacity(0.50),
                    width: 1.5,

                  ),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ⭐ HEADER ROW WITH SWITCH
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.alarm, color: Colors.amber, size: 22),
                            SizedBox(width: 8),
                            Text(
                              "Daily Story Reminder",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                  fontFamily: 'Arial'

                              ),
                            )
                          ],
                        ),

                        Switch(
                          value: reminderOn,
                          activeColor: Colors.amber,
                          onChanged: (val) {
                            setState(() => reminderOn = val);
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: 25),

                    Text("Set Time",
                        style: TextStyle(color: Colors.white, fontSize: 15,
                            fontFamily: 'Arial'
                        )),

                    SizedBox(height: 8),

                    // ⭐ TIME DISPLAY
                    Center(
                      child: Text(
                        "${selectedTimeHour.toString().padLeft(2, '0')}:${selectedTimeMinute.toString().padLeft(2, '0')} ${isPM ? 'PM' : 'AM'}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 42,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.blueAccent.withOpacity(0.5),
                              blurRadius: 15,
                            )
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 22),

                    Text("Repeat",
                        style: TextStyle(color: Colors.white, fontSize: 15,
                            fontFamily: 'Arial'
                        )),

                    SizedBox(height: 14),

                    // ⭐ DAYS SELECTOR
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        days.length,
                            (i) => _buildDayBubble(i, days[i]),
                      ),
                    ),

                    SizedBox(height: 25),

                    // ⭐ CENTER SWEET DREAMS CARD
                    Center(
                      child: Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.35), width: 1),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.nights_stay,
                                color: Colors.amber, size: 26),
                            SizedBox(width: 12),
                            Text(
                              "Sweet Dreams\nEvery Night",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Arial',
                                color: Colors.white,
                                fontSize: 14.5,
                                height: 1.25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 30),

                    // ⭐ SAVE BUTTON
                    Center(
                      child: InkWell(
                        onTap: ()
                        {
                          context.go('/home');
                        },
                        child: Container(
                          width: w * 0.75,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                              colors: [
                                Color(0xffffda72),
                                Color(0xffffc94d),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.amber.withOpacity(0.4),
                                blurRadius: 18,
                                spreadRadius: 1,
                              )
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "Save Changes",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Color(0xFF24305B),
                                  fontFamily: 'Arial'

                              ),
                            ),
                          ),
                        ),
                      ),
                    )
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
  Widget _buildDayBubble(int index, String day) {

    bool isSelected = selectedDays[index];

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDays[index] = !selectedDays[index];
        });
      },

      child: Container(
        width: 35,
        height: 35,
        alignment: Alignment.center,

        decoration: BoxDecoration(
          shape: BoxShape.circle,

          // ⭐ COLORS BASED ON SELECTED OR NOT
          color: isSelected
              ? Colors.amber.withOpacity(0.30)        // SELECTED BG
              : Colors.amber.withOpacity(0.10),       // NORMAL BG (lighter)

          border: Border.all(
            color: isSelected
                ? Colors.amber                         // SELECTED BORDER
                : Colors.amber.withOpacity(0.30),       // NORMAL BORDER
            width: 1.4,
          ),

          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? Colors.amber.withOpacity(0.50)      // SELECTED SHADOW
                  : Colors.transparent,                 // NORMAL NO GLOW
              blurRadius: 10,
            )
          ],
        ),

        child: Text(
          day,
          style: TextStyle(
            color: isSelected
                ? Colors.amber                          // Selected text full amber
                : Colors.amber.withOpacity(0.50),       // Normal dim text
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }


}
