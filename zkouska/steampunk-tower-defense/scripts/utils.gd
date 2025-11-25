extends Node

# Utility functions for the tower defense game

# Generates a random number between min and max (inclusive)
func random_range(min: int, max: int) -> int:
    return randi() % (max - min + 1) + min

# Clamps a value between a minimum and maximum range
func clamp_value(value: float, min: float, max: float) -> float:
    return max(min(value, max), min)

# Checks if a point is within a given rectangle
func is_point_in_rect(point: Vector2, rect_position: Vector2, rect_size: Vector2) -> bool:
    return point.x >= rect_position.x and point.x <= rect_position.x + rect_size.x and
           point.y >= rect_position.y and point.y <= rect_position.y + rect_size.y