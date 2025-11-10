# Conceptual Design of Extremity MRI Magnet Using Commercial MgB₂ Conductor

This repository contains the MATLAB scripts and figures used to produce the poster **"Conceptual design of extremity MRI magnet using commercial MgB₂ conductor"** (KSSC Summer Conference, Aug 22-24, 2023).

The project studies a low field (0.5 T) extremity MRI magnet using commercially available MgB₂ conductors. The main objectives were:
- to reach 0.5 T inside a defined Diameter Spherical Volume (DSV),
- to minimize field non-uniformity (homogeneity in ppm),
- to check the 5 gauss line for safety,
- and to explore feasibility under a 20 K operating condition with an assumed critical current margin.

The MATLAB scripts in `matlab/` run the coil geometry and field evaluation, call an axisymmetric field solver (`SolB.m`), and use simple optimization (`fmincon`) to search coil-to-coil gaps that improve homogeneity. The poster in `poster/` is the final result.

## Repository structure

```text
.
├── README.md
├── LICENSE
├── .gitignore
├── matlab/
├── figures/
└── poster/
```
## MATLAB version

These scripts were written for MATLAB with Optimization Toolbox available, since `fmincon` is used. The numerical integrator uses Gauss–Legendre nodes from `lgwt.m`.

## How to run

1. Open MATLAB.
2. Add the `matlab/` folder to the path:
   ```matlab
   addpath('matlab');
   ```
3. Run the optimization script:
   ```matlab
   extremity_fmincon
   ```
4. Plot useful visualisations:
   ```matlab
   Plot_ppm
   five_gauss_calculation
   gausline_plot
   ```

## 5 gauss line and MRI safety

MR systems typically define a controlled zone around the magnet where the fringe field is 5 gauss (0.5 mT) or lower. The script `five_gauss_calculation.m` computes the spatial distribution of the fringe field and contours the 5 gauss line so you can estimate how far equipment or people should be from the magnet to stay below that level.

## GitHub usage

This repository is structured so you can push it directly to GitHub:

```bash
git init
git add .
git commit -m "Initial commit: MgB2 extremity MRI design"
git branch -M main
git remote add origin <your-remote-url>
git push -u origin main
```

