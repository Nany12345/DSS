# README

Five folders: Code, Data, DataSel, Result and Figure. The descriptions of these folders are shown as follows:

- Code: Store all codes
- Data: Store all raw datas: `data_set_ProblemType_M.mat`, where each `.mat` file is a $10,000\times M\times 30$ matrix
- DataSel: Store all selected datas:
    - All datas selected by `GI`, `GR` and `I` methods:
        - All datas selected by `GI`: `data_set_GI_ProblemType_M.mat`, where each `.mat` file is a $100\times M\times 30$ matrix
        - All datas selected by `GR`: `data_set_GR_ProblemType_M.mat`, where each `.mat` file is a $100\times M\times 30$ matrix
        - All datas selected by `I`: `data_set_I_ProblemType_M_RunIndex.mat`, where each `.mat` file is a $100\times M\times 30$ matrix
    - All datas selected by `I` methods with different distances: `data_set_I-Distance_ProblemType_M_RunIndex.mat`
- Result: Store the Results of all selected datas:
    - Uniformity level results:
        - Results of datas selected by `GI`:  `UL_GI_ProblemType_M.mat`, where each `.mat` file is a $1\times 30$ matrix
        - Results of datas selected by `GR`:  `UL_GR_ProblemType_M.mat`, where each `.mat` file is a $1\times 30$ matrix
        - Results of datas selected by `I`: `UL_I_ProblemType_M.mat`, where each `.mat` file is a $10\times 30$ matrix, and $i_{th}$ row of the matrix refers to the results of $i_{th}$ run
    - Hypervolume and IGD results:
        - Hypervolume results: `HV_I_Distance_ProblemType_M.mat`, where each `.mat` file is a $10\times 30$ matrix, and $i_{th}$ row of the matrix refers to the results of $i_{th}$ run
        - IGD results: `IGD_I_Distance_ProblemType_M.mat`, where each `.mat` file is a $10\times 30$ matrix, and $i_{th}$ row of the matrix refers to the results of $i_{th}$ run
- Figure: Store all Figures
    - Figure3: Store all figures of Fig. 3 in the paper
    - Figure4: Store all figures of Fig. 4 in the paper

The process of codes

1. Run `genData.m` to get raw datas
2. Run `generateResults.m` to select solutions by `GI`, `GR` and `I` methods
3. Run `evaluateUL.m` to calculate the uniformity level of the selected solutions by `GI`, `GR` and `I` methods
4. Run `Plot_UL.m` to plot figures about uniformity level for `GI`, `GR` and `I` methods
5. Run `genDistResults.m` to select solutions by `I` method with different distances
6. Run `evaluateHI.m` to calculate the Hypervolume and IGD of the selected solutions by `I` method with different distances
7. Run `Plot_HI.m` to plot figures about Hypervolume and IGD for `I` method with different distances