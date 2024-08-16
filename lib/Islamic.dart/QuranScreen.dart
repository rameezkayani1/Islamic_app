import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:intl/intl.dart';
import 'package:jhijri/_src/_jHijri.dart';
import 'package:jhijri/jHijri.dart';
import 'package:adhan/adhan.dart';

import 'Qibal/compass.dart';
import 'QuranPak.dart';

class Quranscreen extends StatefulWidget {
  const Quranscreen({super.key});

  @override
  State<Quranscreen> createState() => _QuranscreenState();
}

class _QuranscreenState extends State<Quranscreen> {
  bool isplaying = false;
  AudioPlayer player = AudioPlayer();
  DateTime _now = DateTime.now();
  final Coordinates myCoordinates =
      Coordinates(33.6844, 73.0479); // Kushtia coordinates
  final CalculationParameters params =
      CalculationMethod.karachi.getParameters();

  PrayerTimesScreen() {
    params.madhab = Madhab.hanafi;
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _now = DateTime.now(); // Update the current time
    super.initState();
  }

  Map<String, String> _getNextPrayerTimeAndName(PrayerTimes prayerTimes) {
    DateTime now = DateTime.now();
    if (now.isBefore(prayerTimes.fajr)) {
      return {'name': 'Fajr', 'time': DateFormat.jm().format(prayerTimes.fajr)};
    } else if (now.isBefore(prayerTimes.dhuhr)) {
      return {
        'name': 'Dhuhr',
        'time': DateFormat.jm().format(prayerTimes.dhuhr)
      };
    } else if (now.isBefore(prayerTimes.asr)) {
      return {'name': 'Asr', 'time': DateFormat.jm().format(prayerTimes.asr)};
    } else if (now.isBefore(prayerTimes.maghrib)) {
      return {
        'name': 'Maghrib',
        'time': DateFormat.jm().format(prayerTimes.maghrib)
      };
    } else if (now.isBefore(prayerTimes.isha)) {
      return {'name': 'Isha', 'time': DateFormat.jm().format(prayerTimes.isha)};
    } else {
      return {
        'name': 'Fajr',
        'time': DateFormat.jm().format(prayerTimes.fajr.add(Duration(days: 1)))
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    PrayerTimes prayerTimes = PrayerTimes.today(myCoordinates, params);

    Map<String, String> nextPrayer = _getNextPrayerTimeAndName(prayerTimes);
    return Stack(children: [
      Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "المُسَلِّم",
            style: TextStyle(fontSize: 35, color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              // gradient: LinearGradient(
              //   colors: [
              //     Colors.teal[300]!,
              //     Colors.teal[700]!
              //   ], // Islamic theme colors
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              // ),
              color: Colors.transparent,
              // image: DecorationImage(
              //   image: AssetImage('assets/bak.jpg'), // Path to your image asset
              //   fit: BoxFit.cover,
              //   colorFilter: ColorFilter.mode(
              //     Colors.black.withOpacity(0.2),
              //     BlendMode.darken,
              //   ),
              // ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 130,
                        width: MediaQuery.of(context).size.width * 4.5 / 10,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.blue, Colors.green],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/cal.jpg'), // Path to your image asset
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.2),
                              BlendMode.darken,
                            ),
                          ),
                          // color: Colors.transparent,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 8,
                              offset:
                                  Offset(0, 4), // changes position of shadow
                            ),
                          ],
                          // borderRadius: BorderRadius.circular(
                          //     15), // Adjust the radius as needed
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                HijriDate.now().day.toString(),
                                style: TextStyle(
                                  fontSize:
                                      24, // Increased font size for better visibility
                                  fontWeight: FontWeight
                                      .bold, // Added bold for emphasis
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    HijriDate.now().monthName.toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                  ),
                                  Text(
                                    HijriDate.now().year.toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                DateFormat('EEEE,dd MMMM yyyy')
                                    .format(DateTime.now())
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 130,
                        width: MediaQuery.of(context).size.width * 4.1 / 10,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color.fromARGB(255, 93, 7, 243),
                              Color.fromARGB(255, 208, 7, 243)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Distributes space between the top and bottom elements
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Islamabad",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Icon(
                                    Icons.edit,
                                    size: 14,
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Next Prayer Time",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    nextPrayer['time']!,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    nextPrayer['name']!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    // alignment: Alignment.topCenter,
                    height: 140,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color.fromARGB(255, 14, 140, 243),
                          const Color.fromARGB(255, 15, 224, 22)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ), // color: Colors.transparent,
                      borderRadius: BorderRadius.circular(
                          15), // Adjust the radius as needed
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "ٱلْكَوْثَر",
                              style:
                                  TextStyle(fontSize: 35, color: Colors.white),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (isplaying) {
                                  await player.pause();
                                } else if (isplaying) {
                                  await player.onPlayerComplete.listen((event) {
                                    setState(() {
                                      isplaying = false;
                                    });
                                  });
                                } else {
                                  await player
                                      .play(AssetSource('Ayat/Al-Kauther.mp3'));
                                }
                                setState(() {
                                  isplaying = !isplaying;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber,
                                shape: CircleBorder(), // Circular shape
                                // padding: EdgeInsets.all(10), // Button padding
                              ),
                              child: Icon(
                                isplaying ? Icons.pause : Icons.play_circle,
                                size: 40,
                                color: Colors.white, // Icon color
                              ),
                            )
                          ],
                        ),
                        Image.asset(
                          'assets/quran.png',
                          height: 150,
                          // width: 70,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        // color: Colors.transparent,
                        height: 125,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.green[200]!, Colors.blue[400]!],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllSurahsScreen()),
                            );
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                // height: 25,
                                width: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    // BoxShadow(
                                    //   color: Colors.black.withOpacity(0.3),
                                    //   spreadRadius: 2,
                                    //   blurRadius: 8,
                                    //   offset: Offset(0, 4),
                                    // ),
                                  ],
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/quran.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    'Quran',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 5.0,
                                          color: Colors.black45,
                                          offset: Offset(2.0, 2.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        // color: Colors.transparent,
                        height: 125,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.green[200]!, Colors.blue[400]!],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllSurahsScreen()),
                            );
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                // height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    // BoxShadow(
                                    //   color: Colors.black.withOpacity(0.3),
                                    //   spreadRadius: 2,
                                    //   blurRadius: 8,
                                    //   offset: Offset(0, 4),
                                    // ),
                                  ],
                                ),
                                child: ClipOval(
                                    child: Icon(
                                  Icons.headphones,
                                  size: 40,
                                )),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    'Listening',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 5.0,
                                          color: Colors.black45,
                                          offset: Offset(2.0, 2.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QiblaCompass()),
                          );
                        },
                        child: Container(
                          // color: Colors.transparent,
                          height: 125,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.green[200]!, Colors.blue[400]!],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                // height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    // BoxShadow(
                                    //   color: Colors.black.withOpacity(0.3),
                                    //   spreadRadius: 2,
                                    //   blurRadius: 8,
                                    //   offset: Offset(0, 4),
                                    // ),
                                  ],
                                ),
                                child: ClipOval(
                                    child: Icon(
                                  Icons.location_on,
                                  size: 40,
                                )),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    'Qibla',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 5.0,
                                          color: Colors.black45,
                                          offset: Offset(2.0, 2.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QiblaCompass()),
                          );
                        },
                        child: Container(
                          // color: Colors.transparent,
                          height: 125,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.green[200]!, Colors.blue[400]!],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                // height: 20,
                                width: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    // BoxShadow(
                                    //   color: Colors.black.withOpacity(0.3),
                                    //   spreadRadius: 2,
                                    //   blurRadius: 8,
                                    //   offset: Offset(0, 4),
                                    // ),
                                  ],
                                ),
                                child: ClipOval(
                                    child: Icon(
                                  Icons.compass_calibration_outlined,
                                  size: 40,
                                )),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    'Qibla',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 5.0,
                                          color: Colors.black45,
                                          offset: Offset(2.0, 2.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _showPrayerTimesModal(context);
                        },
                        child: Container(
                          // color: Colors.transparent,
                          height: 125,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.green[200]!, Colors.blue[400]!],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                // height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    // BoxShadow(
                                    //   color: Colors.black.withOpacity(0.3),
                                    //   spreadRadius: 2,
                                    //   blurRadius: 8,
                                    //   offset: Offset(0, 4),
                                    // ),
                                  ],
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/quran.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    'Prayer',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 5.0,
                                          color: Colors.black45,
                                          offset: Offset(2.0, 2.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 150,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  void _showPrayerTimesModal(BuildContext context) {
    final prayerTimes = PrayerTimes.today(myCoordinates, params);

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  '--- Today\'s Prayer Times ---',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              _buildPrayerTimeTile('Fajr', prayerTimes.fajr),
              _buildPrayerTimeTile('Sunrise', prayerTimes.sunrise),
              _buildPrayerTimeTile('Dhuhr', prayerTimes.dhuhr),
              _buildPrayerTimeTile('Asr', prayerTimes.asr),
              _buildPrayerTimeTile('Maghrib', prayerTimes.maghrib),
              _buildPrayerTimeTile('Isha', prayerTimes.isha),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPrayerTimeTile(String name, DateTime time) {
    return ListTile(
      title: Text(
        name,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      trailing: Text(
        DateFormat.jm().format(time),
        style: TextStyle(fontSize: 18, color: Colors.black54),
      ),
    );
  }
}
