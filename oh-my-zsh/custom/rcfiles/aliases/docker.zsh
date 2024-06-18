alias dd="docker-compose down"
alias dup="docker-compose up -d"

alias dwhip="docker exec -it whiplash-app"
alias dwhipart="docker exec -it whiplash-app php artisan"
alias dwhiptest="docker exec -it whiplash-app ./vendor/bin/phpunit"

alias dbash="docker exec -it core /bin/bash"
alias dart="docker exec -it core php artisan"
alias dlogs="docker-compose logs -f"
alias detonate="docker exec -it core /bin/bash -c 'APP_ENV=testing php artisan migrate:fresh --seeder TestSeeder'"
