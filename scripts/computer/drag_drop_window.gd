#extends Control
#
#
## Control that can be dragged from
#func _get_drag_data(at_position:Vector2)->Variant:
	#var item := inventory.item_at(at_position)
	#if item == null: return null
#
	#var drag_data = ItemDrag.new(self, item, _create_item_preview(item))
	#set_drag_preview(drag_data.preview)
#
	#return drag_data
	#
## Control that can be dragged to
#func _can_drop_data(at_position:Vector2, data:Variant)->bool:
	#if !data is ItemDrag: return false
	#var drag_data := data as ItemDrag
	## Check if the item can fit in the inventory at this position
	#return !inventory.intersects_at(drag_data.item, at_position)
	#
#func _drop_data(at_position:Vector2, data:Variant)->void:
	#if !data is ItemDrag: return
	#var drag_data := data as ItemDrag
#
	#drag_data.destination = self
	#if drag_data.source: drag_data.source.remove_item(drag_data.item)
#
	#inventory.add_item_at(drag_data.item, at_position)
