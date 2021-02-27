defmodule Nautilus.Network.TCPSender do

    @behaviour Application.get_env(:nautilus, :MessageSenderPort)

    def send_message(pid, message) do
        GenServer.cast(pid, {:send_message, message})
    end

end