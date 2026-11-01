mkcd() {
  (( $# == 1 )) || { print -u2 'Usage: mkcd DIRECTORY'; return 1; }
  mkdir -p -- "$1" && cd -- "$1"
}
