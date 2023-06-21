File for bifurcation analysis using MatCont.

* Model :
    * Zerlaut_model_adpa.m : equation
    * Zerlaut_adap.m : model for matcont
    * start_analyse.m : initialise system for the bifurcation
    * load_parameters.m : load parameters form file
    * parameter.mat : default parameters

* Order for the analysis:
    * step_0_integration.m : testing the model and end limit circle or fixed point
    * step_1_run_analyse_LC.m : bifurcation analysis of limit circle
    * step_2_run_analyse_EQ_high_fixed_point.m : bifurcation of one equilibrium 
    * step_3_run_analyse_EQ_low_fixed_point.m : bifurcation of another equilibrium
    * step_4_run_analyse_polynomial.m : bifurcation for sensibility analysis 
  
* Bifurcation analise:
  * Equilibrium_Point.m
  * Equilibrium_Point_cont.m
  
* print_figure:
  function for print or check the result of the bifurcation.
