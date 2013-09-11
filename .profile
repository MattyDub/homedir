function parallel_demo() {
  count=${1:-10}
  echo "Starting $count parallel processes:"
  for i in $(seq -w $count) ; do
    my_slow_job &
    pids="${pids} $!"
  done
  jobs
  for pid in $pids ; do
    if [ -n "$pid"
     ]; then
      echo null pid
    else
      echo pid = $pid
      wait $pid
    fi
  done
  echo "Done!"
}