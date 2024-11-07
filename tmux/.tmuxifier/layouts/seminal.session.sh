session_root "${PWD}"

if initialize_session "seminal"; then

  new_window "celery"
  run_cmd "cd data_collection/ && venvAct"
  run_cmd "celery -A data_collection.celery worker -l info"
  split_h 50
  run_cmd "cd data_collection/ && venvAct"
  split_v 50
  run_cmd "cd scraping/ && venvAct"
  select_pane 1

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
