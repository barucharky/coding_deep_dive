# B"H 

--------
## Setup Instructions

---

### Setup conda:

```sh
conda create --name env-py-learn python=3.6
conda activate env-py-learn
```


---

### Install the requirements.



```sh

conda deactivate
pip install --upgrade pip
pip install notebook --upgrade
pip install jupyterlab --upgrade
jupyter labextension install @jupyterlab/toc

# -----------------------------------------------

conda activate env-py-learn
pip install --upgrade pip
pip install notebook --upgrade
pip install jupyterlab --upgrade
jupyter labextension install @jupyterlab/toc

```

---

```sh
pip install -r requirements.txt
```

---


### Setup the IPython kernel:
```sh
python -m ipykernel install --user --name env-py-learn --display-name "Python (env-py-learn)"
```


