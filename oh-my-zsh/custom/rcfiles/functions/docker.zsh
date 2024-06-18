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
