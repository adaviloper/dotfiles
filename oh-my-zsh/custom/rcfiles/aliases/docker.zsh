alias dd="docker compose down"
alias dup="docker compose up -d"

alias dlogs="docker-compose logs -f"
alias detonate="docker exec -it core /bin/bash -c 'APP_ENV=testing php artisan migrate:fresh --seeder TestSeeder'"
