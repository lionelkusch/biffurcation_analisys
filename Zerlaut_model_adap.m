%  Copyright 2021 Aix-Marseille Université
% "Licensed to the Apache Software Foundation (ASF) under one or more contributor license agreements; and to You under the Apache License, Version 2.0. "
function [dev_E,dev_I,dev_c_ee,dev_c_ei,dev_c_ii,dev_W]=Zerlaut_model_adap(E,I,C_ee,C_ei,C_ii,W_e,g_L,E_L_e,E_L_i,C_m,E_e,E_i,Q_e,Q_i,tau_e,tau_i,tau_w_e,b_e,N_tot,p_connect,g,T,external_input_E_E,external_input_E_I,P_e_0,P_e_1,P_e_2,P_e_3,P_e_4,P_e_5,P_e_6,P_e_7,P_e_8,P_e_9,P_i_0,P_i_1,P_i_2,P_i_3,P_i_4,P_i_5,P_i_6,P_i_7,P_i_8,P_i_9)
    df = 1e-7;
    N_e = N_tot*(1-g);
    N_i = N_tot*g;
    W_i = 0.0;
    W_e = W_e*1e3; % change unit for uniform the dimension for the bifurcation
    external_input_I_E = external_input_E_E;
    external_input_I_I = external_input_E_I;
    function  [mu_V, sigma_V, T_V]=get_fluct_regime_vars(Fe, Fi, W, E_L)
        fe = (Fe+1.e-6).*(1.-g).*p_connect.*N_tot;
        fi = (Fi+1.e-6).*g.*p_connect.*N_tot;
        mu_Ge = Q_e.*tau_e.*fe;
        mu_Gi = Q_i.*tau_i.*fi;  
        mu_G = g_L+mu_Ge+mu_Gi;  
        T_m = C_m./mu_G;
        mu_V = (mu_Ge.*E_e+mu_Gi.*E_i+g_L.*E_L-W)./mu_G ;
        U_e = Q_e./mu_G.*(E_e-mu_V);
        U_i = Q_i./mu_G.*(E_i-mu_V);
        sigma_V = sqrt(fe.*(U_e.*tau_e)^2/(2.*(tau_e+T_m))+fi.*(U_i.*tau_i)^2./(2.*(tau_i+T_m)));
        T_V_numerator = (fe.*(U_e.*tau_e)^2 + fi.*(U_i.*tau_i)^2);
        T_V_denominator = (fe.*(U_e.*tau_e)^2./(tau_e+T_m) + fi.*(U_i.*tau_i)^2./(tau_i+T_m));
        T_V = T_V_numerator./T_V_denominator;
    end

    function [V_thre]=threshold_func(muV, sigmaV, TvN, P0, P1, P2, P3, P4, P5, P6, P7, P8, P9)
        muV0 =  -60.0;
        DmuV0 = 10.0;
        sV0=  4.0;
        DsV0 = 6.0;
        TvN0=  0.5;
        DTvN0 = 1.;
        V = (muV-muV0)./DmuV0;
        S = (sigmaV-sV0)./DsV0;
        T_eq = (TvN-TvN0)./DTvN0;
        V_thre= P0 + P1.*V + P2.*S + P3.*T_eq + P4.*(V^2) + P5.*(S^2) + P6.*(T_eq^2) + P7.*V.*S + P8.*V.*T_eq + P9.*S.*T_eq;
    end
    function [f_out]=estimate_firing_rate(muV, sigmaV, Tv, Vthre)
        if imag(sigmaV) ~= 0.0
            fprintf('bad')
