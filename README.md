Quantum Transport Simulation Project
=====================================

## Main Task
The main task of this project is to provide a tool set for 1-D quantum transport simulation based on transfer-matrix approach. For example it is possible to compute current-voltage characteristics of the two-electrode tunneling transducer. Software implemented with MATLAB technical computing language.

## Files
### Scripts
**Quantum Tunneling Junction Volt-Ampere Characteristics (QTJVAC.m)**

It is the main script. Structure and VAC presets are presented here. Visualization of VAC also implemented in this script.

**Quantum Tunneling Junction Solver Config (QTJSC.m)**

In this script we define how broad should be "conduction band" (range of allowed energy states) and how dense should be energy grid (number of transfer-matrices should be computed).

**Quantum Tunneling Junction Constants (QTJC.m)**

In this script global variables (Planck constant, reduced Planck constant, Boltzmann constant, charge and mass of the electron, dielectric permittivity of free space, temperature and temperature potential) are defined.

### Functions
**Multiple-Scale Mesh Generator (MSMG.m)**

This function generates grid for computation and visualization of the piece-wise potential relief and computes lengths of the equipotential layers.

**Piece-Wise Barrier Representation (PWBR.m)**

This function generates piece-wise barrier representation corresponding to the problem, which should be solved. The main parameters are: distance between electrodes, work function of the electrodes, bias voltage. This function requires mesh generated with MSMG function.

**Evaluate Current Density of Quantum Tunneling Junction (ECDQTJ.m)**

This function computes tunneling current density in two-electrode system. Parameters of the function are: potential relief, bias voltage, equipotential layers lengths.

**Transfer-Matrix of the Quantum Tunneling Junction (TMQTJ.m)**

This function computes transfer-matrix for allowed energy state and evaluates reflection and transmission coefficients. Parameters are: equipotential layers lengths, potential relief, electron energy.