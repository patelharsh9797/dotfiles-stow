session_root "${PWD}"

if initialize_session "dev_server"; then

  new_window "nvim"
  split_h 40
  run_cmd "bun i && brd"
  split_v 75
  split_v 60
  select_pane 1
  run_cmd "nv ."

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
