extends Node


# Stores the game stats and provides methods for changing stats

var money : int
var current_stamina : float

func add_money(amount : int) -> void:
	_change_money(amount)

func spend_money(amount : int) -> bool:
	if amount > money:
		return false
	
	else:
		_change_money(-amount)
		return true

func _change_money(amount : int) -> void:
	if money + amount < 0:
		money = 0
		push_error("Spent more money than you had. Setting money to 0")
	
	else:
		money += amount
	
	EventBus.emit_signal("money_changed", money)

func get_money() -> int:
	return money

func increase_stamina(amount : float) -> void:
	_change_stamina(amount)

func decrease_stamina(amount : float) -> void:
	_change_stamina(-amount)

func _change_stamina(amount : float) -> void:
	if current_stamina + amount < 0.0:
		current_stamina = 0.0
	
	elif current_stamina + amount > Constants.MAX_STAMINA:
		current_stamina = Constants.MAX_STAMINA
	
	else:
		current_stamina += amount
	
	EventBus.emit_signal("stamina_changed", current_stamina)

func get_stamina() -> float:
	return current_stamina
