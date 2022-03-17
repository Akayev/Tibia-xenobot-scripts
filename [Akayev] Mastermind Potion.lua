local forcepotion = true -- Use Mastermind Potion every 10 minutes to boost magic level +3 from main backpack (true/false).

Module.New('Mastermind Potion', function(module)
local PotionCD = 600000 -- 10 minutes
local cont = Container.GetFirst()
    if forcepotion then
	    while (cont:isOpen()) do
            for spot = 0, cont:ItemCount() do
            local item = cont:GetItemData(spot)
                if (item.id == 7440) then
                    cont:UseItem(spot, True)
			        print("Using Mastermind Potion to boost magic level +3.")
	                wait(PotionCD)
	                break
	            end
	        end
	    end
	end
module:Delay(1000)
end)