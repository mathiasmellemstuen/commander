local out = {}

--Getting the current working directory of the terminal. This is where the .commander folder will be created.
local current_working_dir=io.popen"cd":read'*l'

function current_os_is_windows()
	if package.config:sub(1,1) == "\\" then return true else return false end
end

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

function create_file_path_from_id(id)
	if current_os_is_windows() then 
		return ".commander/" .. tostring(id) .. ".bat"
	else
		return ".commander/" .. tostring(id) .. ".sh"
	end 
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
		
		-- Splitting screen, opening terminal and executing the commands in the terminal
		vim.cmd("vs")
		vim.cmd("term")
		
		if current_os_is_windows() then 
			vim.api.nvim_input("istart " .. file_path .. "<cr>")
		else
			vim.api.nvim_input("ichmod +x " .. file_path .. "<cr>./" .. file_path .. "<cr>")
		end

	else
		print("commander: Command at id: " .. id .. " is not set up for this project. Run require\"commander\".edit(" .. id .. ") to set up the command script for this project.")
	end
end

return out
