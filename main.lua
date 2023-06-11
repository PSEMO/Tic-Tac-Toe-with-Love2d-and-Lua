local TileCount = 3
local TileSize = 100

local MouseIsinTheArea = false
local MouseArea = {x, y}

local Tiles =
{
    [1] = 0,
    [2] = 0,
    [3] = 0,
    [4] = 0,
    [5] = 0,
    [6] = 0,
    [7] = 0,
    [8] = 0,
    [9] = 0,
}

local isXsTurn = true

local isMouseBtnDown = false

local isGameEnded = false

function love.load()
    
end

function love.draw()

    font = love.graphics.setNewFont(100)
    local Xwidth = font:getWidth("X")
    local Xheight = font:getHeight("X")
    local Owidth = font:getWidth("O")
    local Oheight = font:getHeight("O")

    MouseIsinTheArea = false
    for y = 1, TileCount, 1
    do
        for x = 1, TileCount, 1
        do
            local posX = x * TileSize
            local posY = y * TileSize

            if(isMouseIn(love.mouse.getX(), love.mouse.getY(), posX, posY, posX + TileSize, posY + TileSize))
            then
                MouseIsinTheArea = true
                MouseArea.x = x
                MouseArea.y = y

                love.graphics.setColor(1, 0, 0)
            end

            love.graphics.rectangle("line", posX + 2 * x, posY + 2 * y, TileSize, TileSize)

            love.graphics.setColor(1, 1, 1)
        end
    end


    for i, a in ipairs(Tiles)
    do
        local pos = LinearArrayToTwoDArray(i)

        if(a == 1)
        then
            love.graphics.print("X", (TileSize * pos[1]) + (TileSize / 2) - Xwidth / 2, (TileSize * pos[2]) + (TileSize / 2) - Xheight / 2)
        elseif(a == 2)
        then
            love.graphics.print("O", (TileSize * pos[1]) + (TileSize / 2) - Owidth / 2, (TileSize * pos[2]) + (TileSize / 2) - Oheight / 2)
        end
        
    end
end

function love.update(dt)
    
    if(not isGameEnded)
    then 
        if(love.mouse.isDown(1))
        then
            if(MouseIsinTheArea and isMouseBtnDown == false)
            then
                local hasPlayed = false
                if(Tiles[TwoDPosToLinearArray(MouseArea.x, MouseArea.y)] ~= 0)
                then
                    hasPlayed = true
                end

                if(not hasPlayed)
                then
                    play() 
                    isMouseBtnDown = true
                end
            end
        else
            isMouseBtnDown = false
        end 
    end
end

function play()
    
    local x = MouseArea.x
    local y = MouseArea.y

    local saveValue = 2
    if(isXsTurn)
    then
        saveValue = 1
    end

    isXsTurn = not isXsTurn

    Tiles[TwoDPosToLinearArray(x, y)] = saveValue

    determineGameEnd()
    print(isGameEnded)
end

function TwoDPosToLinearArray(x, y)

    if(x == 1 and y == 1)
    then--1
        return 1
    elseif(x == 2 and y == 1)
    then--2
        return 2
    elseif(x == 3 and y == 1)
    then--3
        return 3
    elseif(x == 1 and y == 2)
    then--4
        return 4
    elseif(x == 2 and y == 2)
    then--5
        return 5
    elseif(x == 3 and y == 2)
    then--6
        return 6
    elseif(x == 1 and y == 3)
    then--7
        return 7
    elseif(x == 2 and y == 3)
    then--8
        return 8
    elseif(x == 3 and y == 3)
    then--9
        return 9
    end
end

function LinearArrayToTwoDArray(a)

    if(a == 1)
    then
        return{1, 1}
    elseif(a == 2)
    then
        return{2, 1}
    elseif(a == 3)
    then
        return{3, 1}
    elseif(a == 4)
    then
        return{1, 2}
    elseif(a == 5)
    then
        return{2, 2}
    elseif(a == 6)
    then
        return{3, 2}
    elseif(a == 7)
    then
        return{1, 3}
    elseif(a == 8)
    then
        return{2, 3}
    elseif(a == 9)
    then
        return{3, 3}
    end   
end

function determineGameEnd()
    
    if(Tiles[1] == Tiles[2] and Tiles[2] == Tiles[3] and Tiles[3] ~= 0)
    then
        isGameEnded = true
        print("a1")
    elseif(Tiles[4] ==  Tiles[5] and Tiles[5] == Tiles[6] and Tiles[6] ~= 0)
    then
        isGameEnded = true
        print("a2")
    elseif(Tiles[7] == Tiles[8] and Tiles[8] == Tiles[9] and Tiles[9] ~= 0)
    then
        isGameEnded = true
        print("a3")
    elseif(Tiles[1] == Tiles[5] and Tiles[5] == Tiles[9] and Tiles[9] ~= 0)
    then
        isGameEnded = true
        print("a4")
    elseif(Tiles[7] == Tiles[5] and Tiles[5] == Tiles[3] and Tiles[3] ~= 0)
    then
        isGameEnded = true
        print("a5")
    elseif(Tiles[7] == Tiles[4] and Tiles[4] == Tiles[1] and Tiles[1] ~= 0)
    then
        isGameEnded = true
        print("a6")
    elseif(Tiles[2] == Tiles[5] and Tiles[5] == Tiles[8] and Tiles[8] ~= 0)
    then
        isGameEnded = true
        print("a7")
    elseif(Tiles[3] == Tiles[6] and Tiles[6] == Tiles[9] and Tiles[9] ~= 0)
    then
        isGameEnded = true
        print("a8")
    end
    --isGameEnded
end

function isMouseIn(mouseX, mouseY, x1, y1, x2, y2)

    if(mouseX > x1 and mouseX < x2 and 
        mouseY > y1 and mouseY < y2)
    then
        return true
    else
        return false
    end
end