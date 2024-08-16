import 'package:flutter/material.dart';

class AllSurahsScreen extends StatelessWidget {
  // List of Surah names in the Quran
  final List<String> surahs = [
    'Al-Fatiha',
    'Al-Baqarah',
    'Aali Imran',
    'An-Nisa',
    'Al-Ma’idah',
    'Al-An’am',
    'Al-A’raf',
    'Al-Anfal',
    'At-Tawbah',
    'Yunus',
    'Hud',
    'Yusuf',
    'Ar-Ra’d',
    'Ibrahim',
    'Al-Hijr',
    'An-Nahl',
    'Al-Isra',
    'Al-Kahf',
    'Maryam',
    'Ta-Ha',
    'Al-Anbiya',
    'Al-Hajj',
    'Al-Mu’minun',
    'An-Nur',
    'Al-Furqan',
    'Ash-Shu’ara',
    'An-Naml',
    'Al-Ankabut',
    'Ar-Rum',
    'Luqman',
    'As-Sajda',
    'Al-Ahzab',
    'Saba',
    'Fatir',
    'Ya-Sin',
    'As-Saffat',
    'Sad',
    'Az-Zumar',
    'Ghafir',
    'Fussilat',
    'Ash-Shura',
    'Az-Zukhruf',
    'Ad-Dukhan',
    'Jathiya',
    'Ahqaf',
    'Muhammad',
    'Al-Fath',
    'Al-Hujurat',
    'Qaf',
    'Adh-Dhariyat',
    'At-Tur',
    'An-Najm',
    'Al-Qamar',
    'Ar-Rahman',
    'Al-Waqi’a',
    'Al-Hadid',
    'Al-Mujadila',
    'Al-Hashr',
    'Al-Mumtahina',
    'As-Saff',
    'Al-Jumu’a',
    'Al-Munafiqoon',
    'At-Taghabun',
    'At-Tahrim',
    'Al-Mulk',
    'Al-Qalam',
    'Al-Haaqqa',
    'Al-Ma’arij',
    'Nuh',
    'Jinn',
    'Muzzammil',
    'Muddathir',
    'Qiyama',
    'Insan',
    'Mursalat',
    'An-Naba',
    'An-Nazi’at',
    'Abasa',
    'At-Takwir',
    'Al-Infitar',
    'Al-Mutaffifin',
    'Al-Inshiqaq',
    'Al-Buruj',
    'At-Tariq',
    'Al-A’la',
    'Al-Ghashiya',
    'Al-Fajr',
    'Al-Balad',
    'Ash-Shams',
    'Al-Lail',
    'Ad-Duha',
    'Ash-Sharh',
    'At-Tin',
    'Al-Alaq',
    'Al-Qadr',
    'Al-Bayyina',
    'Az-Zalzalah',
    'Al-Adiyat',
    'Al-Qaria',
    'At-Takathur',
    'Al-Asr',
    'Al-Humazah',
    'Al-Fil',
    'Quraish',
    'Al-Ma’un',
    'Al-Kawthar',
    'Al-Kafirun',
    'An-Nasr',
    'Al-Masad',
    'Al-Ikhlas',
    'Al-Falaq',
    'An-Nas'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Surahs'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: surahs.length,
        itemBuilder: (context, index) {
          return _buildSurahTile(index + 1, surahs[index]);
        },
      ),
    );
  }

  Widget _buildSurahTile(int count, String surahName) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        // contentPadding: EdgeInsets.all(16.0),
        // leading: CircleAvatar(
        //   child: Text(
        //     '$count',
        //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        //   ),
        //   backgroundColor: Colors.teal,
        //   foregroundColor: Colors.white,
        // ),
        title: Text(
          surahName,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Handle tap to navigate to the Surah details or recitation page
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => SurahDetailScreen(surahName: surahName),
          //   ),
          // );
        },
      ),
    );
  }
}

class SurahDetailScreen extends StatelessWidget {
  final String surahName;

  const SurahDetailScreen({required this.surahName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(surahName),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Text(
          'Details for $surahName',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
