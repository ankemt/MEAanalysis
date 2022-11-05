# treatment ratio file contains expected parameters

    Code
      treatment_ratio(exposurepath = exposure_source, baselinepath = baseline_source,
        designpath = design_source)
    Output
      # A tibble: 2,304 x 8
         Well  Group Metric_type     Parameter         Basel~1 Expos~2 Treat~3 Treat~4
         <chr> <chr> <chr>           <chr>               <dbl>   <dbl>   <dbl>   <dbl>
       1 A1    30    Activity        Number of Spikes  2.82e+4 6.90e+4   2.45    245. 
       2 A1    30    Activity        Mean Firing Rate~ 1.89e+0 7.91e+0   4.18    418. 
       3 A1    30    Activity        ISI Coefficient ~ 5.94e+0 4.19e+0   0.705    70.5
       4 A1    30    Activity        Number of Active~ 1.5 e+1 1.5 e+1   1       100  
       5 A1    30    Activity        Weighted Mean Fi~ 2.34e+0 7.67e+0   3.28    328. 
       6 A1    30    Electrode Burst Number of Bursts  7.51e+2 2.81e+3   3.74    374. 
       7 A1    30    Electrode Burst Number of Bursti~ 1.6 e+1 8.1 e+1   5.06    506. 
       8 A1    30    Electrode Burst Burst Duration -~ 1.75e-1 1.57e-1   0.896    89.6
       9 A1    30    Electrode Burst Burst Duration -~ 8.27e-2 3.91e-2   0.473    47.3
      10 A1    30    Electrode Burst Number of Spikes~ 2.21e+1 2.65e+1   1.20    120. 
      # ... with 2,294 more rows, and abbreviated variable names 1: Baseline_value,
      #   2: Exposure_value, 3: Treatment_ratio, 4: Treatment_ratio_percentage

