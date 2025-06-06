function u() {
    gum style \
        --foreground 12 --border-foreground 12 --border double \
        --align center --width 60 --margin "1 0" --padding "1 0" \
'  ██╗   ██╗██████╗ ██████╗  █████╗ ████████╗███████╗
  ██║   ██║██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██╔════╝
██║   ██║██████╔╝██║  ██║███████║   ██║   █████╗
██║   ██║██╔═══╝ ██║  ██║██╔══██║   ██║   ██╔══╝
  ╚██████╔╝██║     ██████╔╝██║  ██║   ██║   ███████╗
   ╚═════╝ ╚═╝     ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚══════╝'

    NOW=$(date +"%Y-%m-%d-%H-%M-%S")
    echo -e "$NOW\n" >>/tmp/u-$NOW.txt

    gum spin --spinner globe --title "🐙 gh extensions upgrading..." --show-output -- gh extension upgrade --all >>/tmp/u-$NOW.txt
    echo "\n" >>/tmp/u-$NOW.txt
    echo "✅ 🐙 gh extensions upgraded"

    gum spin --spinner globe --title "🪟 tpm plugins updating..." --show-output -- ~/.config/tmux/plugins/tpm/bin/update_plugins all >>/tmp/u-$NOW.txt
    echo "\n" >>/tmp/u-$NOW.txt
    echo "✅ 🪟 tpm plugins updated"

    gum spin --spinner globe --title " lazy.nvim syncing..." -- nvim --headless "+AstroUpdate! sync" +qa
    echo "\n" >>/tmp/u-$NOW.txt
    echo "✅  AstroNvim synced"

    gum spin --spinner globe --title "🧰 mason.nvim updating" -- nvim --headless "+MasonUpdate" +qa
    echo "\n" >>/tmp/u-$NOW.txt
    echo "✅ 🧰 mason.nvim updated"

    gum spin --spinner globe --title "🌳 nvim-treesitter updating" -- nvim --headless "+TSUpdate" +qa
    echo "\n" >>/tmp/u-$NOW.txt
    echo "✅ 🌳 nvim-treesitter updated"

    gum spin --spinner globe --title "🦆 yazi plugins updating" -- ya pack -u
    echo "\n" >>/tmp/u-$NOW.txt
    echo "✅ 🦆 yazi plugins updating"

    gum spin --spinner globe --title "🍻 brew updating" --show-output -- brew update >>/tmp/u-$NOW.txt
    echo "\n" >>/tmp/u-$NOW.txt
    echo "✅ 🍻 brew updated"

    OUTDATED=(brew outdated)
    echo $OUTDATED >>/tmp/u-$NOW.txt

    if [ ! -z "$OUTDATED" -a "$OUTDATED" != " " ]; then
        gum spin --spinner globe --title "🍻 brew upgrading" --show-output -- brew upgrade >>/tmp/u-$NOW.txt
        echo "\n" >>/tmp/u-$NOW.txt
        echo "✅ 🍻 brew upgraded"

        gum spin --spinner globe --title "🍻 brew cleaning up" --show-output -- brew cleanup --prune=all >>/tmp/u-$NOW.txt
        echo "\n" >>/tmp/u-$NOW.txt
        echo "✅ 🍻 brew cleaned up"
    else
        echo "No outdated brew packages" >>/tmp/u-$NOW.txt
    fi

    gum spin --spinner globe --title "🍻 brew doctoring" --show-output -- brew doctor >>/tmp/u-$NOW.txt
    echo "\n" >>/tmp/u-$NOW.txt
    echo "✅ 🍻 brew doctored"

    echo "✅ 🧾 logged to /tmp/u-$NOW.txt"
    man /tmp/u-$NOW.txt

}
