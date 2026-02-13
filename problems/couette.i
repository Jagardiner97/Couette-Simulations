# couette.i - generated mesh for 2x1 rectangular channel
[Mesh]
    type = GeneratedMesh
    dim = 2
    nx = 40
    ny = 20
    xmin = 0.0
    xmax = 2.0
    ymin = 0.0
    ymax = 1.0
[]

[Variables]
    [./u]
        family = LAGRANGE
        order = FIRST
    [../]
    [./v]
        family = LAGRANGE
        order = FIRST
    [../]
[]

# Dirichlet BCs: top (u,v)=(3,0), bottom (u,v)=(0,0)
[BCs]
    [./top_u]
        type = DirichletBC
        variable = u
        boundary = 'top'
        value = 3.0
    [../]
    [./top_v]
        type = DirichletBC
        variable = v
        boundary = 'top'
        value = 0.0
    [../]
    [./bottom_u]
        type = DirichletBC
        variable = u
        boundary = 'bottom'
        value = 0.0
    [../]
    [./bottom_v]
        type = DirichletBC
        variable = v
        boundary = 'bottom'
        value = 0.0
    [../]

    # Left: inlet (prescribe uniform inlet velocity)
    [./left_u]
        type = DirichletBC
        variable = u
        boundary = 'left'
        value = 3.0
    [../]
    [./left_v]
        type = DirichletBC
        variable = v
        boundary = 'left'
        value = 0.0
    [../]

    # Right: outlet (zero Neumann / natural outflow)
    [./right_u]
        type = NeumannBC
        variable = u
        boundary = 'right'
        value = 0.0
    [../]
    [./right_v]
        type = NeumannBC
        variable = v
        boundary = 'right'
        value = 0.0
    [../]
[]

[ICs]
    [./u]
        type = FunctionIC
        variable = u
        function = '3.0 * y' # Linear initial guess for u
    [../]
    [./v]
        type = FunctionIC
        variable = v
        function = '0.0' # Initial guess for v
    [../]
[]

# Note: add appropriate Kernels / Materials for your PDE (e.g., Navier-Stokes) below.
[Kernels]
    [./diff_x]
        type = Diffusion
        variable = u
    [../]
    [./diff_y]
        type = Diffusion
        variable = v
    [../]
[]

[Executioner]
    type = Steady
    solve_type = PJFNK
    l_tol = 1e-8
    nl_max_its = 50
[]

[Outputs]
    exodus = true
    file_base = couette
    perf_graph = true
[]