%             error('bad')
        end
        f_out = erfc((Vthre-muV) ./ (sqrt(2).*sigmaV)) ./ (2.*Tv);
    end     
    function f_out=TF_e( fe, fi, W)
            [mu_V, sigma_V, T_V ]= get_fluct_regime_vars(fe, fi, W, E_L_e);
            V_thre = threshold_func(mu_V, sigma_V, T_V.*g_L./C_m,...
                P_e_0, P_e_1, P_e_2, P_e_3, P_e_4, P_e_5, P_e_6, P_e_7, P_e_8, P_e_9);
            V_thre =V_thre .* 1e3;
            f_out = estimate_firing_rate(mu_V, sigma_V, T_V, V_thre);
    end
    function f_out=TF_i( fe, fi, W)
            [mu_V, sigma_V, T_V ]= get_fluct_regime_vars(fe, fi, W, E_L_i);
            V_thre = threshold_func(mu_V, sigma_V, T_V.*g_L./C_m,...
                P_i_0, P_i_1, P_i_2, P_i_3, P_i_4, P_i_5, P_i_6, P_i_7, P_i_8, P_i_9);
            V_thre =V_thre .* 1e3;  
            f_out = estimate_firing_rate(mu_V, sigma_V, T_V, V_thre);
    end
    function f_out=diff_fe(TF, fe, fi, W)
       f_out= (TF(fe+df, fi, W)-TF(fe-df, fi, W))./(2*df*1e3);
    end 
    function f_out=diff_fi(TF, fe, fi, W)
        f_out=(TF(fe, fi+df, W)-TF(fe, fi-df, W))./(2*df*1e3);
    end
    function f_out= diff2_fe_fe(TF, fe, fi, W)
        f_out= (TF(fe+df, fi, W)-2.*TF(fe,fi,W)+TF(fe-df, fi, W))./((df*1e3)^2);
    end
    function f_out=diff2_fi_fe(TF, fe, fi, W)
        f_out=(diff_fi(TF, fe+df, fi, W)-diff_fi(TF, fe-df, fi, W))/(2*df*1e3);
    end
    function f_out=diff2_fe_fi(TF, fe, fi, W)
        f_out= (diff_fe(TF, fe, fi+df, W)-diff_fe(TF,fe, fi-df, W))./(2*df*1e3);
    end
    function f_out=diff2_fi_fi(TF, fe, fi, W)
        f_out= (TF(fe, fi+df, W)-2*TF(fe, fi, W)+TF(fe, fi-df, W))/((df*1e3)^2);
    end
    dev_E = (...
                .5.*C_ee.*diff2_fe_fe(@TF_e, E+external_input_E_E, I+external_input_E_I, W_e)+...
                .5.*C_ei.*diff2_fe_fi(@TF_e, E+external_input_E_E, I+external_input_E_I, W_e)+...
                .5.*C_ei.*diff2_fi_fe(@TF_e, E+external_input_E_E, I+external_input_E_I, W_e)+...
                .5.*C_ii.*diff2_fi_fi(@TF_e, E+external_input_E_E, I+external_input_E_I, W_e)+...
                TF_e(E+external_input_E_E, I+external_input_E_I, W_e)-E)./T;
    dev_I  = (...
                .5.*C_ee.*diff2_fe_fe(@TF_i, E+external_input_I_E, I+external_input_I_I, W_i)+...
                .5.*C_ei.*diff2_fe_fi(@TF_i, E+external_input_I_E, I+external_input_I_I, W_i)+...
                .5.*C_ei.*diff2_fi_fe(@TF_i, E+external_input_I_E, I+external_input_I_I, W_i)+...
                .5.*C_ii.*diff2_fi_fi(@TF_i, E+external_input_I_E, I+external_input_I_I, W_i)+...
                TF_i(E+external_input_I_E, I+external_input_I_I, W_i)-I)./T;
    
    dev_c_ee = (...
                TF_e(E+external_input_E_E, I+external_input_E_I, W_e)./N_e.*...
                (1./T-TF_e(E+external_input_E_E, I+external_input_E_I, W_e))+...
                (TF_e(E+external_input_E_E, I+external_input_E_I, W_e)-E)^2+...
                2.*C_ee.*diff_fe(@TF_e, E+external_input_E_E, I+external_input_E_I, W_e)+...
                2.*C_ei.*diff_fi(@TF_i, E+external_input_I_E, I+external_input_I_I, W_i)+...
                -2.*C_ee)./T;
            
     dev_c_ei = ((TF_e(E+external_input_E_E, I+external_input_E_I, W_e)-E).*...
                (TF_i(E+external_input_I_E, I+external_input_I_I, W_i)-I)+...
                C_ee.*diff_fe(@TF_e, E+external_input_E_E, I+external_input_E_I, W_e)+...
                C_ei.*diff_fe(@TF_i, E+external_input_I_E, I+external_input_I_I, W_i)+...
                C_ei.*diff_fi(@TF_e, E+external_input_E_E, I+external_input_E_I, W_e)+...
                C_ii.*diff_fi(@TF_i, E+external_input_I_E, I+external_input_I_I, W_i)+...
                -2.*C_ei)./T;

     dev_c_ii = (...
                TF_i(E+external_input_I_E, I+external_input_I_I, W_i)./N_i.*...
                (1./T-TF_i(E+external_input_I_E, I+external_input_I_I, W_i))+...
                (TF_i(E+external_input_I_E, I+external_input_I_I, W_i)-I)^2+...
                2.*C_ii.*diff_fi(@TF_i, E+external_input_I_E, I+external_input_I_I, W_i)+...
                2.*C_ei.*diff_fe(@TF_e, E+external_input_E_E, I+external_input_E_I, W_e)+...
                -2.*C_ii)./T; 
     dev_W = -W_e/tau_w_e+b_e*(E+external_input_E_E);
     dev_W = dev_W*1e-3;

end
     