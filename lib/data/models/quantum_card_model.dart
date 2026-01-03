// ignore_for_file: prefer_collection_literals

import 'dart:ui';

enum ZodiacElement {
  fire,
  earth,
  air,
  water,
}

class QuantumCard {
  String? id;
  String? zodiacSign;
  ZodiacElement? element;
  String? symbol;
  String? actionES;
  String? actionEN;
  List<String>? keywordsES;
  List<String>? keywordsEN;
  String? affirmationES;
  String? affirmationEN;
  String? imageUrl;

  QuantumCard({
    this.id,
    this.zodiacSign,
    this.element,
    this.symbol,
    this.actionES,
    this.actionEN,
    this.keywordsES,
    this.keywordsEN,
    this.affirmationES,
    this.affirmationEN,
    this.imageUrl,
  });

  QuantumCard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    zodiacSign = json['zodiacSign'];
    element = _elementFromString(json['element']);
    symbol = json['symbol'];
    actionES = json['actionES'];
    actionEN = json['actionEN'];
    keywordsES = json['keywordsES']?.cast<String>();
    keywordsEN = json['keywordsEN']?.cast<String>();
    affirmationES = json['affirmationES'];
    affirmationEN = json['affirmationEN'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['zodiacSign'] = zodiacSign;
    data['element'] = _elementToString(element);
    data['symbol'] = symbol;
    data['actionES'] = actionES;
    data['actionEN'] = actionEN;
    data['keywordsES'] = keywordsES;
    data['keywordsEN'] = keywordsEN;
    data['affirmationES'] = affirmationES;
    data['affirmationEN'] = affirmationEN;
    data['imageUrl'] = imageUrl;
    return data;
  }

  String get elementEmoji {
    switch (element) {
      case ZodiacElement.fire:
        return '🔥';
      case ZodiacElement.earth:
        return '🌍';
      case ZodiacElement.air:
        return '💨';
      case ZodiacElement.water:
        return '💧';
      default:
        return '⭐';
    }
  }

  Color get elementColor {
    switch (element) {
      case ZodiacElement.fire:
        return const Color(0xFFFF6B35);
      case ZodiacElement.earth:
        return const Color(0xFF8B4513);
      case ZodiacElement.air:
        return const Color(0xFF87CEEB);
      case ZodiacElement.water:
        return const Color(0xFF4169E1);
      default:
        return const Color(0xFF666666);
    }
  }

  ZodiacElement? _elementFromString(String? elementString) {
    switch (elementString?.toLowerCase()) {
      case 'fire':
        return ZodiacElement.fire;
      case 'earth':
        return ZodiacElement.earth;
      case 'air':
        return ZodiacElement.air;
      case 'water':
        return ZodiacElement.water;
      default:
        return null;
    }
  }

  String? _elementToString(ZodiacElement? element) {
    switch (element) {
      case ZodiacElement.fire:
        return 'fire';
      case ZodiacElement.earth:
        return 'earth';
      case ZodiacElement.air:
        return 'air';
      case ZodiacElement.water:
        return 'water';
      default:
        return null;
    }
  }

