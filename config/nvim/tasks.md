# Tasks
## Issues
- [x] Files/buffers do not update when files are changed externally via Git or some other mechanism
- [ ] Phpactor LSP does not respect PhpStan rules

## Plugins
- [ ] Check to see if the `gh-dash` extension is enabled before launching the `gh-dash` terminal
- [x] Things to synchronize Nvim state with git branch:
    - auto-session context
    - Grapple scopes
- [x] Add Scratch configs for different languages
    - [x] Vue
    - [x] Shell
- [ ] Add snippets for different languages
    - [.] PHP
        - Methods
            - [x] Make method bodies dynamic based on class and return types
            - [ ] Make __construct method dynamic based on params passed in
                - Docblocks update with param types
                - If not declared in the parameter list, then assign parameters in the body
        - Language Constructs
        - Debugging
    - [ ] Vue
    - [ ] JS
- [?] Do we have some kind of docker integration?
- [ ] Need a way integrate `nvim-dap`
- [x] Configure Grapple to scope by directory _and_ git branch

## Autocommands
- [ ] Skeletons for populating new files with boilerplate
    - [ ] A way to store different types of files per language
        - Interface
        - Empty PHP file
        - PHP Class
        - Vue Single-File Components

## Plugins to look into
- https://github.com/danymat/neogen
- https://github.com/sindrets/diffview.nvim
- https://github.com/nvim-pack/nvim-spectre
