#Matthew_Ing_ingmatt1_1005057260
#Scott_Oxholm_oxholmsc_1005106788

reset;

set Product_Num;
set Warehouse_Num;
set Machine_Num;
set RM_Num;

#parameters
param Sales_Price{i in Product_Num}; #from Product_Master
param Avg_Demand{i in Product_Num}; #from February_Demand

param Quantity{i in Product_Num,j in RM_Num}default 0;
param RM_Cost{j in RM_Num};
param S_Quantity{j in RM_Num};

param Avg_Machine_Duration{i in Product_Num, k in Machine_Num} default 0; #from Machine_Assign
param Operating_TimeCost{k in Machine_Num}; #from Machine_Num

param Location_Cost{l in Warehouse_Num};
param Location_Capacity{l in Warehouse_Num};

#decision variables
var L{l in Warehouse_Num} binary;
var x{i in Product_Num};

#profit objective function to be maximized 
maximize profit: 
 sum{i in Product_Num} x[i]*Sales_Price[i]
- sum{i in Product_Num, j in RM_Num} x[i]*Quantity[i,j]*RM_Cost[j]
- sum{i in Product_Num,k in Machine_Num} x[i]*Avg_Machine_Duration[i,k]*Operating_TimeCost[k]*(1/60) 
- (sum{i in Product_Num,k in Machine_Num} Avg_Machine_Duration[i,k])*(25/3600)
- sum{l in Warehouse_Num} Location_Cost[l]*L[l]
- sum{i in Product_Num}(Avg_Demand[i]-x[i])*10;

#the number of shoes produced must not exceed the total warehouse capacity used
subject to locationCapacity: sum{i in Product_Num} x[i] <= sum{l in Warehouse_Num} Location_Capacity[l]*L[l];


#raw material costs must not exceed the budget of 10000000
subject to rawMaterialLimit:sum{i in Product_Num, j in RM_Num} x[i]*Quantity[i,j]*RM_Cost[j]<=10000000;

#the number of total machine time used must not exceed 1209600 seconds  
#12 hours a day times 28 days times 3600 (convert hours to seconds)
subject to machineOperator{k in Machine_Num}:sum{i in Product_Num}Avg_Machine_Duration[i,k]*x[i] <= 1209600; 

#the amount of raw materials used must not exceed our available supply of the material
subject to rawMaterialSupply{j in RM_Num}: sum{i in Product_Num}x[i]*Quantity[i,j]<=S_Quantity[j];

#the number of a particular shoe produced must not exceed its demand 
subject to demandMakeDifference{i in Product_Num}: x[i] <= Avg_Demand[i];

#the number of shoes produced cannot be less than 0
subject to nonneg {i in Product_Num}: x[i] >= 0;






