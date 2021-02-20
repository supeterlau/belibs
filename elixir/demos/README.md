# Demo

## appsignal plug 

## simpleweb

https://codewords.recurse.com/issues/five/building-a-web-framework-from-scratch-in-elixir

使用 Plug 开发 Sinatra-like 网络框架

Phoenix 中使用大量的 macro 定义，我们会写直接的代码

cowboy
plug
sqlite_ecto
ecto

export ROOT=$(PWD)
mix hex.config mirror_url https://hexpm.upyun.com
cd $ROOT && mix deps.get

mix deps.tree

1. plug 

elixir 
文件名 error_handler.ex
模块名 ErrorHandler

一个响应网络请求的模块 module

创建一个 plug 模块需要实现两个函数 init/1 call/2

init/1 在服务器启动时执行

call/2 在每次有请求到达时执行

  两个参数 
  
  conn 即 Plug.Conn 保存请求信息，也被用来返回响应 Plug.Conn.send_resp

  opts init/1 的输出，在请求之间保持不变

init/1 的 opts 来源于传给所在 plug module 的参数，保持原样传递给 call/2

Plug.Conn.send_resp 返回 mutated conn (外部调用者会可以知道哪里变化了)

2. cowboy 启动 plug 

cd $ROOT && iex -S mix 

{:ok, _} = Plug.Adapters.Cowboy.http SimpleWebPlug, []

遇到版本不匹配问题

mix deps.unlock --all && mix deps.clean --all

根据新配置 https://github.com/elixir-plug/plug elixir-plug/plug: A specification and conveniences for composable modules between web applications

{:plug_cowboy, "~> 2.0"},

选用最新 ecto 和 db adapter driver library

运行 Plug.Adapters.Cowboy 成功 

访问 127.0.0.1:4000

每次请求会打印出 saying yeah

设置请求头

Plug.Conn.put_resp_header("server", "Plug")

key 中不能有空格?

- pattern matching 路由

- 为路由写个 macro 

避免写每个路由时都重复 init 和 call 函数

自动引入 init 并自动调用 call

Plug 不一定做路由，也可以进行其他数据处理，拦截请求进行日志记录，认证， DOS 防护等

- 显示模板

templates

使用模板 

<% %> 中是 Elixir 代码
<%= %> 显示执行结果
<%# %> 不显示执行结果，可作为注释使用

content = EEx.eval_file(template_path, [user_id: user_id])

设置 content-type 

Plug.Conn.put_resp_header("ontent-type", "text/html")

conn
|> Plug.Conn.put_resp_content_type("text/html")
|> Plug.Conn.send_resp(200, content)

对模板进行预编译

- 数据库 PostgreSQL/Sqlite3

Phoenix 提供很多快捷命令

https://hexdocs.pm/phoenix/ecto.html Ecto — Phoenix v1.5.7

mix phx.gen.schema User users name:string email:string \
bio:string number_of_pets:integer

ecto 

{:ecto_sql, "~> 3.0"},
{:postgrex, ">= 0.0.0"}

生成配置文件

mix ecto.gen.repo -r SimpleWeb.Repo

  生成 config.exs 内容和 lib/simple_web/repo.ex

  config.exs 中添加

   config :demos, ecto_repos: [...]

ecto
  - pk 类型默认 int (改为 uuidv4 等)
  - timestamps: created_at updated_at

生成数据库迁移文件

mix ecto.gen.migration create_simple_web_users

顺序问题: 

Ecto 官网

生成 migration 文件 -> 编辑 migration 文件 -> 执行 migrate -> 在 Schema 中使用

mix ecto.gen.migration 并不会根据 Scheme 生成迁移文件

迁移文件路径 priv/repo/migrations

修改 change 函数

mix ecto.migrate

! 添加 ecto 到 supervisor

https://elixirforum.com/t/so-what-is-the-problem-with-sqlite/1602 So what is the problem with sqlite? - Phoenix Forum / Questions / Help - Elixir Programming Language Forum

https://github.com/elixir-sqlite/sqlite_ecto2 elixir-sqlite/sqlite_ecto2: Sqlite3 adapter for Ecto 2.2.x
https://github.com/elixir-sqlite/sqlite_ecto2/blob/master/docs/tutorial.md sqlite_ecto2/tutorial.md at master · elixir-sqlite/sqlite_ecto2

- mix deps version

{:postgrex, ">= 0.0.0"}, 希望是最新版本

Failed to use "ecto" (versions 3.5.0 to 3.5.7) because
  sqlite_ecto (version 1.1

https://stackoverflow.com/questions/27322330/mix-compiliation-fails-when-compiling-ecto elixir - Mix compiliation fails when compiling Ecto - Stack Overflow
https://elixirforum.com/t/mix-deps-update-working-as-mix-deps-downgrade/27099 Mix deps.update working as mix deps.downgrade - Questions / Help - Elixir Programming Language Forum
https://elixirforum.com/t/mix-deps-update-working-as-mix-deps-downgrade/27099/11 Mix deps.update working as mix deps.downgrade - Questions / Help - Elixir Programming Language Forum

    warning: System.stacktrace/0 is deprecated, use __STACKTRACE__ instead
      lib/plug/conn/wrapper_error.ex:23
  
## simple json api 

https://blog.lelonek.me/minimal-elixir-http2-server-64188d0c1f3a Minimal Elixir JSON RESTful API. How to expose a JSON endpoint in Elixir… | by Kamil Lelonek | Kamil Lelonek - Software Engineer

## auth 

https://powauth.com/ Pow | Pow is a robust, modular, and extendable authentication and user management solution for Phoenix and Plug-based apps.

## phoenix restapi/graphql

## liveview 

- 添加 liveview 到已有项目

https://itnext.io/a-story-of-phoenix-liveview-writing-a-crud-application-d938e52894d4 A Story of Phoenix LiveView: Writing a CRUD Application | by モハマド Meraj モラー | ITNEXT

https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html Phoenix.LiveView — Phoenix LiveView v0.15.4

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `demo` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:demo, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/demo](https://hexdocs.pm/demo).


