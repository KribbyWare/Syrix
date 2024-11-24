local WebSocketLib = {}
WebSocketLib.__index = WebSocketLib

local websocketFunctions = {}

function WebSocketLib.new(url)
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

function WebSocketLib:connect()
    print("Connecting to " .. self.url)
    
    wait(1)
    self.connected = true
    
    if self.callbacks.onOpen then
        self.callbacks.onOpen()
    end
end

function WebSocketLib:send(message)
    if not self.connected then
        error("WebSocket is not connected.")
    end
    print("Sending message: " .. message)
end

function WebSocketLib:close()
    if not self.connected then
        error("WebSocket is not connected.")
    end
    print("Closing connection to " .. self.url)
    self.connected = false
    
    if self.callbacks.onClose then
        self.callbacks.onClose()
    end
end

function WebSocketLib:onMessage(callback)
    self.callbacks.onMessage = callback
end

function WebSocketLib:onOpen(callback)
    self.callbacks.onOpen = callback
end

function WebSocketLib:onClose(callback)
    self.callbacks.onClose = callback
end

function WebSocketLib:onError(callback)
    self.callbacks.onError = callback
end

function WebSocketLib:receiveMessage(message)
    if self.callbacks.onMessage then
        self.callbacks.onMessage(message)
    end
end

return {WebSocket = WebSocketLib, functions = websocketFunctions}
