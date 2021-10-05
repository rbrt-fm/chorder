--- stolen from crow_lib on crow. thank you crow 

--- Just Intonation helpers
-- convert a single fraction, or table of fractions to just intonation
-- optional 'offset' is itself a just ratio
-- justvolts converts to volts-per-octave
-- just12 converts to 12TET representation (for *.scale libs)
-- just12 will convert a fraction or table of fractions into 12tet 'semitones'
function _justint(fn, f, off)
    off = off and fn(off) or 0 -- optional offset is a just ratio
    if type(f) == 'table' then
        local t = {}
        for k,v in ipairs(f) do
            t[k] = fn(v) + off
        end
        return t
    else -- assume number
        return fn(f) + off
    end
end
JIVOLT = 1 / math.log(2)
JI12TET = 12 * JIVOLT
function _jiv(f) return math.log(f) * JIVOLT end
function _ji12(f) return math.log(f) * JI12TET end
-- public functions
function justvolts(f, off) return _justint(_jiv, f, off) end
function just12(f, off) return _justint(_ji12, f, off) end
function hztovolts(hz, ref)
    ref = ref or 261.63 -- optional. defaults to middle-C
    return justvolts(hz/ref)
end