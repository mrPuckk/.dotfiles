-- local plugin = "My Awesome Plugin"

-- vim.notify("This is an error message.\nSomething went wrong!", "error", {
--   title = plugin,
--   on_open = function()
--     vim.notify("Attempting recovery.", vim.log.levels.WARN, {
--       title = plugin,
--     })
--     local timer = vim.loop.new_timer()
--     timer:start(2000, 0, function()
--       vim.notify({ "Fixing problem.", "Please wait..." }, "info", {
--         title = plugin,
--         timeout = 3000,
--         on_close = function()
--           vim.notify("Problem solved", nil, { title = plugin })
--           vim.notify("Error code 0x0395AF", 1, { title = plugin })
--         end,
--       })
--     end)
--   end,
-- })
vim.notify = require("notify")

local plugin = "My Awesome Plugin"

vim.notify("This is an error message.\nSomething went wrong!", "error", {
  title = plugin,

  on_open = function()
    vim.notify("Attempting recovery.", vim.log.levels.WARN, {
      title = plugin,
    })

    local timer = vim.loop.new_timer()

    timer:start(2000, 0, function()

      vim.notify({ "Fixing problem.", "Please wait..." }, "info", {
        title = plugin,
        timeout = 3000,
        on_close = function()
          vim.notify("Problem solved", nil, { title = plugin })
          vim.notify("Error code 0x0395AF", 1, { title = plugin })
        end, --end of on_close
      })
    end) --end of timer:start
end, --end of on_open
})
