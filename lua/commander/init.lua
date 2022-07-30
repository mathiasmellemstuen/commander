local out = {}

--Getting the current working directory of the terminal. This is where the .commander folder will be created.
local current_working_dir=io.popen"cd":read'*l'

function file_exists(file_path)
	local file = io.open(file_path, "r")
	if file ~=nil then io.close(file) return true else return false end
end

function create_file(file_path)
	os.execute("mkdir .commander")

	file = io.open(file_path, "w")
	io.output(file)
	io.write("Replace this text with your commands to run at this id. You can insert one command per line")
	io.close(file)
end

function get_file_lines(file_path)
	local lines = {}

	for line in io.lines(file_path) do 
		lines[#lines + 1] = line
	end

	 return lines
end

function create_file_path_from_id(id)
	return ".commander/" .. tostring(id) .. ".vim-commander"
end

function out.edit(id)
	local file_path = create_file_path_from_id(id) 
	
	-- Creates the file if it does not exist
	if not file_exists(file_path) then
		create_file(file_path)
	end
	
	-- Opens the file in vim for the user to edit
	vim.cmd("e " .. file_path)

end


function out.run(id)

	local file_path = create_file_path_from_id(id) 
	
	-- Running content in the current file with the id. Display message if the file does not exist.
	if file_exists(file_path) then 
		local lines = get_file_lines(file_path)

		-- String containing every command with a <cr> in between each line. This is for executing each line separete.
		local commands_combined = "i"
		
		for k, v in pairs(lines) do
			commands_combined = commands_combined .. v .. "<cr>"
		end
		commands_combined = commands_combined .. "exit<cr>"
		
		-- Splitting screen, opening terminal and executing the commands in the terminal
		vim.cmd("vs")
		vim.cmd("term")
		vim.api.nvim_input(commands_combined)
	else
		print("commander: Command at id: " .. id .. " is not set up for this project. Run require\"commander\".edit(" .. id .. ") to set up the command script for this project.")
	end
end

return out
