# Setting up a Python environment 

## Setup and test your python environment for the CoastWatch Satellite Course 

1. Make sure you have __python 3__ and __conda__ installed on your machine
2. Download this repository. 
    * Use the green __Code__ dropdown to select __Download Zip__ and unzip to a location on your computer
    * Or [use this zip file link](https://github.com/coastwatch-training/CoastWatch-Tutorials/archive/refs/heads/main.zip)
3. Use a terminal window to navigate to the unzipped folder 

The following commands:  
* Update conda
* Create a new conda environment named 'coastwatch' and load the required modules to it  
* Activate the environment  
* Runs a script that checks for any missing modules  
* Launches jupyter-lab for displaying the jupyter notebook tutorials  

```
conda update conda
conda env create -f environment.yml
conda activate coastwatch
python check_modules.py
jupyter-lab
```
