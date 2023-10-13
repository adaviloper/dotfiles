alias dd="docker-compose down"
alias dup="docker-compose up -d"
alias dwhip="docker exec -it whiplash-app"
alias dwhipart="docker exec -it whiplash-app php artisan"
alias dwhiptest="docker exec -it whiplash-app ./vendor/bin/phpunit"

# function dcore() {
#   if [[ "$1" -e "artisan"]] then
#     docker exec -it core php artisan
#   fi
#   if [[ "$1" -e "t"]] then
#     docker exec -it core ./vendor/bin/phpunit
#   fi
#   if [[ "$1" -e "tf"]] then
#     docker exec -it core ./vendor/bin/phpunit --filter $2
#   fi
# }
#
# function dart() {
#   dcore artisan
# }
#
# function dtf() {
#   docker exec -it core ./vendor/bin/phpunit --filter "$1"
# }
