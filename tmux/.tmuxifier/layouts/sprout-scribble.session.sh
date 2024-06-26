session_root "/media/harsh/5C38B5DC38B5B57C/HARSH Coding/Web Development/07_NextJS/sprout-scribble"

if initialize_session "sprout-scribble"; then

	new_window "nvim"
	split_h 50
	run_cmd "bun i && brd"
	split_v 30
	select_pane 1
	run_cmd "nv ."

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
