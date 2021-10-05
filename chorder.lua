--- la la la

musicutil = require "musicutil"
sequins = require "sequins"
stuff = include "lib/stuff"

mu = musicutil
s = sequins
last_amp = 0
amp_tog = false

play_chrd = function()
  for i, v in ipairs(mu.generate_chord(69,chrds(),inv())) do 
    crow.ii.jf.play_note(hztovolts(mu.note_num_to_freq(v),440),math.random(1,5)) 
  end 
end

inv = s{0,1,2,3,4}
chrds = s{}

function init()
  crow.ii.jf.mode(1)
  crow.ii.wsyn.ar_mode(1)
  chrds:step(2)
  inv:step(2)
  
  chrds:settable(mu.chord_types_for_note(69,69,'major'))
  
  amp_track = poll.set("amp_in_l") 
  
  amp_track.callback = function(x)
    if x > last_amp then
      last_amp = x
      --print(last_amp)
    elseif util.round(x,0.001) == 0 then
      last_amp = 0
    end
    if last_amp < 0.01 then
      play_chrd()
    end 
  end
  
end

function key(n,z)
  if z == 0 then return end 
  if n == 2 then 
    amp_tog = not amp_tog
    play(amp_tog)
  end 
end

play = function(amp_tog)
  if amp_tog then
    amp_track:start()
  else
    amp_track:stop()
  end 
end 
