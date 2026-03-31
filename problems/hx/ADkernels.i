# couette.i - generated mesh for 2x1 rectangular channel
[Mesh]
    type = FileMesh
    file = cylinder.msh
    dim = 2
[]

[Variables]
    [vel]
        order = SECOND
        family = LAGRANGE_VEC
    []
    [temp]
        family = LAGRANGE
        order = FIRST
    []
    [p]
        family = LAGRANGE
        order = FIRST
    []
[]

# Dirichlet BCs: top (u,v)=(3,0), bottom (u,v)=(0,0)
[BCs]
    # Velocity BCs: no-slip on bottom, top, and cylinder walls, inlet on left, outlet on right
    [stationary_wall]
        type = VectorFunctionDirichletBC
        variable = vel
        boundary = 'Bottom Top CylinderWalls'
        function_x = '0'
        function_y = '0'
    []
    [inlet]
        type = VectorFunctionDirichletBC
        variable = vel
        boundary = 'Inlet'
        function_x = '1.0'
        function_y = '0'
    []

    # Pressure BCs: zero pressure at outlet
    [./inlet_p]
        type = DirichletBC
        variable = p
        boundary = 'Inlet'
        value = 1.0
    [../]
    [./outlet_p]
        type = NeumannBC
        variable = p
        boundary = 'Outlet'
        value = 0.0
    [../]

    # Temperature BCs: T=1 on top, T=0 on bottom, insulated (Neumann) on left and right
    [./heated_wall]
        type = DirichletBC
        variable = temp
        boundary = 'CylinderWalls'
        value = 1.0
    [../]
    [./cooled_wall]
        type = DirichletBC
        variable = temp
        boundary = 'Top Bottom'
        value = 0.0
    [../]
    [./inlet_T]
        type = DirichletBC
        variable = temp
        boundary = 'Inlet'
        value = 0.0
    [../]
    [./outlet_T]
        type = NeumannBC
        variable = temp
        boundary = 'Outlet'
        value = 0.0
    [../]
[]

[ICs]
    [./vel]
        type = VectorFunctionIC
        variable = vel
        function_x = '0.0'       # Linear initial guess for u
        function_y = '0.0'       # Initial guess for v
    [../]
    [./p]
        type = FunctionIC
        variable = p
        function = '1.0' # Initial guess for pressure
    [../]
    [./temp]
        type = FunctionIC
        variable = temp
        function = '0.0' # Linear initial guess for T
    [../]
[]

[Materials]
    [./const]
        type = ADGenericConstantMaterial
        prop_names = 'rho mu cp k'
        prop_values = '1.0 1.0 1.0 0.1'
    [../]
    [ins_mat]
        type = INSADStabilized3Eqn
        velocity = vel
        pressure = p
        temperature = temp
    []
[]

[Kernels]
    [mass]
        type = INSADMass
        variable = p
    []
    [momentum_convection]
        type = INSADMomentumAdvection
        variable = vel
    []
    [momentum_viscous]
        type = INSADMomentumViscous
        variable = vel
    []
    [momentum_pressure]
        type = INSADMomentumPressure
        variable = vel
        pressure = p
    []
    [momentum_supg]
        type = INSADMomentumSUPG
        variable = vel
        velocity = vel
    []
    [./diff_T]
        type = Diffusion
        variable = temp
    [../]
[]

[Executioner]
    type = Transient
    scheme = BDF2
    dt = 0.01
    end_time = 2.0
[]

[Outputs]
    exodus = true
    file_base = cylinder
    perf_graph = true
[]