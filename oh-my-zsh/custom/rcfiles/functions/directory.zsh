mkd () {
  mkdir -p $1
}

mkdc () {
  mkd $1 && cd $1
}

