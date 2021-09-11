--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score

    -- initallize 3 medals 
    self.gold = love.graphics.newImage("1stplace.png")
    self.silver = love.graphics.newImage("2ndplace.png")
    self.bronze = love.graphics.newImage("3rdplace.png")

end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    
    
    if self.score < 5 then
        love.graphics.setFont(flappyFont)
        love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')
    end

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 50, VIRTUAL_WIDTH, 'center')

    local medal = nil
    local imageMedal = nil
    if self.score >= 5 and self.score < 10 then 
        imageMedal = self.bronze
        medal = "bronze"
    elseif self.score >= 10 and self.score < 20 then
        imageMedal = self.silver
        medal = "silver"
    elseif self.score >= 20 then
        imageMedal = self.gold
        medal = "gold"
    end
    
    if imageMedal ~= nil and medal ~= nil then
        love.graphics.printf("Congratulations! You earn " ..medal.. " medal!", 0, 100, VIRTUAL_WIDTH, 'center')
        love.graphics.draw(imageMedal, VIRTUAL_WIDTH / 2 - imageMedal:getWidth() / 2, 120)
    end
    love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
end