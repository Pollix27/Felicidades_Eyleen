import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const BirthdayCardApp());
}

class BirthdayCardApp extends StatelessWidget {
  const BirthdayCardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Felicidades Eyleen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Georgia',
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with TickerProviderStateMixin {
  late AnimationController _illuminationController;
  late Animation<double> _illuminationAnimation;
  int _currentLetter = 0;

  @override
  void initState() {
    super.initState();
    _illuminationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _illuminationAnimation = Tween<double>(
      begin: 0.0,
      end: 15.0, // letras en "FELICIDADES"
    ).animate(CurvedAnimation(
      parent: _illuminationController,
      curve: Curves.easeInOut,
    ));

    _illuminationAnimation.addListener(() {
      setState(() {
        _currentLetter = _illuminationAnimation.value.floor();
      });
    });

    // Iniciar animación automáticamente
    _startIllumination();
  }

  void _startIllumination() {
    _illuminationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _illuminationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1a1a2e),
              Color(0xFF16213e),
              Color(0xFF0f0f23),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Título animado "FELICIDADES"
              _buildAnimatedTitle(),
              const SizedBox(height: 80),

              // Texto celebrativo
              const Text(
                '🎉🎂🌟 Que te la pases muy bien 🎁🥳🎈',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white70,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              // Botón para ver la carta
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                      const BirthdayCardPage(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 700),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8A2BE2),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 8,
                ),
                child: const Text(
                  '¡Presiona aquí para ver la sorpresa!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 50),

              // Información del autor
              Column(
                children: [
                  Text(
                    '© Viernes, 23 de Agosto de 2024',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '© Miguel Angel Martin Meza',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white.withOpacity(0.6),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    'Version 2.1.3',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white.withOpacity(0.6),
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

  Widget _buildAnimatedTitle() {
    const letters = ['♥️',' ','F', 'E', 'L', 'I', 'C', 'I', 'D', 'A', 'D', 'E', 'S', ' ', '🌟'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(letters.length, (index) {
        bool isIlluminated = index == _currentLetter;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: Text(
            letters[index],
            style: TextStyle(
              fontSize: 35,
              fontStyle: FontStyle.italic,
              fontFamily: 'Georgia',
              fontWeight: FontWeight.bold,
              color: isIlluminated ? Colors.white : Colors.white24,
              shadows: isIlluminated
                  ? [
                const Shadow(
                  blurRadius: 20.0,
                  color: Colors.cyanAccent,
                  offset: Offset(0, 0),
                ),
                const Shadow(
                  blurRadius: 40.0,
                  color: Colors.white,
                  offset: Offset(0, 0),
                ),
              ]
                  : [],
            ),
          ),
        );
      }),
    );
  }
}

class BirthdayCardPage extends StatefulWidget {
  const BirthdayCardPage({Key? key}) : super(key: key);

  @override
  State<BirthdayCardPage> createState() => _BirthdayCardPageState();
}

class _BirthdayCardPageState extends State<BirthdayCardPage>
    with TickerProviderStateMixin {
  late AnimationController _starsController;
  late AnimationController _flowersController;
  late AnimationController _windController;
  late AnimationController _particlesController;
  late AnimationController _textController;
  late AnimationController _imageController; // Nueva animación para la imagen

  late Animation<double> _flowersAnimation;
  late Animation<double> _windAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<double> _imageFadeAnimation; // Nueva animación de imagen
  late Animation<double> _imageScaleAnimation; // Animación de escala para la imagen

  final List<StarParticle> _stars = [];
  final List<FloatingParticle> _floatingParticles = [];

  @override
  void initState() {
    super.initState();

    _starsController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _flowersController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _windController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _particlesController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _textController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Nuevo controlador para la imagen
    _imageController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _flowersAnimation = CurvedAnimation(
      parent: _flowersController,
      curve: Curves.easeOutBack,
    );

    _windAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _windController,
      curve: Curves.easeInOut,
    ));

    _textFadeAnimation = CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    );

    // Nuevas animaciones para la imagen
    _imageFadeAnimation = CurvedAnimation(
      parent: _imageController,
      curve: Curves.easeInOut,
    );

    _imageScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _imageController,
      curve: Curves.elasticOut,
    ));

    _generateStars();
    _generateFloatingParticles();
    _startAnimationSequence();
  }

  void _generateStars() {
    final random = math.Random();
    for (int i = 0; i < 100; i++) {
      _stars.add(StarParticle(
        x: random.nextDouble(),
        y: random.nextDouble(),
        brightness: random.nextDouble(),
        twinkleSpeed: 0.5 + random.nextDouble() * 1.5,
      ));
    }
  }

  void _generateFloatingParticles() {
    final random = math.Random();
    for (int i = 0; i < 20; i++) {
      _floatingParticles.add(FloatingParticle(
        x: random.nextDouble(),
        y: 0.7 + random.nextDouble() * 0.3,
        color: random.nextBool() ? Colors.yellow : Colors.lightBlue,
        speed: 0.5 + random.nextDouble() * 0.5,
      ));
    }
  }

  void _startAnimationSequence() async {
    // Secuencia de animaciones
    _starsController.forward();

    await Future.delayed(const Duration(milliseconds: 500));
    _flowersController.forward();

    await Future.delayed(const Duration(milliseconds: 1000));
    _windController.repeat();
    _particlesController.repeat();

    await Future.delayed(const Duration(milliseconds: 2000));
    _textController.forward();

    // Agregar la animación de la imagen después del texto
    await Future.delayed(const Duration(milliseconds: 3000));
    _imageController.forward();
  }

  @override
  void dispose() {
    _starsController.dispose();
    _flowersController.dispose();
    _windController.dispose();
    _particlesController.dispose();
    _textController.dispose();
    _imageController.dispose(); // Dispose del nuevo controlador
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0a0a0a),
              Color(0xFF1a1a2e),
              Color(0xFF16213e),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Estrellas de fondo
            AnimatedBuilder(
              animation: _starsController,
              builder: (context, child) {
                return CustomPaint(
                  painter: StarsPainter(_stars, _starsController.value),
                  size: Size.infinite,
                );
              },
            ),

            // Partículas flotantes
            AnimatedBuilder(
              animation: _particlesController,
              builder: (context, child) {
                return CustomPaint(
                  painter: FloatingParticlesPainter(_floatingParticles, _particlesController.value),
                  size: Size.infinite,
                );
              },
            ),

            // Flores
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedBuilder(
                animation: Listenable.merge([_flowersAnimation, _windAnimation]),
                builder: (context, child) {
                  return CustomPaint(
                    painter: FlowersPainter(_flowersAnimation.value, _windAnimation.value),
                    size: Size(MediaQuery.of(context).size.width, 400),
                  );
                },
              ),
            ),

            // Contenido principal con scroll
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),

                    // Título
                    AnimatedBuilder(
                      animation: _textFadeAnimation,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _textFadeAnimation.value,
                          child: const Text(
                            'FELIZ CUMPLEAÑOS EYLEEN 🐱',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Colors.redAccent,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 30),

                    // Imagen animada
                    AnimatedBuilder(
                      animation: Listenable.merge([_imageFadeAnimation, _imageScaleAnimation]),
                      builder: (context, child) {
                        return Opacity(
                          opacity: _imageFadeAnimation.value,
                          child: Transform.scale(
                            scale: _imageScaleAnimation.value,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.pink.withOpacity(0.3),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'assets/images/kuromi.png', // Cambia por el nombre de tu imagen
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    // Widget que se muestra si no encuentra la imagen
                                    return Container(
                                      width: 200,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        color: Colors.pink.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: Colors.pink, width: 2),
                                      ),
                                      child: const Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.fence, size: 50, color: Colors.pink),
                                          SizedBox(height: 10),
                                          Text(
                                            'Foto especial\n💕',
                                            style: TextStyle(color: Colors.pink, fontSize: 16),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 30),

                    // Texto del mensaje
                    AnimatedBuilder(
                      animation: _textFadeAnimation,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _textFadeAnimation.value,
                          child: const Column(
                            children: [
                              Text(
                                '¡Feliz cumpleaños!\n'
                                    'Hoy celebramos un año más de tu vida, y no puedo creer lo rápido que creces. \n'
                                    'Recuerdo cuando te conoci en una posada que un perrito te asusto jeje, o jugábamos en el jardín detras en el cerro sin preocuparnos por nada, solo por divertirnos.\n '
                                    'Esos recuerdos me hacen sonreír, y me recuerdan lo afortunado que soy de tenerte como mi ahijada.\n'
                                    'A lo largo de los años he visto cómo te has convertido en una personita tan especial. Tu carisma y tu risa contagiosa iluminan cualquier lugar al que vayas.\n'
                                    'Ver cómo eres de feliz y lo mucho que disfrutas la vida me llena el corazón de alegría. \n'
                                    'Hoy te deseo un día lleno de risas, regalos y mucha felicidad, tal como te mereces. '
                                    'Que esta nueva etapa de tu vida esté llena de momentos inolvidables, aventuras y nuevos aprendizajes.\n'
                                    'Siempre estaré a tu lado para acompañarte en cada paso que des.\n'
                                    'Te aprecio muchísimo con todo mi cariño',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Gracias por iluminar nuestros días con tu presencia.\n'
                                'Atte: Miguel Angel Martin Meza 🗿',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.italic,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StarParticle {
  final double x;
  final double y;
  final double brightness;
  final double twinkleSpeed;

  StarParticle({
    required this.x,
    required this.y,
    required this.brightness,
    required this.twinkleSpeed,
  });
}

class FloatingParticle {
  final double x;
  double y;
  final Color color;
  final double speed;

  FloatingParticle({
    required this.x,
    required this.y,
    required this.color,
    required this.speed,
  });
}

class StarsPainter extends CustomPainter {
  final List<StarParticle> stars;
  final double animationValue;

  StarsPainter(this.stars, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    for (final star in stars) {
      final opacity = (math.sin(animationValue * star.twinkleSpeed * 2 * math.pi) + 1) / 2;
      paint.color = Colors.white.withOpacity(opacity * star.brightness * 0.8);

      final x = star.x * size.width;
      final y = star.y * size.height;

      canvas.drawCircle(Offset(x, y), 1.5, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class FloatingParticlesPainter extends CustomPainter {
  final List<FloatingParticle> particles;
  final double animationValue;

  FloatingParticlesPainter(this.particles, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    for (final particle in particles) {
      // Movimiento hacia arriba
      particle.y = 0.5 + (particle.y - 0.5 - animationValue * particle.speed * 0.5) % 0.3;

      paint.color = particle.color.withOpacity(0.7);

      final x = particle.x * size.width;
      final y = particle.y * size.height;

      canvas.drawCircle(Offset(x, y), 4, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class FlowersPainter extends CustomPainter {
  final double growthAnimation;
  final double windAnimation;

  FlowersPainter(this.growthAnimation, this.windAnimation);

  @override
  void paint(Canvas canvas, Size size) {
    if (growthAnimation == 0) return;

    // Dibujar múltiples flores
    _drawFlower(canvas, size, size.width * 0.2, windAnimation);
    _drawFlower(canvas, size, size.width * 0.5, windAnimation);
    _drawFlower(canvas, size, size.width * 0.8, windAnimation);

    // Plantas adicionales
    _drawPlant(canvas, size, size.width * 0.1);
    _drawPlant(canvas, size, size.width * 0.35);
    _drawPlant(canvas, size, size.width * 0.65);
    _drawPlant(canvas, size, size.width * 0.9);
  }

  void _drawFlower(Canvas canvas, Size size, double centerX, double windOffset) {
    final paint = Paint();

    // Movimiento del viento
    final windEffect = math.sin(windOffset * 2 * math.pi) * 15;

    // Tallo
    paint.color = Colors.green;
    paint.strokeWidth = 5;
    final stemHeight = size.height * 0.4 * growthAnimation;
    canvas.drawLine(
      Offset(centerX, size.height),
      Offset(centerX + windEffect * 0.5, size.height - stemHeight),
      paint,
    );

    // Hojas
    if (growthAnimation > 0.5) {
      _drawLeaf(canvas, centerX - 8 + windEffect * 0.3, size.height - stemHeight * 0.3);
      _drawLeaf(canvas, centerX + 10 + windEffect * 0.3, size.height - stemHeight * 0.5);
      _drawLeaf(canvas, centerX + 12 + windEffect * 0.2, size.height - stemHeight * 0.1);
    }

    // Flor
    if (growthAnimation > 0.7) {
      final flowerSize = 25 * (growthAnimation - 0.7) / 0.3;
      _drawYellowFlower(
          canvas,
          centerX + windEffect,
          size.height - stemHeight,
          flowerSize
      );
    }
  }

  void _drawLeaf(Canvas canvas, double x, double y) {
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(x, y);
    path.quadraticBezierTo(x - 15, y - 10, x - 5, y - 20);
    path.quadraticBezierTo(x + 5, y - 15, x, y);
    canvas.drawPath(path, paint);
  }

  void _drawYellowFlower(Canvas canvas, double centerX, double centerY, double size) {
    final paint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;

    // Pétalos
    for (int i = 0; i < 8; i++) {
      final angle = i * math.pi / 4;
      final x = centerX + math.cos(angle) * size * 0.7;
      final y = centerY + math.sin(angle) * size * 0.7;

      canvas.drawCircle(Offset(x, y), size * 0.4, paint);
    }

    // Centro de la flor
    paint.color = Colors.orange;
    canvas.drawCircle(Offset(centerX, centerY), size * 0.4, paint);
  }

  void _drawPlant(Canvas canvas, Size size, double x) {
    final paint = Paint()
      ..color = Colors.green.withOpacity(0.6)
      ..strokeWidth = 2;

    final height = size.height * 0.4 * growthAnimation;

    // Tallos múltiples
    for (int i = -5; i < 10; i++) {
      final offsetX = x + (i - 3) * 9;
      final leafHeight = height * (0.5 + i * 0.005);
      canvas.drawLine(
        Offset(offsetX, size.height),
        Offset(offsetX, size.height - leafHeight),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}