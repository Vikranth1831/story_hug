import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Define card data based on your image.
class CardData {
  final String title;
  final String subtitle;
  final Color color;
  final String imageUrl;
  final String routeName;

  CardData({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.imageUrl,
    required this.routeName,
  });
}

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  static const String fontFamily = 'Arial Rounded MT Bold';

  final List<CardData> cards = [
    CardData(
      title: 'Indian Mythology & Divine Stories',
      subtitle: '',
      color: Color(0xFFF39AAF), // Pink shade in your image
      imageUrl: 'https://i.ibb.co/4m6M1Wg/indian-mythology.png',
      routeName: '/mythology',
    ),
    CardData(
      title: 'Indian Kings & Warriors Stories',
      subtitle: '',
      color: Color(0xFFFFE151), // Yellow shade from image
      imageUrl: 'https://i.ibb.co/WpxHjMj/indian-kings.png',
      routeName: '/kings',
    ),
    CardData(
      title: 'Motivational & Success Stories',
      subtitle: '',
      color: Color(0xFFF9F2E4), // Beige shade from image
      imageUrl: 'https://i.ibb.co/6Hs4Wmj/motivational.png',
      routeName: '/motivational',
    ),
    CardData(
      title: 'Great Inventions & Inventors',
      subtitle: '',
      color: Color(0xFFCBD3F7), // Lavender shade from image
      imageUrl: 'https://i.ibb.co/XYszbYF/inventions.png',
      routeName: '/inventions',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Responsive grid columns
    int crossAxisCount = MediaQuery.of(context).size.width > 600 ? 4 : 2;

    final bgColor = Color(0xFFF9F2E4); // Use the image bg color (light beige)

    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(110),
        child: AppBar(
          backgroundColor: bgColor,
          elevation: 0,
          titleSpacing: 0,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Column(
              children: [
                Text(
                  'Hello',
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Vikrant',
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 44,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
        child: GridView.builder(
          itemCount: cards.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 0.97,
          ),
          itemBuilder: (context, index) {
            final card = cards[index];
            return InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () {
                context.push(card.routeName); // GoRouter navigation
              },
              child: Container(
                decoration: BoxDecoration(
                  color: card.color,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            card.imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image, size: 80, color: Colors.grey.shade300),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 8),
                        child: Text(
                          card.title,
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.black,
                            height: 1.15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
