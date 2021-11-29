function bug()
{
  ticketBranch 'bug' $1 $2
}

function task()
{
  ticketBranch 'task' $1 $2
}

function ticketBranch()
{
  gcb "$1/GN-$2/${3/ /-}"
}
