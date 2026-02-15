local M = {}

M.setFileTag = function(tagName)
  return {
    function()
      local grapple = require("grapple")
      if not grapple.exists({ name = tagName }) then
        grapple.tag({ name = tagName })
      else
        local tag = grapple.find({ name = tagName })
        if tag == nil then return end

        vim.ui.select({
          "yes",
          "no",
        }, { prompt = "Overwrite [" .. tag.name .. "]" }, function(selection)
          if selection ~= nil and selection == "yes" then grapple.tag({ name = tagName }) end
        end)
      end
      vim.cmd.redrawstatus()
    end,
    desc = "Tag as [" .. tagName .. "]",
  }
end

M.jumpToFileTag = function(tagName)
  return {
    function() require("grapple").select({ name = tagName }) end,
    desc = "Jump to the [" .. tagName .. "] tag",
  }
end

return M
