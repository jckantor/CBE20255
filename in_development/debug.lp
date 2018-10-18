\* test123 *\
Minimize
OBJ: - 0.9 None_elastic_SubProblem_neg_penalty_var
 + 0.9 None_elastic_SubProblem_pos_penalty_var + w + x + 4 y + 9 z
Subject To
None_elastic_SubProblem_Constraint: None_elastic_SubProblem_free_bound
 + None_elastic_SubProblem_neg_penalty_var
 + None_elastic_SubProblem_pos_penalty_var + w >= -1
c1: x + y <= 5
c2: x + z >= 10
c3: - y + z = 7
Bounds
None_elastic_SubProblem_free_bound = 0
-inf <= None_elastic_SubProblem_neg_penalty_var <= 0
w free
x <= 4
-1 <= y <= 1
End
