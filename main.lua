function love.load()
  sprites = {}
  sprites.player = love.graphics.newImage('sprites/player.png')
  sprites.bullet = love.graphics.newImage('sprites/bullet.png')
  sprites.zombie = love.graphics.newImage('sprites/zombie.png')
  sprites.background = love.graphics.newImage('sprites/background.png')

  player = {}
  player.x = 200
  player.y = 200
  player.speed = 180

  zombies = {}
end

function love.update(dt)
  if love.keyboard.isDown("s") then
    player.y = player.y + player.speed * dt
  end
  if love.keyboard.isDown("w") then
    player.y = player.y - player.speed * dt
  end
  if love.keyboard.isDown("a") then
    player.x = player.x - player.speed * dt
  end
  if love.keyboard.isDown("d") then
    player.x = player.x + player.speed * dt
  end

  for i,z in ipairs(zombies) do
    z.x = z.x + math.cos(getZombieAngle(z)) * z.speed * dt
    z.y = z.y + math.sin(getZombieAngle(z)) * z.speed * dt

    if getDistance(z.x, z.y, player.x, player.y) < 30 then
      for i,z in ipairs(zombies) do
        zombies[i] = nil
      end
    end
  end
end

function love.draw()
 love.graphics.draw(sprites.background, 0, 0)
 love.graphics.draw(sprites.player, player.x, player.y, getMouseAngle(), nil, nil, sprites.player:getWidth()/2, sprites.player:getHeight()/2)

 for i, z in ipairs(zombies) do
   love.graphics.draw(sprites.zombie, z.x, z.y, getZombieAngle(z), nil, nil, sprites.zombie:getWidth()/2, sprites.zombie:getHeight()/2)
 end
end

function getMouseAngle()
  return math.atan2(player.y - love.mouse.getY(), player.x - love.mouse.getX()) + math.pi
end

function getZombieAngle(zomb)
  return math.atan2(player.y - zomb.y, player.x - zomb.x)
end

function spawnZombie()
  zombie = {}
  zombie.x = math.random(0, love.graphics.getWidth())
  zombie.y = math.random(0, love.graphics.getHeight())
  zombie.speed = 120

  table.insert(zombies, zombie)
end

function love.keypressed(key, scancode, isrepeat)
  if key == "space" then
    spawnZombie()
  end
end

function getDistance(x1, y1, x2, y2)
  return math.sqrt((y2-y1)^2 + (x2 - x1)^2)
end
