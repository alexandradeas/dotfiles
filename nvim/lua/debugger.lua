local dap = require("dap")
local scan = require("plenary.scandir")

---@type boolean
local is_fvm_dir = scan.scan_dir(".", { hidden = false, depth = 2 })

-- dap.configurations.dart = {
-- 	{
-- 		type = "dart",
-- 		request = "launch",
-- 		name = "Launch dart",
-- 		dartSdkPath = function()
-- 			if scan.scan_dir(".", { hidden = false, depth = 2 }) then
-- 
-- 			else
-- 				os.execute("fvm dart")
-- 			end
-- 		end(),
-- 		flutterSdkPath = os.execute("fvm flutter"),
-- 		program = "${workspaceFolder}/lib/main.dart",
-- 		cwd = "${workspaceFolder}",
-- 	},
-- 	{
-- 		type = "flutter",
-- 		request = "launch",
-- 		name = "Launch flutter",
-- 		dartSdkPath = os.execute("fvm dart"),
-- 		flutterSdkPath = os.execute("fvm flutter"),
-- 		program = "${workspaceFolder}/lib/main.dart",
-- 		cwd = "${workspaceFolder}",
-- 	},
-- }
-- 
-- dap.adapters.dart = {
-- 	{
-- 		type = "executable", command = "fvm dart",
-- 		args = { "debug_adapter" },
-- 		options = {
-- 			detached = false,
-- 		},
-- 	},
-- 	{
-- 		type = "executable",
-- 		command = "fvm flutter",
-- 		args = { "debug_adapter" },
-- 		options = {
-- 			detached = false,
-- 		},
-- 	},
-- }
