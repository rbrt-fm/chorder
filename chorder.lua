--- la la la

mu = require "musicutil"
s = require "sequins"
stuff = include "lib/stuff"
p = crow.public
hz = hztovolts

last_amp = 0
amp_tog = false
start_timer = 0
stop_timer = 0
timer_1 = 1
root = 69

inv = s{0,1,2,3,4}:step(2)
chrds = s{}:step(1)
crow_scale = {1,1,1,1}

play_chrd = function()
  chrd = mu.generate_chord(69,chrds(),inv())
  p.crow_scale = mu.note_nums_to_freqs(chrd)
  for i, v in ipairs(chrd) do 
    crow.ii.jf.play_note(hz(mu.note_num_to_freq(v),440),math.random(1,6))
  end 
end

play = function(amp_tog)
  if amp_tog then
    amp_track:start()
  else
    amp_track:stop()
  end 
end 


function init()
  norns.crow.loadscript('crowder.lua')
  crow.ii.jf.mode(1)
  --crow.output[1]()
  --crow.ii.wsyn.ar_mode(1)
  
  chrds:settable(mu.chord_types_for_note(69,69,'major'))
  
  amp_track = poll.set("amp_in_l") 
  amp_track.time = 0.01
  
  amp_track.callback = function(x)
    if x > last_amp then
      last_amp = x
    elseif util.round(x,0.001) == 0 then
      last_amp = 0
      play_chrd()
      stop_timer = util.time() - start_timer
      p.timer_1 = util.round(stop_timer, 0.001)
    end
    if last_amp < 0.01 then
      start_timer = util.time()
    end 
  end
  
end

function key(n,z)
  if z == 0 then return end 
  if n == 2 then 
    amp_tog = not amp_tog
    play(amp_tog)
    crow.output[1]()
  end 
end

