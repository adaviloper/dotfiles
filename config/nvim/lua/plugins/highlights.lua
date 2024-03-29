-- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  event = 'User AstroFile',
  opts = {
    highlights = {
      init = { -- this table overrides highlights in all themes
        -- Normal = { bg = "#000000" },
      },
      astrotheme = { -- a table of overrides/changes when applying the astrotheme theme
        -- Normal = { bg = "#000000" },
      },
    },
  },
}
