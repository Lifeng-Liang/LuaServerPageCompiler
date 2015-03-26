function readAll(fileName)
	local hFile, err = io.open(fileName, "r");

	if hFile and not err then
		local text = hFile:read("*a");
		io.close(hFile);
		return text
	else
		print(err)
		return nil
	end
end

function writeFile(fileName, fileType, text)
	local out = io.open(fileName, fileType)
	if out then
		out:write(text)
		out:close()
	end
end

function fileExists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end
