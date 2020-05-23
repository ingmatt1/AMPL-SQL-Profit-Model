# AMPL-Profit-Model

Using a gurobi solver in AMPL, an Integer Program was designed to maximize profit. Data for the model was extracted from Access using SQL in the AMPL .dat file. The .mod file builds the model’s variables, constraints, and profit function. The .run file runs the model against the .dat file and outputs the optimal product production plan to maximize profit. It also that optimal profit, the reduced cost of variables, the shadow prices for the constraints, and the binding constraints. 
The program accounts for sales and costs for factors such as wages and raw materials. Additional constraints such as warehouse capacity, or maximum machine operating time were also included. 

Information for some of the constraints and profit function are as follows:
* The budget for raw materials is $10,000,000.
* Not meeting the demand for any type of shoe means loss of new potential customers, and hence has been evaluated at a cost of $10/pair. 
* Machines will work up to 12 hours a day, 28 days a month. 
* Workers are paid on an hourly basis at the rate $25/hour. 
* Each machine has to be operated by one worker.

The “WARP2011” database contains all the product, raw material, machine, store, and warehouse information which was extracted using AMPL and used to create the profit model. 