  static List<QuantumCard> get allCards => [
    // FUEGO 🔥 - ARIES (12 cartas)
    QuantumCard(
      id: 'aries_01',
      zodiacSign: 'Aries',
      element: ZodiacElement.fire,
      symbol: '♈',
      actionES: 'Iniciar',
      actionEN: 'Initiate',
      keywordsES: ['Liderazgo', 'Energía', 'Pionero'],
      keywordsEN: ['Leadership', 'Energy', 'Pioneer'],
      affirmationES: 'Soy el líder de mi propio destino',
      affirmationEN: 'I am the leader of my own destiny',
      imageUrl: 'assets/images/quantum_deck/aries_01.png',
    ),
    QuantumCard(
      id: 'aries_02',
      zodiacSign: 'Aries',
      element: ZodiacElement.fire,
      symbol: '♈',
      actionES: 'Liderar',
      actionEN: 'Lead',
      keywordsES: ['Valentía', 'Acción', 'Impulso'],
      keywordsEN: ['Courage', 'Action', 'Drive'],
      affirmationES: 'Tengo el valor de tomar decisiones audaces',
      affirmationEN: 'I have the courage to make bold decisions',
      imageUrl: 'assets/images/quantum_deck/aries_02.png',
    ),
    QuantumCard(
      id: 'aries_03',
      zodiacSign: 'Aries',
      element: ZodiacElement.fire,
      symbol: '♈',
      actionES: 'Emprender',
      actionEN: 'Venture',
      keywordsES: ['Innovación', 'Fuerza', 'Determinación'],
      keywordsEN: ['Innovation', 'Strength', 'Determination'],
      affirmationES: 'Mi determinación me lleva al éxito',
      affirmationEN: 'My determination leads me to success',
      imageUrl: 'assets/images/quantum_deck/aries_03.png',
    ),

    // FUEGO 🔥 - LEO (12 cartas)
    QuantumCard(
      id: 'leo_01',
      zodiacSign: 'Leo',
      element: ZodiacElement.fire,
      symbol: '♌',
      actionES: 'Brillar',
      actionEN: 'Shine',
      keywordsES: ['Creatividad', 'Confianza', 'Carisma'],
      keywordsEN: ['Creativity', 'Confidence', 'Charisma'],
      affirmationES: 'Brillo con mi luz interior auténtica',
      affirmationEN: 'I shine with my authentic inner light',
      imageUrl: 'assets/images/quantum_deck/leo_01.png',
    ),
    QuantumCard(
      id: 'leo_02',
      zodiacSign: 'Leo',
      element: ZodiacElement.fire,
      symbol: '♌',
      actionES: 'Crear',
      actionEN: 'Create',
      keywordsES: ['Expresión', 'Generosidad', 'Drama'],
      keywordsEN: ['Expression', 'Generosity', 'Drama'],
      affirmationES: 'Mi creatividad es ilimitada y poderosa',
      affirmationEN: 'My creativity is limitless and powerful',
      imageUrl: 'assets/images/quantum_deck/leo_02.png',
    ),
    QuantumCard(
      id: 'leo_03',
      zodiacSign: 'Leo',
      element: ZodiacElement.fire,
      symbol: '♌',
      actionES: 'Inspirar',
      actionEN: 'Inspire',
      keywordsES: ['Nobleza', 'Lealtad', 'Magnetismo'],
      keywordsEN: ['Nobility', 'Loyalty', 'Magnetism'],
      affirmationES: 'Inspiro a otros con mi presencia auténtica',
      affirmationEN: 'I inspire others with my authentic presence',
      imageUrl: 'assets/images/quantum_deck/leo_03.png',
    ),

    // FUEGO 🔥 - SAGITARIO (12 cartas)
    QuantumCard(
      id: 'sagittarius_01',
      zodiacSign: 'Sagitario',
      element: ZodiacElement.fire,
      symbol: '♐',
      actionES: 'Explorar',
      actionEN: 'Explore',
      keywordsES: ['Aventura', 'Sabiduría', 'Libertad'],
      keywordsEN: ['Adventure', 'Wisdom', 'Freedom'],
      affirmationES: 'Exploro el mundo con curiosidad infinita',
      affirmationEN: 'I explore the world with infinite curiosity',
      imageUrl: 'assets/images/quantum_deck/sagittarius_01.png',
    ),
    QuantumCard(
      id: 'sagittarius_02',
      zodiacSign: 'Sagitario',
      element: ZodiacElement.fire,
      symbol: '♐',
      actionES: 'Expandir',
      actionEN: 'Expand',
      keywordsES: ['Filosofía', 'Optimismo', 'Viaje'],
      keywordsEN: ['Philosophy', 'Optimism', 'Journey'],
      affirmationES: 'Expando mis horizontes constantemente',
      affirmationEN: 'I constantly expand my horizons',
      imageUrl: 'assets/images/quantum_deck/sagittarius_02.png',
    ),
    QuantumCard(
      id: 'sagittarius_03',
      zodiacSign: 'Sagitario',
      element: ZodiacElement.fire,
      symbol: '♐',
      actionES: 'Enseñar',
      actionEN: 'Teach',
      keywordsES: ['Conocimiento', 'Verdad', 'Crecimiento'],
      keywordsEN: ['Knowledge', 'Truth', 'Growth'],
      affirmationES: 'Comparto mi sabiduría con generosidad',
      affirmationEN: 'I share my wisdom generously',
      imageUrl: 'assets/images/quantum_deck/sagittarius_03.png',
    ),

    // TIERRA 🌍 - TAURO (10 cartas)
    QuantumCard(
      id: 'taurus_01',
      zodiacSign: 'Tauro',
      element: ZodiacElement.earth,
      symbol: '♉',
      actionES: 'Construir',
      actionEN: 'Build',
      keywordsES: ['Estabilidad', 'Perseverancia', 'Belleza'],
      keywordsEN: ['Stability', 'Perseverance', 'Beauty'],
      affirmationES: 'Construyo mi vida sobre bases sólidas',
      affirmationEN: 'I build my life on solid foundations',
      imageUrl: 'assets/images/quantum_deck/taurus_01.png',
    ),
    QuantumCard(
      id: 'taurus_02',
      zodiacSign: 'Tauro',
      element: ZodiacElement.earth,
      symbol: '♉',
      actionES: 'Cultivar',
      actionEN: 'Cultivate',
      keywordsES: ['Paciencia', 'Sensualidad', 'Abundancia'],
      keywordsEN: ['Patience', 'Sensuality', 'Abundance'],
      affirmationES: 'Cultivo la abundancia en mi vida',
      affirmationEN: 'I cultivate abundance in my life',
      imageUrl: 'assets/images/quantum_deck/taurus_02.png',
    ),
    QuantumCard(
      id: 'taurus_03',
      zodiacSign: 'Tauro',
      element: ZodiacElement.earth,
      symbol: '♉',
      actionES: 'Disfrutar',
      actionEN: 'Enjoy',
      keywordsES: ['Placer', 'Confort', 'Materialidad'],
      keywordsEN: ['Pleasure', 'Comfort', 'Materiality'],
      affirmationES: 'Disfruto los placeres simples de la vida',
      affirmationEN: 'I enjoy the simple pleasures of life',
      imageUrl: 'assets/images/quantum_deck/taurus_03.png',
    ),

    // TIERRA 🌍 - VIRGO (10 cartas)
    QuantumCard(
      id: 'virgo_01',
      zodiacSign: 'Virgo',
      element: ZodiacElement.earth,
      symbol: '♍',
      actionES: 'Perfeccionar',
      actionEN: 'Perfect',
      keywordsES: ['Precisión', 'Servicio', 'Análisis'],
      keywordsEN: ['Precision', 'Service', 'Analysis'],
      affirmationES: 'Perfecciono mi ser con dedicación',
      affirmationEN: 'I perfect my being with dedication',
      imageUrl: 'assets/images/quantum_deck/virgo_01.png',
    ),
    QuantumCard(
      id: 'virgo_02',
      zodiacSign: 'Virgo',
      element: ZodiacElement.earth,
      symbol: '♍',
      actionES: 'Organizar',
      actionEN: 'Organize',
      keywordsES: ['Orden', 'Eficiencia', 'Detalle'],
      keywordsEN: ['Order', 'Efficiency', 'Detail'],
      affirmationES: 'Organizo mi vida con propósito claro',
      affirmationEN: 'I organize my life with clear purpose',
      imageUrl: 'assets/images/quantum_deck/virgo_02.png',
    ),
    QuantumCard(
      id: 'virgo_03',
      zodiacSign: 'Virgo',
      element: ZodiacElement.earth,
      symbol: '♍',
      actionES: 'Sanar',
      actionEN: 'Heal',
      keywordsES: ['Purificación', 'Humildad', 'Cuidado'],
      keywordsEN: ['Purification', 'Humility', 'Care'],
      affirmationES: 'Sano y mejoro todo lo que toco',
      affirmationEN: 'I heal and improve everything I touch',
      imageUrl: 'assets/images/quantum_deck/virgo_03.png',
    ),

    // TIERRA 🌍 - CAPRICORNIO (10 cartas)
    QuantumCard(
      id: 'capricorn_01',
      zodiacSign: 'Capricornio',
      element: ZodiacElement.earth,
      symbol: '♑',
      actionES: 'Lograr',
      actionEN: 'Achieve',
      keywordsES: ['Ambición', 'Disciplina', 'Responsabilidad'],
      keywordsEN: ['Ambition', 'Discipline', 'Responsibility'],
      affirmationES: 'Logro mis metas con disciplina férrea',
      affirmationEN: 'I achieve my goals with iron discipline',
      imageUrl: 'assets/images/quantum_deck/capricorn_01.png',
    ),
    QuantumCard(
      id: 'capricorn_02',
      zodiacSign: 'Capricornio',
      element: ZodiacElement.earth,
      symbol: '♑',
      actionES: 'Estructurar',
      actionEN: 'Structure',
      keywordsES: ['Autoridad', 'Tradición', 'Persistencia'],
      keywordsEN: ['Authority', 'Tradition', 'Persistence'],
      affirmationES: 'Estructuro mi camino hacia el éxito',
      affirmationEN: 'I structure my path to success',
      imageUrl: 'assets/images/quantum_deck/capricorn_02.png',
    ),
    QuantumCard(
      id: 'capricorn_03',
      zodiacSign: 'Capricornio',
      element: ZodiacElement.earth,
      symbol: '♑',
      actionES: 'Escalar',
      actionEN: 'Climb',
      keywordsES: ['Montaña', 'Maestría', 'Legado'],
      keywordsEN: ['Mountain', 'Mastery', 'Legacy'],
      affirmationES: 'Escalo cada montaña con determinación',
      affirmationEN: 'I climb every mountain with determination',
      imageUrl: 'assets/images/quantum_deck/capricorn_03.png',
    ),

    // AIRE 💨 - GÉMINIS (9 cartas)
    QuantumCard(
      id: 'gemini_01',
      zodiacSign: 'Géminis',
      element: ZodiacElement.air,
      symbol: '♊',
      actionES: 'Comunicar',
      actionEN: 'Communicate',
      keywordsES: ['Versatilidad', 'Curiosidad', 'Adaptación'],
      keywordsEN: ['Versatility', 'Curiosity', 'Adaptation'],
      affirmationES: 'Comunico mis ideas con claridad brillante',
      affirmationEN: 'I communicate my ideas with brilliant clarity',
      imageUrl: 'assets/images/quantum_deck/gemini_01.png',
    ),
    QuantumCard(
      id: 'gemini_02',
      zodiacSign: 'Géminis',
      element: ZodiacElement.air,
      symbol: '♊',
      actionES: 'Conectar',
      actionEN: 'Connect',
      keywordsES: ['Dualidad', 'Ingenio', 'Rapidez'],
      keywordsEN: ['Duality', 'Wit', 'Speed'],
      affirmationES: 'Conecto ideas y personas con facilidad',
      affirmationEN: 'I connect ideas and people with ease',
      imageUrl: 'assets/images/quantum_deck/gemini_02.png',
    ),
    QuantumCard(
      id: 'gemini_03',
      zodiacSign: 'Géminis',
      element: ZodiacElement.air,
      symbol: '♊',
      actionES: 'Aprender',
      actionEN: 'Learn',
      keywordsES: ['Información', 'Flexibilidad', 'Juventud'],
      keywordsEN: ['Information', 'Flexibility', 'Youth'],
      affirmationES: 'Aprendo algo nuevo cada día',
      affirmationEN: 'I learn something new every day',
      imageUrl: 'assets/images/quantum_deck/gemini_03.png',
    ),

    // AIRE 💨 - LIBRA (9 cartas)
    QuantumCard(
      id: 'libra_01',
      zodiacSign: 'Libra',
      element: ZodiacElement.air,
      symbol: '♎',
      actionES: 'Equilibrar',
      actionEN: 'Balance',
      keywordsES: ['Armonía', 'Justicia', 'Diplomacia'],
      keywordsEN: ['Harmony', 'Justice', 'Diplomacy'],
      affirmationES: 'Equilibro todas las áreas de mi vida',
      affirmationEN: 'I balance all areas of my life',
      imageUrl: 'assets/images/quantum_deck/libra_01.png',
    ),
    QuantumCard(
      id: 'libra_02',
      zodiacSign: 'Libra',
      element: ZodiacElement.air,
      symbol: '♎',
      actionES: 'Relacionar',
      actionEN: 'Relate',
      keywordsES: ['Partnership', 'Belleza', 'Cooperación'],
      keywordsEN: ['Partnership', 'Beauty', 'Cooperation'],
      affirmationES: 'Me relaciono con otros en perfecta armonía',
      affirmationEN: 'I relate to others in perfect harmony',
      imageUrl: 'assets/images/quantum_deck/libra_02.png',
    ),
    QuantumCard(
      id: 'libra_03',
      zodiacSign: 'Libra',
      element: ZodiacElement.air,
      symbol: '♎',
      actionES: 'Mediar',
      actionEN: 'Mediate',
      keywordsES: ['Paz', 'Estética', 'Refinamiento'],
      keywordsEN: ['Peace', 'Aesthetics', 'Refinement'],
      affirmationES: 'Mediano conflictos con sabiduría y gracia',
      affirmationEN: 'I mediate conflicts with wisdom and grace',
      imageUrl: 'assets/images/quantum_deck/libra_03.png',
    ),

    // AIRE 💨 - ACUARIO (9 cartas)
    QuantumCard(
      id: 'aquarius_01',
      zodiacSign: 'Acuario',
      element: ZodiacElement.air,
      symbol: '♒',
      actionES: 'Innovar',
      actionEN: 'Innovate',
      keywordsES: ['Originalidad', 'Humanidad', 'Revolución'],
      keywordsEN: ['Originality', 'Humanity', 'Revolution'],
      affirmationES: 'Innovo para crear un mundo mejor',
      affirmationEN: 'I innovate to create a better world',
      imageUrl: 'assets/images/quantum_deck/aquarius_01.png',
    ),
    QuantumCard(
      id: 'aquarius_02',
      zodiacSign: 'Acuario',
      element: ZodiacElement.air,
      symbol: '♒',
      actionES: 'Liberar',
      actionEN: 'Free',
      keywordsES: ['Independencia', 'Fraternidad', 'Futuro'],
      keywordsEN: ['Independence', 'Brotherhood', 'Future'],
      affirmationES: 'Libero mi mente de limitaciones',
      affirmationEN: 'I free my mind from limitations',
      imageUrl: 'assets/images/quantum_deck/aquarius_02.png',
    ),
    QuantumCard(
      id: 'aquarius_03',
      zodiacSign: 'Acuario',
      element: ZodiacElement.air,
      symbol: '♒',
      actionES: 'Transformar',
      actionEN: 'Transform',
      keywordsES: ['Tecnología', 'Amistad', 'Progreso'],
      keywordsEN: ['Technology', 'Friendship', 'Progress'],
      affirmationES: 'Transformo la realidad con mi visión',
      affirmationEN: 'I transform reality with my vision',
      imageUrl: 'assets/images/quantum_deck/aquarius_03.png',
    ),

    // AGUA 💧 - CÁNCER (9 cartas)
    QuantumCard(
      id: 'cancer_01',
      zodiacSign: 'Cáncer',
      element: ZodiacElement.water,
      symbol: '♋',
      actionES: 'Nutrir',
      actionEN: 'Nurture',
      keywordsES: ['Protección', 'Intuición', 'Hogar'],
      keywordsEN: ['Protection', 'Intuition', 'Home'],
      affirmationES: 'Nutro todo lo que amo con ternura',
      affirmationEN: 'I nurture everything I love with tenderness',
      imageUrl: 'assets/images/quantum_deck/cancer_01.png',
    ),
    QuantumCard(
      id: 'cancer_02',
      zodiacSign: 'Cáncer',
      element: ZodiacElement.water,
      symbol: '♋',
      actionES: 'Sentir',
      actionEN: 'Feel',
      keywordsES: ['Emociones', 'Memoria', 'Familia'],
      keywordsEN: ['Emotions', 'Memory', 'Family'],
      affirmationES: 'Siento profundamente y amo sin límites',
      affirmationEN: 'I feel deeply and love without limits',
      imageUrl: 'assets/images/quantum_deck/cancer_02.png',
    ),
    QuantumCard(
      id: 'cancer_03',
      zodiacSign: 'Cáncer',
      element: ZodiacElement.water,
      symbol: '♋',
      actionES: 'Cuidar',
      actionEN: 'Care',
      keywordsES: ['Maternal', 'Seguridad', 'Tradición'],
      keywordsEN: ['Maternal', 'Security', 'Tradition'],
      affirmationES: 'Cuido de otros como un refugio seguro',
      affirmationEN: 'I care for others as a safe haven',
      imageUrl: 'assets/images/quantum_deck/cancer_03.png',
    ),

    // AGUA 💧 - ESCORPIO (9 cartas)
    QuantumCard(
      id: 'scorpio_01',
      zodiacSign: 'Escorpio',
      element: ZodiacElement.water,
      symbol: '♏',
      actionES: 'Transformar',
      actionEN: 'Transform',
      keywordsES: ['Intensidad', 'Misterio', 'Poder'],
      keywordsEN: ['Intensity', 'Mystery', 'Power'],
      affirmationES: 'Me transformo constantemente hacia mi verdad',
      affirmationEN: 'I constantly transform toward my truth',
      imageUrl: 'assets/images/quantum_deck/scorpio_01.png',
    ),
    QuantumCard(
      id: 'scorpio_02',
      zodiacSign: 'Escorpio',
      element: ZodiacElement.water,
      symbol: '♏',
      actionES: 'Regenerar',
      actionEN: 'Regenerate',
      keywordsES: ['Profundidad', 'Pasión', 'Secretos'],
      keywordsEN: ['Depth', 'Passion', 'Secrets'],
      affirmationES: 'Me regenero como el ave fénix',
      affirmationEN: 'I regenerate like the phoenix',
      imageUrl: 'assets/images/quantum_deck/scorpio_02.png',
    ),
    QuantumCard(
      id: 'scorpio_03',
      zodiacSign: 'Escorpio',
      element: ZodiacElement.water,
      symbol: '♏',
      actionES: 'Investigar',
      actionEN: 'Investigate',
      keywordsES: ['Psicología', 'Renacimiento', 'Magnetismo'],
      keywordsEN: ['Psychology', 'Rebirth', 'Magnetism'],
      affirmationES: 'Investigo los misterios de la existencia',
      affirmationEN: 'I investigate the mysteries of existence',
      imageUrl: 'assets/images/quantum_deck/scorpio_03.png',
    ),

    // AGUA 💧 - PISCIS (9 cartas)
    QuantumCard(
      id: 'pisces_01',
      zodiacSign: 'Piscis',
      element: ZodiacElement.water,
      symbol: '♓',
      actionES: 'Soñar',
      actionEN: 'Dream',
      keywordsES: ['Imaginación', 'Compasión', 'Espiritualidad'],
      keywordsEN: ['Imagination', 'Compassion', 'Spirituality'],
      affirmationES: 'Sueño y materializo mis visiones',
      affirmationEN: 'I dream and materialize my visions',
      imageUrl: 'assets/images/quantum_deck/pisces_01.png',
    ),
    QuantumCard(
      id: 'pisces_02',
      zodiacSign: 'Piscis',
      element: ZodiacElement.water,
      symbol: '♓',
      actionES: 'Fluir',
      actionEN: 'Flow',
      keywordsES: ['Intuición', 'Arte', 'Sacrificio'],
      keywordsEN: ['Intuition', 'Art', 'Sacrifice'],
      affirmationES: 'Fluyo con la corriente universal',
      affirmationEN: 'I flow with the universal current',
      imageUrl: 'assets/images/quantum_deck/pisces_02.png',
    ),
    QuantumCard(
      id: 'pisces_03',
      zodiacSign: 'Piscis',
      element: ZodiacElement.water,
      symbol: '♓',
      actionES: 'Trascender',
      actionEN: 'Transcend',
      keywordsES: ['Misticismo', 'Unidad', 'Sanación'],
      keywordsEN: ['Mysticism', 'Unity', 'Healing'],
      affirmationES: 'Trascienda los límites de lo ordinario',
      affirmationEN: 'I transcend the limits of the ordinary',
      imageUrl: 'assets/images/quantum_deck/pisces_03.png',
    ),
  ];

  // Helper methods for filtering
  static List<QuantumCard> getCardsByElement(ZodiacElement element) {
    return allCards.where((card) => card.element == element).toList();
  }

  static List<QuantumCard> getCardsBySign(String zodiacSign) {
    return allCards.where((card) => card.zodiacSign == zodiacSign).toList();
  }

  static QuantumCard? getRandomCard() {
    if (allCards.isNotEmpty) {
      final random = DateTime.now().millisecondsSinceEpoch % allCards.length;
      return allCards[random];
    }
    return null;
  }
}