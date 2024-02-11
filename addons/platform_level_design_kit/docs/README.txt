Platform Level Design Kit
=========================

Folder Structure
----------------

 * assets: All the assets used in the game
 * docs: Documentation, like this file!
 * game_objects: Game objects that can be added to the level
   * collectables: Any object that is a collectable (for example: coins)
   * enemis: Any object that behaves like an enemy
   * player: The player scene. There should be only one player per level
   * tiles: Tiles / platforms placed in the level
 * game_ui: Scenes used for the game's user interface (UI)
 * plugin: Code specific to this addon/plugin. Do not modify!

Your project should have a `game/` folder where you can place all your game levels.

Configuration
-------------

You can configure how the engine behaves by opening the `config.tres` file at the root of your files.
