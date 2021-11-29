alias run_site="cd ~/Developer/grin/app.grin.co/resources/assets && npm run hot"
alias run_live="cd ~/Developer/grin/grin.live/resources/assets && npm run watch"
alias run_horizon="cd ~/Developer/grin/app.grin.co && php artisan horizon"
alias run_all="run_site & run_live & run_horizon" # run all in the same terminal
alias run_ngrok="valet share --bind-tls=true -hostname=username.ngrok.io"
