import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ParticleManager {
  static void createWinExplosion(Vector2 position, Component parent) {
    final random = Random();
    final particleComponent = ParticleSystemComponent(
      position: position,
      particle: Particle.generate(
        count: 50,
        lifespan: 1.5,
        generator: (i) => AcceleratedParticle(
          speed: Vector2.random(random) * 100 - Vector2.all(50),
          acceleration: Vector2(0, 50),
          child: CircleParticle(
            radius: 2 + random.nextDouble() * 3,
            paint: Paint()..color = Color.fromARGB(
              255,
              random.nextInt(255),
              random.nextInt(255),
              random.nextInt(255),
            ),
          ),
        ),
      ),
    );
    parent.add(particleComponent);
  }

  // TODO: Implement glow particles, smooth trails, UI glow animations
}
