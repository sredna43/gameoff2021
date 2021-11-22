extends Node

export var max_load_time = 10000

func goto_scene_no_loading(path, current_scene):
	var next_scene = load(path).instance()
	current_scene.queue_free()
	get_tree().get_root().call_deferred("add_child", next_scene)


func goto_scene(path, current_scene):
	var loader = ResourceLoader.load_interactive(path)
	
	if loader == null:
		print("Warning: Resource loader unable to load the resource at path " + str(path))
		return
		
	var loading_bar = load("res://ui/splashes/LoadingScreen.tscn").instance()
	get_tree().get_root().call_deferred("add_child", loading_bar)
	current_scene.queue_free()
	
	var t = OS.get_ticks_msec()
	
	while OS.get_ticks_msec() - t < max_load_time:
		var err = loader.poll()
		if err == ERR_FILE_EOF:
			# Loading complete
			loading_bar.show_fully_loaded()
			yield(loading_bar, "shown_fully_loaded")
			var resource = loader.get_resource()
			get_tree().get_root().call_deferred('add_child', resource.instance())
			loading_bar.queue_free()
			break
		elif err == OK:
			# Still loading
			var progress = float(loader.get_stage())/loader.get_stage_count()
			loading_bar.update(progress * 100)
			Global.dprint("Loading: " + str(progress))
		else:
			print("Error while loading scene at path " + str(path), err)
			break
		yield(get_tree(), "idle_frame")
