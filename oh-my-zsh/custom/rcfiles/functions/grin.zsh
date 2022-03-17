function bug()
{
  ticket_branch 'bug' $1 $2
}

function story()
{
  ticket_branch 'story' $1 $2
}

function task()
{
  ticket_branch 'task' $1 $2
}

function revert()
{
  ticket_branch 'revert' $1 $2
}

function ticket_branch()
{
  gcb "$1/GN-$2/${3// /-}"
}

function copy_branch()
{
  gcb "$(git_current_branch)_WITH_PLATFORM_CPE"
}

function glink()
{
  open "https://github.com/grininc/app.grin.co/compare/platform-cpe...$(git_current_branch)?expand=1"
}
