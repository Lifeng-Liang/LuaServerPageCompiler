Lua Server Page Compiler 是一个 lsp(类似 asp/jsp/ejs 的模板)的编译工具，它会生成一个 lua 文件，而这个文件可以生成 html。

它是用 Lua 编写的。支持 layout 和 partial view。 不过不包含 http handler 或者 http server 模块。

它是在 Lua 5.2 下测试的。

下面是一个例子。

layout.lsp 文件：

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

body.lsp 文件：

````html
<%
hello = "this is a test"
%>

<p><%= hello %></p>

<ul>
<%- partial("partial.lsp") %>
</ul>
````

partial.lsp 文件：

````html
<li><%= _item %></li>
````

然后运行下面的命令：

````bash
lua lspc.lua body.lsp layout.lsp "title=\"aaa\" _list={\"bb\", \"cc\"}" > test.lua

````

然后运行 test.lua 将会生成下面的 html：

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

另： 运行下面的命令可以直接生成 html：

````bash
lua lspc.lua body.lsp layout.lsp "title=\"aaa\" _list={\"bb\", \"cc\"}" | lua -

````
