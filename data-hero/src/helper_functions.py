

# -- -----------------------------
import os
import sys

import glob

from collections import namedtuple

from scipy import stats

import numpy as np
import pandas as pd

import matplotlib.pyplot as plt

import json

from IPython.display import display, Markdown
# -- -----------------------------


# -- -----------------------------
# This will allow the module to be importable from other 
# scripts and callable from arbitrary places in the system.
MODULE_DIR         = os.path.dirname(__file__)

PROJ_ROOT          = os.path.join(MODULE_DIR, os.pardir)

DATA_DIR           = os.path.join(PROJ_ROOT, 'data')

DATA_RAW_DIR       = os.path.join(DATA_DIR, 'raw')
# -- -----------------------------


# -- -----------------------------
def read_csv(
    p_dir, 
    p_file_name, 
    p_sep              = ',',
    p_header           = 'infer',
    p_names            = None,
    p_index_col        = None,
    p_compression      = None, 
    p_dtype            = None,
    p_parse_dates      = False,
    p_skiprows         = None,
    p_chunksize        = None,
    p_error_bad_lines  = True
):

    v_file = os.path.join(p_dir, p_file_name)

    df = pd.read_csv(
        v_file,
        sep              = p_sep,
        header           = p_header,
        names            = p_names,
        index_col        = p_index_col,
        compression      = p_compression,
        dtype            = p_dtype,
        parse_dates      = p_parse_dates,
        skiprows         = p_skiprows,
        chunksize        = p_chunksize,
        error_bad_lines  = p_error_bad_lines        
    )

    return df
# -- -----------------------------




# -- -----------------------------
def ecdf(data):
    """Compute ECDF for a one-dimensional array of measurements."""

    # Number of data points: n
    n = len(data)


    # -- -------------------------
    # x-data for the ECDF: x
    #
    # The x-values are the sorted data.    
    x = np.sort(data)


    # -- -------------------------
    # y-data for the ECDF: y
    #
    # The y data of the ECDF go from 1/n to 1 in equally spaced increments.
    # You can construct this using np.arange(). 
    # Remember, however, that the end value in np.arange() is not inclusive. 
    # Therefore, np.arange() will need to go from 1 to n+1. 
    # Be sure to divide this by n.    
    y = np.arange(1, n+1) / n

    return x, y
# -- -----------------------------



# -- -----------------------------
def generate_normal_dist(p_mean, p_std, p_size):
    """
    Generate (approx) normal distribution. 
    """

    samples = np.random.normal(
        loc = p_mean,
        scale = p_std,  
        size = p_size  
    )

    mu = np.mean(samples)
    sigma = np.std(samples)

    stats = {        
        'sample_count':float(len(samples)),
        'mean': mu,   
        'std': sigma,    
        # -- ---------------------
        'mean-3std':mu-(sigma*3),     
        'mean-2std':mu-(sigma*2),
        'mean-1std':mu-sigma,    
        'mean+1std':mu+sigma,
        'mean+2std':mu+(sigma*2),
        'mean+3std':mu+(sigma*3),
        # -- ---------------------
        'pctile-2.5': np.percentile(samples,2.5),
        'pctile-25': np.percentile(samples,25.0),
        'median': np.percentile(samples,50.0),
        'pctile-75': np.percentile(samples,75.0),
        'pctile-97.5': np.percentile(samples,97.5)
    }

    stats['1-std-range-pct'] = len(samples[np.logical_and(samples >= stats['mean-1std'], samples <= stats['mean+1std'])])/stats['sample_count']
    stats['2-std-range-pct'] = len(samples[np.logical_and(samples >= stats['mean-2std'], samples <= stats['mean+2std'])])/stats['sample_count']
    stats['3-std-range-pct'] = len(samples[np.logical_and(samples >= stats['mean-3std'], samples <= stats['mean+3std'])])/stats['sample_count']

    # -- -----------------------------
    Result = namedtuple('Result', 'samples stats')

    result = Result(
        samples,
        stats
    )

    return result


# -- -----------------------------
def generate_normal_dist_cdf(p_mean, p_std, p_size):
    """
    Generate (approx) normal distribution and plot cdf. 
    """

    # -- -----------------------------
    samples, stats = generate_normal_dist(
        p_mean = p_mean, 
        p_std = p_std, 
        p_size = p_size
    )

    x, y = ecdf(samples)

    # -- -----------------------------
    # Plot the CDF
    _ = plt.plot(
        x, 
        y, 
        '.')

    plt.margins(0.02)

    _ = plt.xlabel('Value')
    _ = plt.ylabel('Percentile')


    # -- -----------------------------
    # Overlay percentiles as red x's
    #
    # Note that to ensure the Y-axis of the plot remains between 0 and 1,  
    # rescale the percentiles array accordingly.
    pctile_vals = [stats['pctile-2.5'],stats['pctile-25'],stats['median'],stats['pctile-75'],stats['pctile-97.5']]
    pctiles = np.array([2.5, 25.0, 50.0, 75.0, 97.5])

    _ = plt.plot(
        pctile_vals, 
        pctiles/100,  
        marker    = 'D', 
        color     = 'red',
        linestyle = 'none'
    )

    # -- -----------------------------
    # Make vertical line for the std+-3
    #
    _ = plt.axvline(
        x      = stats['mean-3std'],
        color  = 'cyan',
        label  = '+- 3 std',
        dashes = [5, 10]  # 5 points on, 10 off
    )

    _ = plt.axvline(
        x      = stats['mean+3std'],
        color  = 'cyan',    
        dashes = [5, 10]  # 5 points on, 10 off
    )

    # -- -----------------------------
    # Make vertical line for the std+-2
    #
    _ = plt.axvline(
        x      = stats['mean-2std'],
        color  = 'grey',
        label  = '+- 2 std',
        dashes = [5, 10]  # 5 points on, 10 off
    )

    _ = plt.axvline(
        x      = stats['mean+2std'],
        color  = 'grey',    
        dashes = [5, 10]  # 5 points on, 10 off
    )

    # -- -----------------------------
    # Make vertical line for the std+-1
    #
    _ = plt.axvline(
        x      = stats['mean-1std'],
        color  = 'purple',
        label  = '+- 1 std',
        dashes = [5, 10]  # 5 points on, 10 off
    )

    _ = plt.axvline(
        x      = stats['mean+1std'],
        color  = 'purple',    
        dashes = [5, 10]  # 5 points on, 10 off
    )

    # -- -----------------------------
    _ = plt.legend(loc='lower right')
    _ = plt.title('Normal CDF (µ = '+str(p_mean)+' and σ = '+str(p_std)+')\n Percentiles in red: 2.5, 25, 50, 75, 97.5')


    plt.show()




