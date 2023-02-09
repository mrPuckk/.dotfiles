--@TODO: attach an autocmd to a buffer 
--@arg: output_buf: The buffer number for the output of the executable
--@arg: pattern: The pattern to trigger the autocmd
--@arg: command: The command to execute
--@arg: timer: The time to wait for the command to finish
--@notice: The timer is optional, if not provided the default value is 1000ms
--@notice: jobstart() is a blocking function, so I use jobwait() to wait for the job to finish
local attach_to_buffer = function(output_buf,pattern, command, timer)

  timer = timer or {}
  local wait_time = timer.wait_time or 1000
  -- local wait_time = 0

  vim.api.nvim_create_autocmd("BufWritePost",{
      group = vim.api.nvim_create_augroup("AutoRunGroup", {clear = false}),
      pattern = pattern,
      callback = function()
        local append_data = function(_, data)
          if data then
            vim.api.nvim_buf_set_lines(output_buf, -1, -1, false, data)
          end
        end

        vim.api.nvim_buf_set_lines(output_buf, 0, -1, false, {})

        local job = vim.fn.jobstart(command, {
          stout_buffered = true,
          on_stdout = append_data,
          on_stderr = append_data,
        })

      vim.fn.jobwait({job}, wait_time)

      --!TODO: actively manage processing time
      -- while vim.fn.jobwait({job}, wait_time) == -1 do
      --     wait_time = wait_time + 100
      --    -- vim.fn.jobwait({job}, wait_time) -- wait for the job to finish before executing nvim_command
      -- end -- wait for the job to finish before executing nvim_command

    end,
  })
end

--@TODO: to {generate, build, and run} the executable 
--@arg: log_buf: The buffer number for the output of the executable
--@arg: executable_name: The name of the executable file
--@arg: run_output_buf: The buffer number for the output of the executable
vim.api.nvim_create_user_command("RunCpp", function()
  -- Stop any autocmds before starting a new one
  vim.api.nvim_command("AutoRunStop")

  local height = 8
  local log_buf = nil
  local result_buf = nil
  local main_buf = vim.api.nvim_get_current_buf()

  -- Check if buffers are already created
  local bufnr_list = vim.api.nvim_list_bufs()
  for i, buf_num in ipairs(bufnr_list) do
      local buf_name = vim.api.nvim_buf_get_name(buf_num)
      if buf_name == "log" then
          log_buf = buf_num
      elseif buf_name == "result" then
          result_buf = buf_num
      end
  end

  if log_buf == nil then
      -- Create new buffer for logs if it does not exist
      vim.api.nvim_command("tabnew")
      vim.api.nvim_buf_set_name(vim.api.nvim_get_current_buf(), "log")
      log_buf = vim.api.nvim_get_current_buf()
      vim.api.nvim_buf_set_option(log_buf, 'buftype', 'nofile')
      vim.api.nvim_set_current_buf(main_buf)
  end

  if result_buf == nil then
      -- Create new buffer for results if it does not exist
      vim.api.nvim_command("new")
      vim.api.nvim_buf_set_name(vim.api.nvim_get_current_buf(), "result")
      result_buf = vim.api.nvim_get_current_buf()
      vim.api.nvim_buf_set_option(result_buf, 'buftype', 'nofile')
      vim.api.nvim_win_set_height(vim.api.nvim_get_current_win(), height)
  end

  -- Generate the build directory and generate the CMake's files
  local cmake_command = {"cmake", "-Bbuild", "-H."}
  attach_to_buffer(log_buf, "main.cpp", cmake_command)

  -- Build the project
  local build_command = {"cmake", "--build", "./build"}
  coroutine.wrap(attach_to_buffer)(log_buf, "main.cpp", build_command)

  -- Print the output of the executable
  local executable_name = vim.fn.input("The name of the Executable file: ")
  local run_command = {"./bin/" .. executable_name}
  attach_to_buffer(result_buf, "main.cpp", run_command)

end, {})

-- local function create_split_buffer(height, width)
--   local cur_buf = vim.api.nvim_get_current_buf()
--   local win_id = vim.api.nvim_open_win(cur_buf, false, {relative = 'win', height = height, width = width, bufpos={100,10}})
--   vim.api.nvim_win_set_cursor(win_id, {1, 1})
-- end

-- --@TODO: Add a check to see if the executable exists at path "./bin/" ... <executable_name>
-- --@arg: executable_name: The name of the executable file
-- --@arg: run_output_buf: The buffer number for the output of the executable
-- vim.api.nvim_create_user_command("CreateSplitBuffer", function(args)
--   local height = tonumber(args[0]) or 38

--   local cur_win = vim.api.nvim_get_current_win()

--   vim.api.nvim_command("new")
--   vim.api.nvim_win_set_height(cur_win, height)
--   print(vim.api.nvim_get_current_buf())

--   vim.api.nvim_command("vnew")
--   print(vim.api.nvim_get_current_buf())
-- end, {})

-- vim.api.nvim_create_user_command("CreateBuffer", function()
--   print(cur_buf)
-- end, {})

-- --@TODO: Add a check to see if the executable exists at path "./bin/" ... <executable_name>
-- --@arg: executable_name: The name of the executable file
-- --@arg: run_output_buf: The buffer number for the output of the executable
-- vim.api.nvim_create_user_command("GetCppOutput", function()
--   local run_output_buf = tonumber(vim.fn.input("Enter buffer number for run output: "))
--   local executable_name = vim.fn.input("Enter the name of the executable file: ")
--   local run_command = {"./bin/" .. executable_name}
--   attach_to_buffer(run_output_buf, "main.cpp", run_command)
-- end, {})

--@TODO: stop any autocmd spawed before  
vim.api.nvim_create_user_command("AutoRunStop", function()
  print "AutoRun Stopped"
  vim.api.nvim_create_augroup("AutoRunGroup", {clear = true})
end, {})

