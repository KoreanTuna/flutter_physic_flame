import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'utils.dart';

// Fixed viewport size
final screenSize = Vector2(1280, 720);

// Scaled viewport size
final worldSize = Vector2(12.8, 7.2);

class MyGame extends Forge2DGame with KeyboardEvents {
  // Keep track of the number of bodies in the world.
  final totalBodies = TextComponent(position: Vector2(5, 690))
    ..positionType = PositionType.viewport;

  // Keep track of the frames per second
  final fps = FpsTextComponent(position: Vector2(5, 665));

  // Scale the screenSize by 100 and set the gravity of 15
  MyGame() : super(zoom: 100, gravity: Vector2(0, 10));

  @override
  Future<void> onLoad() async {
    // Set the FixedResolutionViewport
    camera.viewport = FixedResolutionViewport(screenSize);

    // Adds a black background to the viewport
    add(_Background(size: screenSize)..positionType = PositionType.viewport);

    // add(fps);
    // add(totalBodies);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Updated the number of bodies in the world
    totalBodies.text = 'Bodies: ${world.bodies.length}';
  }

  // @override
  // KeyEventResult onKeyEvent(RawKeyEvent event, Set keysPressed) {
  //   if (event is RawKeyDownEvent) {
  //     if (keysPressed.contains(LogicalKeyboardKey.escape)) {
  //       navigatorKey.currentState
  //           ?.pushNamedAndRemoveUntil(Routes.menu, (r) => false);
  //       return KeyEventResult.handled;
  //     }
  //   }
  //   return KeyEventResult.ignored;
  // }

  @override
  Color backgroundColor() {
    // Paints the background red
    return Colors.white;
  }
}

// Helper component that paints a black background
class _Background extends PositionComponent {
  _Background({super.size});

  @override
  void render(Canvas canvas) {
    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y), blackPaint);
  }
}

class MyGameWidget extends StatelessWidget {
  final MyGame game;

  const MyGameWidget({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 250, 250, 255),
        shadowColor: Colors.transparent,
      ),
      body: GameWidget(
        game: game,
      ),
    );
  }
}
