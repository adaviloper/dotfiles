function bug()
{
  ticketBranch 'bug' $1 $2
}

function story()
{
  ticketBranch 'story' $1 $2
}

function task()
{
  ticketBranch 'task' $1 $2
}

function ticketBranch()
{
  echo "$1/GN-$2/${3// /-}"
}
