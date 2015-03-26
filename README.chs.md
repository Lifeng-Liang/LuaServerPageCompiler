Lua Server Page Compiler ��һ�� lsp(���� asp/jsp/ejs ��ģ��)�ı��빤�ߣ���������һ�� lua �ļ���������ļ��������� html��

������ Lua ��д�ġ�֧�� layout �� partial view�� ���������� http handler ���� http server ģ�顣

������ Lua 5.2 �²��Եġ�

������һ�����ӡ�

layout.lsp �ļ���

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

body.lsp �ļ���

````html
<%
hello = "this is a test"
%>

<p><%= hello %></p>

<ul>
<%- partial("partial.lsp") %>
</ul>
````

partial.lsp �ļ���

````html
<li><%= _item %></li>
````

Ȼ��������������

````bash
lua lspc.lua body.lsp layout.lsp "title=\"aaa\" _list={\"bb\", \"cc\"}" > test.lua

````

Ȼ������ test.lua ������������� html��

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

�� ����������������ֱ������ html��

````bash
lua lspc.lua body.lsp layout.lsp "title=\"aaa\" _list={\"bb\", \"cc\"}" | lua -

````
