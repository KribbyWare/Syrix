local WebSocket = {}
WebSocket.__index = WebSocket

function WebSocket.new(url)
    local self = setmetatable({}, WebSocket)
    self.url = url
    self.connected = false
    self.callbacks = {
        onMessage = nil,
        onOpen = nil,
        onClose = nil,
        onError = nil,
    }
    return self
end

function WebSocket:connect()
    print("Connecting to " .. self.url)
    
    wait(1)
    self.connected = true
    
    if self.callbacks.onOpen then
        self.callbacks.onOpen()
    end
end

function WebSocket:send(message)
    if not self.connected then
        error("WebSocket is not connected.")
    end
    print("Sending message: " .. message)
end

function WebSocket:close()
    if not self.connected then
        error("WebSocket is not connected.")
    end
    print("Closing connection to " .. self.url)
    self.connected = false
    
    if self.callbacks.onClose then
        self.callbacks.onClose()
    end
end

function WebSocket:onMessage(callback)
    self.callbacks.onMessage = callback
end

function WebSocket:onOpen(callback)
    self.callbacks.onOpen = callback
end

function WebSocket:onClose(callback)
    self.callbacks.onClose = callback
end

function WebSocket:onError(callback)
    self.callbacks.onError = callback
end

function WebSocket:receiveMessage(message)
    if self.callbacks.onMessage then
        self.callbacks.onMessage(message)
    end
end

return WebSocket
