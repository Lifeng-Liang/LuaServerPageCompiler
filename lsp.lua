require("utils")

function _partial(text)
	io.write("\nfor _,_item in ipairs(_list) do\n")
	compileOne(text, runPartial)
	io.write("\nend\n")
end

function partial(inFile)
	_partial(readAll(inFile))
end

local function runPartial(str)
	local c = loadstring(str)
	c()
end

local function renderHtmlPart(text, i, j)
	local s = string.sub(text, i, j)
	if(s ~= nil and s ~= "") then
		io.write("\nio.write([[", s, "]])\n")
	end
end

function compileOne(text, callBody)
	local i, j, ni, c = 0, 1, 1, ""
	while true do
		ni, j, c = string.find(text, "<%%(.-)%%>", i)
		if(ni == nil) then
			renderHtmlPart(text, i+1)
			return
		end
		renderHtmlPart(text, i+1, ni-1)
		local mark = string.sub(c, 1, 1)
		if(mark == "=") then
			io.write("\nio.write(", string.sub(c, 2), ")\n")
		elseif(mark == "-") then
			callBody(string.sub(c, 2))
		else
			io.write(c)
		end
		i = j
	end
end

function compile(body, layout, args)
	if(args ~= nil) then
		io.write(args, "\n")
	end
	if(layout ~= nil) then
		compileOne(layout, function(c)
			compileOne(body, runPartial)
		end)
	else
		compileOne(body, runPartial)
	end
end

function compileFile(inFile, layoutFile, args)
	if(inFile == nil or not fileExists(inFile)) then
		return "lua lsp.lua inFile [layoutFile [args]]"
	end
	local text = readAll(inFile)
	local layout = nil
	if(layoutFile ~= nil and fileExists(layoutFile)) then
		layout = readAll(layoutFile)
	end
	compile(text, layout, args)
end
