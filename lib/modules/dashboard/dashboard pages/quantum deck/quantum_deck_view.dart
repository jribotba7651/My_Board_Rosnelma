// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:my_board/imports.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/quantum%20deck/quantum_deck_controller.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/quantum_card_model.dart';
import '../../../../core/widgets/quantum_card_placeholder.dart';

class QuantumDeckView extends GetView<QuantumDeckController> {
  const QuantumDeckView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.scaffold2,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Get.height * 0.15,
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 8.0),
                      child: Row(
                        children: [
                          InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(Icons.arrow_back_ios)),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Quantum Deck",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: AppFonts.medium),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              controller.shuffleDeck();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.appColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "Shuffle",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: AppFonts.medium),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TabBar(
                      indicatorColor: AppColors.appColor,
                      labelColor: AppColors.appColor,
                      unselectedLabelColor: AppColors.greyColor,
                      tabs: [
                        Tab(text: "Daily"),
                        Tab(text: "Weekly"),
                        Tab(text: "Monthly"),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildTodaysCard(),
                    _buildCardGrid("weekly"),
                    _buildCardGrid("monthly"),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CommonBottomNav(currentModule: 'quantum'),
      ),
    );
  }

  Widget _buildTodaysCard() {
    final todaysCard = controller.getTodaysCard();

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Column(
              children: [
                Text(
                  'Today\'s Quantum Card',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontFamily: AppFonts.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  DateFormat('EEEE, MMMM d, yyyy').format(DateTime.now()),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontFamily: AppFonts.medium,
                  ),
                ),
              ],
            ),
          ),

          // Main card (larger and centered)
          Expanded(
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 350,
                  maxHeight: 500,
                ),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(Routes.quantumDeckDetail, arguments: todaysCard);
                  },
                  child: QuantumCardPlaceholder(
                    zodiacSign: _extractZodiacSign(todaysCard.title),
                    zodiacSymbol: _getZodiacSymbol(todaysCard.title),
                    planet: _extractPlanet(todaysCard.title),
                    keyword: todaysCard.description,
                    element: todaysCard.category,
                    width: 350,
                    height: 500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardGrid(String type) {
    return Obx(() {
      List<QuantumCardModel> cards = controller.getCardsForType(type);

      if (cards.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.auto_awesome,
                size: 64,
                color: AppColors.greyColor.withOpacity(0.5),
              ),
              SizedBox(height: 16),
              Text(
                "No ${type[0].toUpperCase()}${type.substring(1)} cards available",
                style: TextStyle(
                  color: AppColors.greyColor,
                  fontSize: 16,
                  fontFamily: AppFonts.medium,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Tap shuffle to generate new cards",
                style: TextStyle(
                  color: AppColors.greyColor.withOpacity(0.7),
                  fontSize: 14,
                  fontFamily: AppFonts.regular,
                ),
              ),
            ],
          ),
        );
      }

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.7,
          ),
          itemCount: cards.length,
          itemBuilder: (context, index) {
            final card = cards[index];
            return _buildQuantumCard(card);
          },
        ),
      );
    });
  }

  Widget _buildQuantumCard(QuantumCardModel card) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.quantumDeckDetail, arguments: card);
      },
      child: QuantumCardPlaceholder(
        zodiacSign: _extractZodiacSign(card.title),
        zodiacSymbol: _getZodiacSymbol(card.title),
        planet: _extractPlanet(card.title),
        keyword: card.description,
        element: card.category,
        width: 280,
        height: 400,
      ),
    );
  }


  String _extractZodiacSign(String title) {
    // Extract the first word from title as zodiac sign
    final words = title.split(' ');
    if (words.isNotEmpty) {
      return words.first;
    }
    return 'Aries';
  }

  String _getZodiacSymbol(String title) {
    final sign = _extractZodiacSign(title).toLowerCase();
    switch (sign) {
      case 'aries':
        return '♈';
      case 'taurus':
        return '♉';
      case 'gemini':
        return '♊';
      case 'cancer':
        return '♋';
      case 'leo':
        return '♌';
      case 'virgo':
        return '♍';
      case 'libra':
        return '♎';
      case 'scorpio':
        return '♏';
      case 'sagittarius':
        return '♐';
      case 'capricorn':
        return '♑';
      case 'aquarius':
        return '♒';
      case 'pisces':
        return '♓';
      default:
        return '♈';
    }
  }

  String _extractPlanet(String title) {
    // Extract planet name from title (usually after the zodiac sign)
    final words = title.toLowerCase().split(' ');

    final planets = ['sun', 'moon', 'mercury', 'venus', 'mars', 'jupiter', 'saturn', 'uranus', 'neptune', 'pluto'];

    for (final word in words) {
      if (planets.contains(word)) {
        return word[0].toUpperCase() + word.substring(1);
      }
    }

    // Default planet mapping based on zodiac sign
    final sign = _extractZodiacSign(title).toLowerCase();
    switch (sign) {
      case 'aries':
        return 'Mars';
      case 'taurus':
        return 'Venus';
      case 'gemini':
        return 'Mercury';
      case 'cancer':
        return 'Moon';
      case 'leo':
        return 'Sun';
      case 'virgo':
        return 'Mercury';
      case 'libra':
        return 'Venus';
      case 'scorpio':
        return 'Mars';
      case 'sagittarius':
        return 'Jupiter';
      case 'capricorn':
        return 'Saturn';
      case 'aquarius':
        return 'Uranus';
      case 'pisces':
        return 'Neptune';
      default:
        return 'Sun';
    }
  }

}

