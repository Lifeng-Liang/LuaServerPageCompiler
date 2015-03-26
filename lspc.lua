require("lsp")

local err = compileFile(arg[1], arg[2], arg[3])
if(err ~= nil) then print(err) end
