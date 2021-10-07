---this is weird 

s = sequins
--i = ii.self.call1

public{timer_1 = 1}:action(function(v) output[1].dyn.timer_1 = v end)
public{crow_scale = {1,1,1,1}}:action(update_scale)
--public{root = 69}

update_scale = function()
	out_array = {}
	for i = 1, #public.crow_scale do
			out_array[i] = hztovolts(public.crow_scale[i],440)
	end 
end  

output[1].done = function()
 output[1].dyn.lev = (math.random()*4) + 1
 output[1]()
 output[2].scale(out_array)
 output[3](pulse())
end 

function init()
	output[1].action = ar(dyn{timer_1 = 1},dyn{timer_1 = 1},dyn{lev = 3})
	output[2].slew = 0.33
end


