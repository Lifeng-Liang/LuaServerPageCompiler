require("lsp")

-----------------------------------------
-- override io.write() to gether output

output = ""

io.write = function(...)
	for _,v in ipairs({...}) do
		output = output..v
	end
end

-----------------------------------------
-- layout, body and partial text for test

layoutText = [[<html>
<head>
<title><%= title %></title>
</head>
<body>
<%- body %>
</body>
</html>
]]

bodyText = [[<%
hello = "this is a test"
%>

<p><%= hello %></p>

<ul>
<%- _partial(partialText) %>
</ul>
]]

partialText = [[<li><%= _item %></li>
]]

-----------------------------------------
-- test generate lua file

compile(bodyText, layoutText, [[title="test" _list={"abc", "xyz"}]])
local expected = "title=\"test\" _list={\"abc\", \"xyz\"}\n\nio.write([[<html>\n<head>\n<title>]])\n\nio.write( title )\n\nio.write([[</title>\n</head>\n<body>\n]])\n\nhello = \"this is a test\"\n\nio.write([[\n\n<p>]])\n\nio.write( hello )\n\nio.write([[</p>\n\n<ul>\n]])\n\nfor _,_item in ipairs(_list) do\n\nio.write([[<li>]])\n\nio.write( _item )\n\nio.write([[</li>\n]])\n\nend\n\nio.write([[\n</ul>\n]])\n\nio.write([[\n</body>\n</html>\n]])\n"
if(output ~= expected) then error("the output lua and expected are not same") end

-----------------------------------------
-- test generate html file

local c = loadstring(output)
output = ""
c()

if(output ~= [[<html>
<head>
<title>test</title>
</head>
<body>

<p>this is a test</p>

<ul>
<li>abc</li>
<li>xyz</li>
</ul>
</body>
</html>
]]) then error("the output html and expected are not same") end

print("All test cases passed")
