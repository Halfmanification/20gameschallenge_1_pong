extends Node

signal goal_scored(player_side: Enums.PlayerSide)
signal score_updated(player_side: Enums.PlayerSide, score: int)
signal game_won(player_side: Enums.PlayerSide)

# menu signals
signal open_main_menu
signal close_main_menu

signal open_pause_menu
signal close_pause_menu
