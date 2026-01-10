// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:my_board/global_controllers/global_controller.dart';
import 'package:my_board/imports.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/quantum%20deck/quantum_deck_controller.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/quantum%20deck/quantum_deck_detail.dart';

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
                    _buildCardGrid("daily"),
                    _buildCardGrid("weekly"),
                    _buildCardGrid("monthly"),
                  ],
                ),
              ),
            ],
          ),
        ),
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
      case 'mindfulness':
        return [Color(0xFF667eea), Color(0xFF764ba2)];
      case 'creativity':
        return [Color(0xFFf093fb), Color(0xFFf5576c)];
      case 'focus':
        return [Color(0xFF4facfe), Color(0xFF00f2fe)];
      case 'wellness':
        return [Color(0xFF43e97b), Color(0xFF38f9d7)];
      case 'reflection':
        return [Color(0xFFfa709a), Color(0xFFfee140)];
      default:
        return [Color(0xFF667eea), Color(0xFF764ba2)];
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'mindfulness':
        return Icons.spa;
      case 'creativity':
        return Icons.palette;
      case 'focus':
        return Icons.center_focus_strong;
      case 'wellness':
        return Icons.favorite;
      case 'reflection':
        return Icons.psychology;
      default:
        return Icons.auto_awesome;
    }
  }
}

