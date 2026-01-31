# Universal Polarization Demosaicking Using Newton Polynomial and Residual Interpolation
Source code for paper: (UNRI) Universal Polarization Demosaicking Using Newton Polynomial and Residual Interpolation.

Our paper ([link](https://ieeexplore.ieee.org/document/10896465)) is accepted by IEEE Sensors Journal (JSEN).
## Code
Run code on R2022a or newer version.

Run `path2add.m` at first.

Use `preparecolordata.m` or `preparemonodata.m` to generate the mosaicked and GT images.

Use `mono_main.m` or `color_main.m` to demosaicking and evaluate images.
## Datasets
Datasets are come from [Wen](https://github.com/wsj890411/JCPD_Model) and [Morimatsu](http://www.ok.sc.e.titech.ac.jp/res/PolarDem/index.html).
The color version of the [Wen](https://github.com/wsj890411/JCPD_Model) dataset has been white-balanced using the gray-world algorithm.
## Cite
If the paper is useful to you, please cite it:

```
@ARTICLE{Su2025Universal,
  author={Su, Yiming and Hao, Chunhui and Chen, Wen and Lu, Yang and Tian, Jiandong},
  journal={IEEE Sensors Journal}, 
  title={Universal Polarization Demosaicking Using Newton Polynomial and Residual Interpolation}, 
  year={2025},
  volume={25},
  number={7},
  pages={11508-11520},
  keywords={Interpolation;Polynomials;Sensors;Optical filters;Measurement;Laplace equations;Image reconstruction;Image color analysis;Information filters;Vectors;Division-of-focal-plane (DoFP);polarimetric imaging;polarization demosaicking;polarization filter array (PFA)},
  doi={10.1109/JSEN.2025.3540412}}

```