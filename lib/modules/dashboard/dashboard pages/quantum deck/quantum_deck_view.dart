// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:my_board/global_controllers/global_controller.dart';
import 'package:my_board/imports.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/quantum%20deck/quantum_deck_controller.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/quantum%20deck/quantum_deck_detail.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/quantum_card_model.dart';

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
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: _getCardColors(todaysCard.category),
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.25),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  todaysCard.category.toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: AppFonts.bold,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                              Icon(
                                _getCategoryIcon(todaysCard.category),
                                color: Colors.white.withOpacity(0.9),
                                size: 28,
                              ),
                            ],
                          ),

                          Spacer(),

                          Text(
                            todaysCard.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontFamily: AppFonts.bold,
                              height: 1.2,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),

                          SizedBox(height: 16),

                          Text(
                            todaysCard.description,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.95),
                              fontSize: 16,
                              fontFamily: AppFonts.medium,
                              height: 1.4,
                            ),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),

                          Spacer(),

                          Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                color: Colors.white.withOpacity(0.8),
                                size: 18,
                              ),
                              SizedBox(width: 6),
                              Text(
                                "${todaysCard.estimatedTime} minutes",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 14,
                                  fontFamily: AppFonts.medium,
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  todaysCard.difficulty,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: AppFonts.medium,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _getCardColors(card.category),
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      card.category,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontFamily: AppFonts.medium,
                      ),
                    ),
                  ),
                  Icon(
                    _getCategoryIcon(card.category),
                    color: Colors.white.withOpacity(0.8),
                    size: 20,
                  ),
                ],
              ),
              Spacer(),
              Text(
                card.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: AppFonts.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8),
              Text(
                card.description,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 12,
                  fontFamily: AppFonts.regular,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              Spacer(),
              Row(
                children: [
                  Icon(
                    Icons.schedule,
                    color: Colors.white.withOpacity(0.7),
                    size: 14,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "${card.estimatedTime} min",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 12,
                      fontFamily: AppFonts.regular,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Color> _getCardColors(String category) {
    switch (category.toLowerCase()) {
      case 'fire':
        return [Color(0xFFFF6B35), Color(0xFFFF8E53)];
      case 'earth':
        return [Color(0xFF6B5B95), Color(0xFF88D8C0)];
      case 'air':
        return [Color(0xFF4facfe), Color(0xFF00f2fe)];
      case 'water':
        return [Color(0xFF43e97b), Color(0xFF38f9d7)];
      case 'spirit':
        return [Color(0xFFfa709a), Color(0xFFfee140)];
      default:
        return [Color(0xFF667eea), Color(0xFF764ba2)];
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'fire':
        return Icons.local_fire_department;
      case 'earth':
        return Icons.terrain;
      case 'air':
        return Icons.air;
      case 'water':
        return Icons.water_drop;
      case 'spirit':
        return Icons.auto_awesome;
      default:
        return Icons.auto_awesome;
    }
  }

}

