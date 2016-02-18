#for rail pitch
def rail_pitch(rail_tr)
    rail_trp=Array.new
    if rail_tr % 5000 < 2500
	    #rail_trc = rail_tr
    	rail_trp << rail_tr % 5000 + 2500
    	rail_trp << 2500
    	((rail_tr - (rail_tr % 5000 + 5000))/5000).times {rail_trp << 5000}
    else
        rail_trp << rail_tr % 5000
        ((rail_tr - (rail_tr % 5000 ))/5000).times {rail_trp << 5000}
    end
    rail_trp.reverse!
    #print rail_trp.reverse!
    return rail_trp
end

#for bracket
def bracket_pitch(rail_tr, rail_trp=rail_pitch(rail_tr))
    bracket_tr = rail_tr +1250
    bracket_trp = Array.new
	#rail_g =  1250
	rail_g = 1250
	bracket_g = 0
		rail_trp.each do |r|
		    rail_g = rail_g + r
			while rail_g - bracket_g > r/2
				if r == 2500 
					bracket_trp << 1500
					bracket_trp << 1000
				else bracket_trp << 2500
				end
				bracket_g = eval bracket_trp.join('+')
			end
			
		end
		bracket_trp << (bracket_tr - bracket_g)
end

#rail_tr = 10700
#rail_trp=rail_pitch(rail_tr)
#print rail_trp
#print "\n"
#print bracket_pitch(10700, rail_trp)
