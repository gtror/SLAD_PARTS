def car_size(x, ytd, x5_min, ca_min, ca_max, cb_min, cb_max, y2_min, y3_min, y5_std, ca_std, cb_std, s_max, s_min, car_rail_h, cwt_rail_h, car_rail_gap, pp_max, pp_min, pp_std)
#	ca range calc first step
	x5_max = car_rail_gap + car_rail_h+600+3
	calc_ca_max = x - 2*(x4_std+x5_min)
	calc_ca_max = [calc_ca_max, ca_max].min
	calc_ca_min = x - 2*(x4_std+x5_max)
	calc_ca_min = [calc_ca_min, ca_min].max
#	cb range calc first step
	calc_cb_max = y - (y2_min + y3_min + y5_std + 130 + 115)
	calc_cb_max = [calc_cb_max, cb_max].min
	calc_cb_min = cb_min
#	generate ca cb array
	ca_array = generate_cacb_array(calc_ca_max, calc_ca_min, ca_std)
	cb_array = generate_cacb_array(calc_cb_max, calc_cb_min, cb_std)
	generate_ca_cb_m(ca_array, cb_array)
end

#generate ca,cb matrix
def generate_ca_cb_m(ca_array, cb_array)
	ca_cb_m = Array.new
	ca_array.each do |ca|
		cb_array.each do |cb|
			ca_cb_m << [ca, cb]
		end
	end 
	return ca_cb_m
end

#generate ca cb array
def generate_cacb_array(ga_calc_ca_max, ga_calc_ca_min, ga_ca_std) # cb as ca calculate
	g_ca_max = ga_calc_ca_max / 50  * 50
	g_ca_min = (ga_calc_ca_min / 50 + ga_calc_ca_min % 50==0?0:1) * 50
	i =  g_ca_min
	g_cab_array = Array.new
	while i <= g_ca_max
		g_cab_array << i
		i=i+50
	end
	g_cab_array << ca_std if not g_cab_array.include?ga_ca_std
	return g_cab_array
end

#area check
def area_check(ca_cb_m,_max, s_min)
	ca_cb_m.each do |m|
		a_cb_m.delate(m) if s < s_min || s > s_max
	end
	return ca_cb_m
end

#pp check
def pp_check(y, ca_cb_m, pp_max, pp_min, y5_std, ee_array)
	ca_cb_m.each do |m|
		bb = m.last +y5_std+130
		ee = calc_ee(ee_array, bb)
		es = bb - ee
		y1 = ee + 115
		y4 = y - y1 - es
		y3_max = pp_max - es
		ca_cb_m.delate(m) if y4 < (y2_min + y3_min) || y4 > (600+y3_max)  || (y - y1 -y2_min) < pp_min
	end
	return ca_cb_m
end

#ee calculate with bb when 1sco
def calc_ee(ee_array, bb)  #eg. ee_array = [[bb1, ee1],[bb2,ee2],[bb3,ee3],..........]
	ee_array.each do |e|
		return e.last if e.first == bb
	end
end
