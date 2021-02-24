# Demo

https://hexdocs.pm/plug/readme.html Plug — Plug v1.11.0
https://hexdocs.pm/phoenix/overview.html#content Overview — Phoenix v1.5.7
https://hexdocs.pm/ecto/getting-started.html#content Getting Started — Ecto v3.5.7

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

插入数据  use Ecto to insert a record.

SimpleWeb.Repo.start_link()

user = %SimpleWeb.User{id: 1, first_name: "Fluffums", last_name: "the Cat"}

user = %SimpleWeb.User{first_name: "Fluffums", last_name: "the Cat"}

{:ok, user} = SimpleWeb.Repo.insert user

SimpleWeb.Repo.insert!(user)

Ecto.Changeset.cast(paams, [allow_list])
  allow_list 中的 fields 才允许传入

Ecto.Changeset.validate_required([required_list])
  required_list 必填项

启动应用

{:ok, _} = Plug.Adapters.Cowboy.http SimpleWeb.IndexRouter, []
SimpleWeb.Repo.start_link()

! 添加 ecto 到 supervisor

- Test

只需要给 router 的 call 方法传递 Conn 即可

https://hexdocs.pm/ecto/testing-with-ecto.html Testing with Ecto — Ecto v3.5.7

mix.exs alias

def project do
  [
    aliases: aliases()
  ]
end

defp aliases do
  [
    "test": ["ecto.create --quiet", "ecto.migrate", "test"]
  ]
end

https://elixirforum.com/t/so-what-is-the-problem-with-sqlite/1602 So what is the problem with sqlite? - Phoenix Forum / Questions / Help - Elixir Programming Language Forum

https://github.com/elixir-sqlite/sqlite_ecto2 elixir-sqlite/sqlite_ecto2: Sqlite3 adapter for Ecto 2.2.x
https://github.com/elixir-sqlite/sqlite_ecto2/blob/master/docs/tutorial.md sqlite_ecto2/tutorial.md at master · elixir-sqlite/sqlite_ecto2

- Deploy on Gigalixir

- mix deps version

{:postgrex, ">= 0.0.0"}, 希望是最新版本

