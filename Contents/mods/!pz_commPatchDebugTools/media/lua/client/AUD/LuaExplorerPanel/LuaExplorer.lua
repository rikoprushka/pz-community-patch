require("AUD/Init")
AUD.LuaExplorer = {}

AUDLuaExplorer = ISTabPanel:derive("AUDLuaExplorer")


function AUDLuaExplorer:initialise()
    ISTabPanel.initialise(self);

    self:setAnchorBottom(true);
    self:setAnchorRight(true);
    self.target = self;
    self:setEqualTabWidth(true)
    self:setCenterTabs(true)
    AUD.luaExplorerWindow = self:wrapInCollapsableWindow("Lua explorer");
    
    local closeFunc = function(obj)
        AUD.LuaExplorerPanel.lastX = AUD.luaExplorerWindow.x
        AUD.LuaExplorerPanel.lastY = AUD.luaExplorerWindow.y
        AUD.LuaExplorerPanel.lastWidth = AUD.luaExplorerWindow.width
        AUD.LuaExplorerPanel.lastHeight = AUD.luaExplorerWindow.height - 24
        AUD.LuaExplorerPanel.lastPosSaved = true

        ISCollapsableWindow.close(obj);
        AUD.luaExplorerWindow:setRemoved(true)
        AUD.LuaExplorerPanel.toolbarButton:setImage(AUD.LuaExplorerPanel.texture_Off)
    end
    
    AUD.luaExplorerWindow.close = closeFunc
    AUD.luaExplorerWindow.closeButton.onmousedown = closeFunc
    AUD.luaExplorerWindow:setResizable(true);

    -- Favorite tab
    AUD.LuaExplorer.favTab = AUDLuaExplorerTab:new(0, 48, AUD.luaExplorerWindow:getWidth(), AUD.luaExplorerWindow:getHeight() - AUD.luaExplorerWindow.nested.tabHeight)
    AUD.LuaExplorer.favTab:initialise("FAV")
    AUD.luaExplorerWindow.nested:addView("Favorite", AUD.LuaExplorer.favTab)

    -- All tab
    AUD.LuaExplorer.allTab = AUDLuaExplorerTab:new(0, 48, AUD.luaExplorerWindow:getWidth(), AUD.luaExplorerWindow:getHeight() - AUD.luaExplorerWindow.nested.tabHeight)
    AUD.LuaExplorer.allTab:initialise("ALL")
    AUD.luaExplorerWindow.nested:addView("All", AUD.LuaExplorer.allTab)

    AUD.luaExplorerWindow:addToUIManager();
    AUD.LuaExplorerPanel.toolbarButton:setImage(AUD.LuaExplorerPanel.texture_On)
end

