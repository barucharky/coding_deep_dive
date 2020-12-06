# B"H 




## Setup Instructions

#### Step 1 - Setup conda environment:

```sh
conda create --name springboard python=3.8
conda activate springboard
```


#### Step 2 - Change the VSCode Python interpreter
- Might need to close/reopen VSCode first.



#### Step 3 - NOTE only needed if cleaning up jupyter extension stuff etc.

```sh
conda deactivate
pip3 install --upgrade pip
pip3 install notebook --upgrade

pip uninstall jupyterlab
rm -r ~/.jupyter
pip3 install jupyterlab --upgrade

jupyter serverextension disable  jupyterlab_discovery
jupyter labextension disable jupyterlab_discovery
pip uninstall jupyter_nbextensions_configurator

jupyter labextension install @jupyterlab/toc

# -- -----------------------------

conda activate springboard
pip3 install --upgrade pip
pip3 install notebook --upgrade
pip3 install jupyterlab --upgrade

jupyter serverextension disable  jupyterlab_discovery
jupyter labextension disable jupyterlab_discovery
pip uninstall jupyter_nbextensions_configurator

jupyter labextension install @jupyterlab/toc

```


---

#### Step 4 - Install the requirements.

**Not sure if this next command is needed anymore:
- `sudo apt-get install python-dateutil`


```sh
conda deactivate
pip3 install --upgrade pip
pip3 install notebook --upgrade
pip3 install jupyterlab --upgrade
jupyter labextension install @jupyterlab/toc

# -- -----------------------------

conda activate springboard
pip3 install --upgrade pip
pip3 install notebook --upgrade
pip3 install jupyterlab --upgrade
jupyter labextension install @jupyterlab/toc

pip3 install -r requirements.txt
```


#### Step 5 - Setup the IPython kernel:
```sh
python -m ipykernel install --user --name springboard --display-name "Python (springboard)"
```




#### Step 6 - Download the Kaggle competition files:

**First (if haven't done yet):**
- Setup at Kaggke API credentials 
- https://github.com/Kaggle/kaggle-api#api-credentials


**Then:**

```sh
kaggle competitions download -c house-prices-advanced-regression-techniques -p ~/.kaggle/competitions/house-prices-advanced-regression-techniques/
```
- This will place the files in the following dir: `~/.kaggle/competitions/house-prices-advanced-regression-techniques/` 
---


---

## Walk through the notebooks:
```sh
cd notebooks
jupyter lab &
```   