Failed to use "ecto" (versions 3.5.0 to 3.5.7) because
  sqlite_ecto (version 1.1

https://stackoverflow.com/questions/27322330/mix-compiliation-fails-when-compiling-ecto elixir - Mix compiliation fails when compiling Ecto - Stack Overflow
https://elixirforum.com/t/mix-deps-update-working-as-mix-deps-downgrade/27099 Mix deps.update working as mix deps.downgrade - Questions / Help - Elixir Programming Language Forum
https://elixirforum.com/t/mix-deps-update-working-as-mix-deps-downgrade/27099/11 Mix deps.update working as mix deps.downgrade - Questions / Help - Elixir Programming Language Forum

    warning: System.stacktrace/0 is deprecated, use __STACKTRACE__ instead
      lib/plug/conn/wrapper_error.ex:23

    warning: Decimal.cmp/2 is deprecated. Use compare/2 instead
      lib/ecto/changeset.ex:2160: Ecto.Changeset.validate_number/6
  
## simple json api 

https://blog.lelonek.me/minimal-elixir-http2-server-64188d0c1f3a Minimal Elixir JSON RESTful API. How to expose a JSON endpoint in Elixir… | by Kamil Lelonek | Kamil Lelonek - Software Engineer

## auth 

https://powauth.com/ Pow | Pow is a robust, modular, and extendable authentication and user management solution for Phoenix and Plug-based apps.

## phoenix restapi/graphql

## liveview 

- 添加 liveview 到已有项目
https://itnext.io/a-story-of-phoenix-liveview-writing-a-crud-application-d938e52894d4 A Story of Phoenix LiveView: Writing a CRUD Application | by モハマド Meraj モラー | ITNEXT

https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html Phoenix.LiveView — Phoenix LiveView v0.15.4

## Q&A

- how to change mix project name easily

There is not a command for renaming a project.

grep -r 'App01' --exclude-dir deps --exclude-dir _build .

find and replace files in folder recursively

find . -type f -name "*.txt" -print0 | xargs -0 sed -i '' -e 's/foo/bar/g'


grep -rl 'App01' --exclude-dir deps --exclude-dir _build --exclude-dir assets . | xargs sed -i 's/App01/PhxDemo/g'

grep -rl 'app01' --exclude-dir deps --exclude-dir _build --exclude-dir assets . | xargs sed -i 's/app01/phx_demo/g'

https://stackoverflow.com/questions/1583219/how-to-do-a-recursive-find-replace-of-a-string-with-awk-or-sed bash - How to do a recursive find/replace of a string with awk or sed? - Stack Overflow

https://unix.stackexchange.com/questions/227662/how-to-rename-multiple-files-using-find shell - How to rename multiple files using find - Unix & Linux Stack Exchange

https://stackoverflow.com/questions/4210042/how-to-exclude-a-directory-in-find-command linux - How to exclude a directory in find . command - Stack Overflow

https://unix.stackexchange.com/questions/32155/find-command-how-to-ignore-case Find command: how to ignore case? - Unix & Linux Stack Exchange

https://stackoverflow.com/questions/13210880/replace-one-substring-for-another-string-in-shell-script bash - Replace one substring for another string in shell script - Stack Overflow

find . -type d \( -path dir1 -o -path dir2 -o -path dir3 \) -prune -false -o -name '*.txt'

find . \( -path ./_build -o -path ./deps -o -path dir3 \) -prune -false -o -iname 'App01*' -print0 | xargs --null -I{} mv {} {}_renamed

mv "$file_name" "${file_name##*\/}_renamed"

echo "${file_name##*\/}_renamed"

oldname="app01"
newname="phx_demo"
echo "${file_name/app01/$newname}"

rename files:

find . \( -path ./_build -o -path ./deps -o -path dir3 \) -prune -false -o -iname 'App01*' -print0 |
while IFS= read -d '' file_name; do
  newname="phx_demo"
  mv "$file_name" "${file_name/app01/$newname}"
done

rename modules:

(GNU/Linux)

grep -rl 'App01' --exclude-dir deps --exclude-dir _build --exclude-dir assets . | xargs sed -i 's/App01/PhxDemo/g'

grep -rl 'app01' --exclude-dir deps --exclude-dir _build --exclude-dir assets . | xargs sed -i 's/app01/phx_demo/g'

(macOS)

grep -rl 'App01' --exclude-dir deps --exclude-dir _build --exclude-dir assets . | xargs sed -i "" -e 's/App01/PhxDemo/g'

grep -rl 'app01' --exclude-dir deps --exclude-dir _build --exclude-dir assets . | xargs sed -i "" -e 's/app01/phx_demo/g'

- is_integer

@spec is_integer(term()) :: boolean() 为何没有 ?
@spec valid?(t()) :: boolean() (h String.valid?)

- elixir phoenix vs plug 

plug restapi 

plug graphql 

phx restapi 

phx graphql 

elixir swagger/openapi 

elixir graphql Craft GraphQL APIs in Elixir with Absinthe

https://thinkingelixir.com/rest-vs-graphql-for-an-api/ REST vs GraphQL for an API - Thinking Elixir

https://codewords.recurse.com/issues/five/building-a-web-framework-from-scratch-in-elixir

https://elixirforum.com/t/using-phoenix-as-a-kitchen-sink-web-framework-vs-a-lightweight-toolkit/28780 Using Phoenix as a "kitchen sink" web framework vs a lightweight toolkit? - Phoenix Forum / Chat / Discussions - Elixir Programming Language Forum

- State Machines in Elixir
  https://blog.techdominator.com/article/implementing-state-machine-elixir.html Implementing a state machine in elixir - Tech Dominator
  https://medium.com/@joaomdmoura/state-machine-in-elixir-with-machinery-8ee6f9def2da State Machine in Elixir with Machinery | by João Moura | Medium
  https://8thlight.com/blog/kevin-buchanan/2020/05/20/exstate.html ExState: Database-backed statecharts for Elixir and Ecto | 8th Light
  https://www.oreilly.com/library/view/functional-web-development/9781680505436/f_0026.xhtml State Machines - Functional Web Development with Elixir, OTP, and Phoenix [Book]

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


https://blog.appsignal.com/category/elixir-alchemy.html

https://blog.appsignal.com/2020/07/14/building-state-machines-in-elixir-with-ecto.html Building State Machines in Elixir with Ecto | AppSignal Blog

https://blog.appsignal.com/2019/07/04/elixir-alchemy-building-go-in-elixir-time-travel-and-the-ko-rule.html Building the Go Game in Elixir: Time Travel and the Ko Rule | AppSignal Blog

https://blog.appsignal.com/2019/07/16/elixir-alchemy-metaprogramming.html Metaprogramming: From C Preprocessing to Elixir Macros | AppSignal Blog

https://blog.appsignal.com/2020/01/29/how-to-get-your-elixir-application-ready-for-ci-cd.html How to Get Your Elixir Application Ready for CI/CD | AppSignal Blog

https://blog.appsignal.com/2019/09/10/flags-seeds-idempotency-elixir.html Flags, Seeds and Idempotency: Database Tooling with Elixir | AppSignal Blog

https://blog.appsignal.com/2019/12/12/how-to-use-broadway-in-your-elixir-application.html How to Use Broadway in Your Elixir Application | AppSignal Blog

https://blog.appsignal.com/2019/01/22/serving-plug-building-an-elixir-http-server.html Serving Plug: Building an Elixir HTTP server from scratch | AppSignal Blog

https://thoughtbot.com/blog/instrumenting-your-phoenix-application-using-telemetry Instrumenting your Phoenix application using telemetry




