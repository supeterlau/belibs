defmodule SimpleWeb.Router do
  defmacro __using__(_opts) do
    quote do
      def init(opts), do: opts

      def call(conn, _opts) do
        route(conn.method, conn.path_info, conn)
      end
    end
  end
end
