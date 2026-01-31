
extends Node

#Global singleton that holds the signals used by the game. To connect a signal,
#Connect to a signal from a script: EventBus.[signal_name].connect([method_name])
#Emit a signal from a script:  EventBus.emit_signal([signal_names], args)

#Stat Signals
signal money_changed(total_money : int)
signal stamina_changed(current_stamina : float)

#Sticker Signals
signal sticker_purchased(sticker_data : StickerData)
