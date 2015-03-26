Lua Server Page Compiler is a tool to compiler lsp (asp/jsp/ejs like html template) to lua code which will generate html.

It's written by Lua. Support layout and partial view. But don't have http handler or http server module.

It's tested by Lua 5.2.

There's a example below.

The layout.lsp file:

````html
<html>
<head>
<title><%= title %></title>
</head>
<body>
<%- body %>
</body>
</html>
````

the body.lsp file:

````html
<%
hello = "this is a test"
%>

<p><%= hello %></p>

<ul>
<%- partial("partial.lsp") %>
</ul>
````

the partial.lsp file:

````html
<li><%= _item %></li>
````

and then run the command:

````bash
lua lspc.lua body.lsp layout.lsp "title=\"aaa\" _list={\"bb\", \"cc\"}" > test.lua

````

then run test.lua will generate the html:

````html
<html>
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
````

PS: run following command will generate html directly:

````bash
lua lspc.lua body.lsp layout.lsp "title=\"aaa\" _list={\"bb\", \"cc\"}" | lua -

````
