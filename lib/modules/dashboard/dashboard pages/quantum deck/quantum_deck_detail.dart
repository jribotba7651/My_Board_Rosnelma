// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:my_board/imports.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/quantum%20deck/quantum_deck_controller.dart';
import '../../../../data/models/quantum_card_model.dart';

class QuantumDeckDetail extends GetView<QuantumDeckController> {
  final QuantumCardModel card;

  const QuantumDeckDetail({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold2,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with gradient background
              Container(
                height: Get.height * 0.3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: _getCardColors(card.category),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () => Get.back(),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              card.category,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: AppFonts.medium,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(
                        _getCategoryIcon(card.category),
                        color: Colors.white.withOpacity(0.9),
                        size: 48,
                      ),
                      SizedBox(height: 16),
                      Text(
                        card.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontFamily: AppFonts.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        card.description,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 16,
                          fontFamily: AppFonts.regular,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Content sections
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Card Info
                    _buildInfoSection(),

                    SizedBox(height: 24),

                    // Instructions Section
                    _buildInstructionsSection(),

                    SizedBox(height: 24),

                    // Benefits Section
                    _buildBenefitsSection(),

                    SizedBox(height: 24),

                    // Tags Section
                    _buildTagsSection(),

                    SizedBox(height: 32),

                    // Complete Button
                    _buildCompleteButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.schedule, color: AppColors.appColor, size: 20),
              SizedBox(width: 8),
              Text(
                "Duration",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: AppFonts.medium,
                ),
              ),
              Spacer(),
              Text(
                card.getFormattedTime(),
                style: TextStyle(
                  color: AppColors.greyColor,
                  fontSize: 14,
                  fontFamily: AppFonts.regular,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.signal_cellular_alt, color: AppColors.appColor, size: 20),
              SizedBox(width: 8),
              Text(
                "Difficulty",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: AppFonts.medium,
                ),
              ),
              Spacer(),
              Row(
                children: List.generate(3, (index) {
                  return Icon(
                    Icons.circle,
                    size: 8,
                    color: index < card.getDifficultyLevel()
                        ? AppColors.appColor
                        : AppColors.greyColor.withOpacity(0.3),
                  );
                }),
              ),
              SizedBox(width: 8),
              Text(
                card.difficulty,
                style: TextStyle(
                  color: AppColors.greyColor,
                  fontSize: 14,
                  fontFamily: AppFonts.regular,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.calendar_today, color: AppColors.appColor, size: 20),
              SizedBox(width: 8),
              Text(
                "Period",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: AppFonts.medium,
                ),
              ),
              Spacer(),
              Text(
                "${card.period[0].toUpperCase()}${card.period.substring(1)}",
                style: TextStyle(
                  color: AppColors.greyColor,
                  fontSize: 14,
                  fontFamily: AppFonts.regular,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "How to do it",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: AppFonts.bold,
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: card.instructions.asMap().entries.map((entry) {
              int index = entry.key;
              String instruction = entry.value;
              return Padding(
                padding: EdgeInsets.only(bottom: index == card.instructions.length - 1 ? 0 : 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: AppColors.appColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          "${index + 1}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: AppFonts.medium,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        instruction,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: AppFonts.regular,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildBenefitsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Benefits",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: AppFonts.bold,
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: card.benefits.asMap().entries.map((entry) {
              int index = entry.key;
              String benefit = entry.value;
              return Padding(
                padding: EdgeInsets.only(bottom: index == card.benefits.length - 1 ? 0 : 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 20,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        benefit,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: AppFonts.regular,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTagsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tags",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: AppFonts.bold,
          ),
        ),
        SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: card.tags.map((tag) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.appColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.appColor.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Text(
                tag,
                style: TextStyle(
                  color: AppColors.appColor,
                  fontSize: 12,
                  fontFamily: AppFonts.medium,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCompleteButton() {
    return Obx(() {
      bool isCompleted = card.isCompleted;

      return InkWell(
        onTap: isCompleted ? null : () {
          controller.markCardAsCompleted(card.id);
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            gradient: isCompleted
                ? LinearGradient(
                    colors: [Colors.green, Colors.green.withOpacity(0.8)],
                  )
                : LinearGradient(
                    colors: _getCardColors(card.category),
                  ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: (isCompleted ? Colors.green : _getCardColors(card.category)[0])
                    .withOpacity(0.3),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isCompleted ? Icons.check_circle : Icons.play_arrow,
                color: Colors.white,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                isCompleted ? "Completed!" : "Mark as Completed",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: AppFonts.bold,
                ),
              ),
            ],
          ),
        ),
      );
    });
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

