# Org_Hidroweb.m: HydroWeb data organization
**Author: Guilherme Kruger Bartels**

**Date: 30/07/2021**


This repository includes the code for the `Org_Hidroweb.m` Matlab function, along with an example (`example.m`) and the data needed to run it. 
This function performs the conversion of daily data obtained from [HidroWeb](https://www.snirh.gov.br/hidroweb/apresentacao), to a more simplified format, arranged in four columns (Year, Month, Day and Variable), facilitating the manipulation and analysis of information. 
In addition, all existing flaws in the series stories are identified and assigned NaN (Not a Number).


### Prerequisites

This software requires Matlab and has been previously tested on versions R2012b, R2015a and R2019b.

### Dowloading

Git users can clone directly from this repository.

### Example

Interested parties can access the `example.m`, which demonstrates how the data obtained from HidroWeb (.csv) can be imported into Matlab and then organized with `Org_Hidroweb.m`.


### Contributions

Community contributions to this package are welcome!

To report bugs, please submit an issue [here](https://github.com/guilhermebartels/Org_Hidroweb/issues)

Contact: guilhermebartels@gmail.com
