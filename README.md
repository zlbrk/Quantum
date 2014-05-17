Quantum Transport Simulation Project
=====================================

## Main Task / Основная задача
The main task of this project is to provide a toolset for 1-D 
quantum transport simulation based on transfer-matrix approach.

For example it is possible to compute current-voltage characteristics 
of the two-electrode tunneling transducer.

Software implemented with MATLAB technical computing language.

Основная задача -- создать программные средства моделирования квантового
транспорта в одномерных системах на основе метода передаточной матрицы.

Например, можно рассчитать вольтамперные характеристики двухэлектродного 
преобразователя на основе туннельного эффекта.

Программна написана на встроенном языке системы технических расчетов MATLAB.

## Files / Файлы
### Scripts / Скрипты
**Quantum Tunneling Junction Volt-Ampere Characteristics (QTJVAC.m)**
>It is the main script. Structure and VAC presets are presrented here. Visualisation of VAC also implemented in this script.

>Основной скрипт. Параметры структуры и ВАХ представлены здесь. Визуализация ВАХ также реализована в этом скрипте.

**Quantum Tunneling Junction Solver Config (QTJSC.m)**
>In this script we define how broad should be "conduction band" (range of allowed energy states) and dense shold be energy grid (number of transfer-matrices should be computed).

>В этом скрипте мы определяем насколько широкой должна быть "зона проводимости" (диапазон разрешенных энергетических состояний) и насколько густой должна быть сетка по энергиям (число передаточных матриц, подлежащих вычислению).

**Quantum Tuinneling Junction Constants (QTJC.m)**
>In this script global variables (Planck constant, reduced Planck constant, Bolzmann constant, charge and mass of the electron, dielectric permittivity of free space, temperature and temperature potential) are defined.

>В этом скрипте определены глобальные переменные (постоянная Планка, приведенная постоянная Планка, постоянная Больцмана, заряд и масса электрона, диэлектрическая проницаемость вакуума, температура и темперетурный коэффициент).