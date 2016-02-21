#The same Brief Example as found in section 1.3 of 
# glpk-4.44/doc/glpk.pdf.
# #
# # maximize
# #   z = 10 * x1 + 6 * x2 + 4 * x3
# #
# # subject to
# #   p:      x1 +     x2 +     x3 <= 100
# #   q: 10 * x1 + 4 * x2 + 5 * x3 <= 600
# #   r:  2 * x1 + 2 * x2 + 6 * x3 <= 300
# #
# # where all variables are non-negative
# #   x1 >= 0, x2 >= 0, x3 >= 0
# #    
require 'rglpk'
p = Rglpk::Problem.new
p.name = "sample"
p.obj.dir = Rglpk::GLP_MAX
rows = p.add_rows(4)
rows[0].name = "p"
rows[0].set_bounds(Rglpk::GLP_UP, 0, 100)
rows[1].name = "q"
rows[1].set_bounds(Rglpk::GLP_UP, 0, 600)
rows[2].name = "r"
rows[2].set_bounds(Rglpk::GLP_UP, 0, 300)
rows[3].name = "sf"
rows[3].set_bounds(Rglpk::GLP_FX, 0, 0)

cols = p.add_cols(4)
cols[0].name = "x1"
cols[0].set_bounds(Rglpk::GLP_LO, 0, 0)
cols[0].kind = Rglpk::GLP_IV
cols[1].name = "x2"
cols[1].set_bounds(Rglpk::GLP_LO, 0, 0)
cols[1].kind = Rglpk::GLP_IV
cols[2].name = "x3"
cols[2].set_bounds(Rglpk::GLP_LO, 0, 0)
cols[2].kind = Rglpk::GLP_IV
cols[3].name = "x4"
cols[3].set_bounds(Rglpk::GLP_LO, 1, 0)
cols[3].kind = Rglpk::GLP_IV

#Rglpk.glp_set_col_kind(lp, 1, Rglpk::GLP_IV)
p.obj.coefs = [10, 6, 4, 0]

p.set_matrix([
	1, 1, 1, 0,
	10, 4, 5, 0,
	2, 2, 6, 0,
	1, 0, 0, -10
])

p.simplex
p.mip
z = p.obj.mip
x1 = cols[0].mip_val
x2 = cols[1].mip_val
x3 = cols[2].mip_val

printf("z = %g; x1 = %g; x2 = %g; x3 = %g\n", z, x1, x2, x3)
