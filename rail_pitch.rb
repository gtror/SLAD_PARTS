#for rail pitch
#calc_rails_len = top rail end to the pit buttom
def rail_pitch(calc_rails_len)
	rail_tr = calc_rails_len - 95 
	rail_trp=Array.new
	if rail_tr % 5000 < 2500
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
def bracket_pitch(calc_rails_len, rail_trp)   #rail_trp: array, see rail_pitch
#	bracket_tr = rail_tr +1250
	bracket_tr = calc_rails_len +1250 - 710
	bracket_trp = Array.new
	rail_g = 1250
	bracket_g = 0
	rail_trp.each do |r|
		rail_g = rail_g + r
		while rail_g - bracket_g > r/2 && (bracket_tr - bracket_g > 5000) #for rail = 2500 or 5000 
			if r == 2500 
				bracket_trp << 1500
				bracket_trp << 1000
			else bracket_trp << 2500
			end
			bracket_g = eval bracket_trp.join('+')
		end
	end

	if bracket_tr - bracket_g >2500
		blft1 = (bracket_tr - bracket_g)/2
		blft1 = [blft1, 1500].max
		bracket_g = bracket_g + blft1
		blft2 = bracket_tr - bracket_g
		bracket_trp << blft1
		bracket_trp << blft2
	else bracket_trp << (bracket_tr - bracket_g)
	end
end

#test
def test_rail_pitch(calc_rails_len)
	rail_trp=rail_pitch(calc_rails_len)
	print rail_trp
	print "\n"
	print bracket_pitch(calc_rails_len, rail_trp)
	print "\n"
end
i=3000
kc=1
while i < 13100
	print "*****the #{kc} time test: rail_tr = #{i} ************"
	print "\n"
	test_rail_pitch(i)
	kc = kc + 1
	i = i + 25
end

