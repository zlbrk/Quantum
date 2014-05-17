Quantum Transport Simulation Project
=====================================

## Main Task / Основная задача
The main task of this project is to provide a toolset for 1-D 
quantum transport simulation based on transfer-matrix approach. For example it is possible to compute current-voltage characteristics of the two-electrode tunneling transducer. Software implemented with MATLAB technical computing language.

Основная задача -- создать программные средства моделирования квантового
транспорта в одномерных системах на основе метода передаточной матрицы. Например, можно рассчитать вольтамперные характеристики двухэлектродного 
преобразователя на основе туннельного эффекта. Программна написана на встроенном языке системы технических расчетов MATLAB.

## Files / Файлы
### Scripts / Скрипты
**Quantum Tunneling Junction Volt-Ampere Characteristics (QTJVAC.m)**
It is the main script. Structure and VAC presets are presrented here. Visualisation of VAC also implemented in this script.

>Основной скрипт. Параметры структуры и ВАХ представлены здесь. Визуализация ВАХ также реализована в этом скрипте.

**Quantum Tunneling Junction Solver Config (QTJSC.m)**
In this script we define how broad should be "conduction band" (range of allowed energy states) and dense shold be energy grid (number of transfer-matrices should be computed).

>В этом скрипте мы определяем насколько широкой должна быть "зона проводимости" (диапазон разрешенных энергетических состояний) и насколько густой должна быть сетка по энергиям (число передаточных матриц, подлежащих вычислению).

**Quantum Tuinneling Junction Constants (QTJC.m)**
In this script global variables (Planck constant, reduced Planck constant, Bolzmann constant, charge and mass of the electron, dielectric permittivity of free space, temperature and temperature potential) are defined.

>В этом скрипте определены глобальные переменные (постоянная Планка, приведенная постоянная Планка, постоянная Больцмана, заряд и масса электрона, диэлектрическая проницаемость вакуума, температура и темперетурный коэффициент).

### Functions / Функции
**Multiple-Scale Mesh Generator (MSMG.m)**
This function generates grid for computation and visualization of the pice-wise potential relief and computes lengths of the equipotential layers.

>Эта функция генерирует сетку для расчета и визуализации потенциального кусочно-постоянного потенциального рельефа и рассчитывает протяженности эквипотенциальных слоев.

**Pice-Wise Barrier Representation (PWBR.m)**
This function generates pice-wise barrier representation corresponding to the problem, which shold be solved. The main parameters are: distance between electrodes, work function of the electrodes, bias voltage. This function requires mesh generated with MSMG function.

>Эта функция генерирует кусочно-постоянное представление потенциального барьера, соответствующее решаемой задаче. Основные параметры это: расстояние между электродами, работа выхода электродов, приложенное напряжение. Этой функции передается сетка, полученная с помощью функции MSMG. 

**Evaluate Current Density of Quantum Tunneling Junction (ECDQTJ.m)**
This function computes tunneling current density in two-electrode system. Parameters of the function are: potential relief, bias voltage, equipotential layers lenghts.

>Эта функция предназначена для расчета плотности туннельного тока в двухэлектродной системе. Параметрами ялвяются: потенциальный рельеф, приложенное напряжение, протяженности эквипотенциальных слоев.

**Transfer-Matrix of the Quantum Tunneling Junction (TMQTJ.m)**
This function computes transfer-matrix for allowed energy state and evaluates reflection and transmission coefficients. Parameters are: equipotential layers lenghts, potential relief, electron energy.

>Эта функция строит передаточную матрицу разрешенного энергетического состояния и вычисляет коэффициенты отражения и прохождения. Параметры: протяженности эквипотенциальных слоев, потенциальный рельеф, энергия электрона. 