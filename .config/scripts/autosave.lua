--@arg: output_buf: The buffer number for the output of the executable
--@arg: pattern: The pattern to trigger the autocmd
--@arg: command: The command to execute
--@arg: timer: The time to wait for the command to finish
--@notice: The timer is optional, if not provided the default value is 1000ms
--@notice: jobstart() is a blocking function, so I use jobwait() to wait for the job to finish
local attach_to_buffer = function(output_buf,pattern, command, timer)

  timer = timer or {}
  local wait_time = timer.wait_time or 1000

  vim.api.nvim_create_autocmd("BufWritePost",{
    group = vim.api.nvim_create_augroup("AutoRunGroup", {clear = false}),
    pattern = pattern,

  --Called when the BufferWritePost is triggered
    callback = function()
      local append_data = function(_, data)
        local lines = {}
        if data then
          for _, line in ipairs(data) do
            table.insert(lines, line)
          end
        end
        vim.api.nvim_buf_set_lines(output_buf, -1, -1, false, lines)
      end

      vim.api.nvim_buf_set_lines(output_buf, 0, -1, false, {})

      local job = vim.fn.jobstart(command, {
        stout_buffered = true,
        on_stdout = append_data,
        on_stderr = append_data,
      })

    local job_result = vim.fn.jobwait({job}, wait_time)
    if job_result == -1 then
      -- handle error
      local error_message = "The job failed to complete within " .. wait_time .. "ms."
      vim.api.nvim_err_writeln(error_message)
    else
      -- handle success
      local success_message = "The job completed successfully."
      vim.api.nvim_out_write(success_message)
    end

    --!TODO: actively manage processing time
    -- while vim.fn.jobwait({job}, wait_time) == -1 do
    --     wait_time = wait_time + 100
    --    -- vim.fn.jobwait({job}, wait_time) -- wait for the job to finish before executing nvim_command
    -- end -- wait for the job to finish before executing nvim_command

  end,
  })
end

--@arg: log_buf: The buffer number for the output of the executable
--@arg: executable_name: The name of the executable file
--@arg: run_output_buf: The buffer number for the output of the executable
vim.api.nvim_create_user_command("RunCpp", function()
  -- Stop any autocmds before starting a new one
  vim.api.nvim_command("AutoRunStop")

  local height = 8
  -- local log_buf = nil
  -- local result_buf = nil
  local main_buf = vim.api.nvim_get_current_buf()

  -- Check if buffers are already created
  local log_buf_num = vim.fn.bufnr("log")
  if log_buf_num == -1 then
      -- Create new buffer for logs if it does not exist
      vim.api.nvim_command("tabnew")
      vim.api.nvim_buf_set_name(vim.api.nvim_get_current_buf(), "log")
      log_buf_num = vim.api.nvim_get_current_buf()
      vim.api.nvim_buf_set_option(log_buf_num, 'buftype', 'nofile')
      vim.api.nvim_set_current_buf(main_buf)
  end

  local result_buf_num = vim.fn.bufnr("result")
  if result_buf_num == -1 then
      -- Create new buffer for results if it does not exist
      vim.api.nvim_command("new")
      vim.api.nvim_buf_set_name(vim.api.nvim_get_current_buf(), "result")
      result_buf_num = vim.api.nvim_get_current_buf()
      vim.api.nvim_buf_set_option(result_buf_num, 'buftype', 'nofile')
      vim.api.nvim_win_set_height(vim.api.nvim_get_current_win(), height)
  end

  -- Generate the build directory and generate the CMake's files
  local cmake_command = {"cmake", "-Bbuild", "-H."}
  attach_to_buffer(log_buf_num, "main.cpp", cmake_command)

  -- Build the project
  local build_command = {"cmake", "--build", "./build"}
  attach_to_buffer(log_buf_num, "main.cpp", build_command)

  -- -- Print the output of the executable
  local executable_name = vim.fn.input("The name of the Executable file: ")
  local run_command = {"./bin/" .. executable_name}
  attach_to_buffer(result_buf_num, "main.cpp", run_command)

  --!TODO: Create a function to handle the input prompt 
  -- Define a function to handle the input prompt
  -- local handle_input = function()
  --   local input = vim.trim(vim.api.nvim_buf_get_lines(input_buf, 0, -1, false)[1])
  --   if input ~= "" then
  --     local run_command = {"./bin/" .. input}
  --     attach_to_buffer(result_buf, "main.cpp", run_command)
  --     vim.api.nvim_command("bd!")
  --   end
  -- end

  -- -- Create a new buffer for the input prompt
  -- local input_buf = vim.api.nvim_create_buf(false, true)
  -- vim.api.nvim_buf_set_option(input_buf, 'bufhidden', 'wipe')

  -- -- Set the prompt message in the input buffer
  -- vim.api.nvim_buf_set_lines(input_buf, 0, -1, false, {"Enter the name of the Executable file:"})

  -- -- Open a floating window for the input buffer
  -- local win_width = 40
  -- local win_height = 3
  -- local row = math.floor((vim.o.lines - win_height) / 2)
  -- local col = math.floor((vim.o.columns - win_width) / 2)
  -- local opts = {
  --   style = "minimal",
  --   relative = "editor",
  --   row = row,
  --   col = col,
  --   width = win_width,
  --   height = win_height,
  --   focusable = true,
  --   border = "single",
  -- }
  -- local win = vim.api.nvim_open_win(input_buf, true, opts)

  -- -- Set the current buffer to the input buffer to wait for user input
  -- vim.api.nvim_set_current_buf(input_buf)

  -- -- Create an autocmd to handle the user input
  -- local input_autocmd = {
  --   event = "CursorMoved,CursorMovedI",
  --   pattern = "<buffer=" .. input_buf .. ">",
  --   command = "lua handle_input()"
  -- }
  -- vim.api.nvim_buf_attach(input_buf, false, {
  --   on_detach = function()
  --     vim.api.nvim_win_close(win, true)
  --   end
  -- })
  -- vim.api.nvim_command("autocmd " .. input_autocmd.event .. " " .. input_autocmd.pattern .. " " .. input_autocmd.command)
end, {})

--@TODO: stop any autocmd spawed before  
vim.api.nvim_create_user_command("AutoRunStop", function()
  print "AutoRun Stopped"
  vim.api.nvim_create_augroup("AutoRunGroup", {clear = true})
end, {})

