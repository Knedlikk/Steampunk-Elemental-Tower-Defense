# Steampunk Elemental Tower Defense

## Overview
Steampunk Elemental Tower Defense is a tower defense game where players strategically place towers to defend against waves of enemies. The game features various tower types, each with unique abilities, and a variety of enemies with different strengths and weaknesses.

## Project Structure
The project is organized into the following directories:

- **scenes/**: Contains all the scene files for towers, enemies, levels, and UI.
  - **towers/**: Includes the base tower scene and its associated script.
  - **enemies/**: Contains the base enemy scene and its script.
  - **levels/**: Holds the level scenes and the level manager script.
  - **ui/**: Contains the HUD scene and its script.

- **scripts/**: Contains the main game logic scripts.
  - **game_manager.gd**: Manages the overall game state.
  - **tower_manager.gd**: Handles tower placement and management.
  - **enemy_manager.gd**: Manages enemy spawning and behavior.
  - **utils.gd**: Contains utility functions used throughout the project.

- **assets/**: Contains audio and font files used in the game.
  - **audio/**: Holds sound effects and music files.
  - **fonts/**: Contains font files for the game.

- **project.godot**: The engine configuration file for the project.

## Setup Instructions
1. Clone the repository to your local machine.
2. Open the project in the Godot Engine.
3. Ensure all assets are correctly linked in the scenes.
4. Run the project to start playing!

## Gameplay Details
- Players can build towers to defend against incoming waves of enemies.
- Each tower has properties such as damage, range, and fire rate.
- Enemies have health, speed, and damage attributes.
- The game features multiple levels with increasing difficulty.

## Contributing
Feel free to contribute to the project by submitting issues or pull requests. Your feedback and contributions are welcome!