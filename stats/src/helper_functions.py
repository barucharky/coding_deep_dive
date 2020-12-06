# B''H #


# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
import os
import sys

import glob

from collections import namedtuple

from scipy import stats

import numpy as np
import pandas as pd

import matplotlib.pyplot as plt

import tweepy

import json

from IPython.display import display, Markdown
# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~






# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# This will allow the module to be import-able from other scripts and callable from arbitrary places in the system.
MODULE_DIR         = os.path.dirname(__file__)

PROJ_ROOT          = os.path.join(MODULE_DIR, os.pardir)

DATA_DIR           = os.path.join('/home/intsights/repos/x-large-files', 'springboard-large-files')

# -- -    -    -    -    -    -    -    -    -    -    -    -    -    --    

DATA_RAW_DIR       = os.path.join(DATA_DIR, 'raw')

DATA_CLEAN_DIR     = os.path.join(DATA_DIR, 'clean')

DATA_TWEETS_DIR    = os.path.join(DATA_DIR, 'tweets')

DATA_INTERIM_DIR   = os.path.join(DATA_DIR, 'etl-interim')

# -- -    -    -    -    -    -    -    -    -    -    -    -    -    --    

NOTEBOOKS_DIR      = os.path.join(PROJ_ROOT, 'notebooks')

NOTEBOOK_FILES_DIR = os.path.join(NOTEBOOKS_DIR, 'files')
# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~










# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ML_01_DIR = os.path.join(NOTEBOOK_FILES_DIR, 'ml-01-bias-and-regression')
ML_02_DIR = os.path.join(NOTEBOOK_FILES_DIR, 'ml-02-regression')
ML_03_DIR = os.path.join(NOTEBOOK_FILES_DIR, 'ml-03-different-types-of-models')
ML_04_DIR = os.path.join(NOTEBOOK_FILES_DIR, 'ml-04-supervised-learning-classification')
ML_05_DIR = os.path.join(NOTEBOOK_FILES_DIR, 'ml-05-supervised-learning-regression')
ML_06_DIR = os.path.join(NOTEBOOK_FILES_DIR, 'ml-06-fine-tuning-your-model')
ML_07_DIR = os.path.join(NOTEBOOK_FILES_DIR, 'ml-07-preprocessing-and-pipelines')

ML_10b_DIR = os.path.join(NOTEBOOK_FILES_DIR, 'ml-10-pca')
# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
BAYES_BOOK_01_DIR = os.path.join(NOTEBOOK_FILES_DIR, 'bayes-book-01-theorem')
BAYES_BOOK_02_DIR = os.path.join(NOTEBOOK_FILES_DIR, 'bayes-book-02-health-test')
BAYES_BOOK_03_DIR = os.path.join(NOTEBOOK_FILES_DIR, 'bayes-book-03-win-rate')
BAYES_BOOK_04_DIR = os.path.join(NOTEBOOK_FILES_DIR, 'bayes-book-04-naive-bayes')
BAYES_BOOK_05_DIR = os.path.join(NOTEBOOK_FILES_DIR, 'bayes-book-05-tank-problem')
# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NS_01_DIR = os.path.join(NOTEBOOK_FILES_DIR, 'ns-01-book-notes')
# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
FOLTZ_09_DIR = os.path.join(NOTEBOOK_FILES_DIR, 'foltz-09-hypothesis-testing')
# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
SEC_00_DIR = os.path.join(NOTEBOOK_FILES_DIR, '00-data-science-intro')
SEC_01_DIR = os.path.join(NOTEBOOK_FILES_DIR, '01-python-for-ds-intro')
SEC_02_DIR = os.path.join(NOTEBOOK_FILES_DIR, '02-ds-toolbox')
SEC_03_DIR = os.path.join(NOTEBOOK_FILES_DIR, '03-data-types')
SEC_04_DIR = os.path.join(NOTEBOOK_FILES_DIR, '04-data-visualization-intro')
SEC_05_DIR = os.path.join(NOTEBOOK_FILES_DIR, '05-plotting-2d-arrays')
SEC_06_DIR = os.path.join(NOTEBOOK_FILES_DIR, '06-seaborn')
SEC_07_DIR = os.path.join(NOTEBOOK_FILES_DIR, '07-time-series')
SEC_08_DIR = os.path.join(NOTEBOOK_FILES_DIR, '08-histogram-equalization-in-images')
SEC_09_DIR = os.path.join(NOTEBOOK_FILES_DIR, '09-df-ingestion-and-inspection')
SEC_10_DIR = os.path.join(NOTEBOOK_FILES_DIR, '10-eda-exploratory-data-analysis')
SEC_11_DIR = os.path.join(NOTEBOOK_FILES_DIR, '11-pandas-time-series')
SEC_12_DIR = os.path.join(NOTEBOOK_FILES_DIR, '12-case-study-austin-sunlight')
SEC_13_DIR = os.path.join(NOTEBOOK_FILES_DIR, '13-df-etl')
SEC_14_DIR = os.path.join(NOTEBOOK_FILES_DIR, '14-advanced-indexing')
SEC_15_DIR = os.path.join(NOTEBOOK_FILES_DIR, '15-reshaping-data')
SEC_16_DIR = os.path.join(NOTEBOOK_FILES_DIR, '16-grouping-data')
SEC_17_DIR = os.path.join(NOTEBOOK_FILES_DIR, '17-summer-olympics')
SEC_18_DIR = os.path.join(NOTEBOOK_FILES_DIR, '18-preparing-data')
SEC_19_DIR = os.path.join(NOTEBOOK_FILES_DIR, '19-concatenating-data')
SEC_20_DIR = os.path.join(NOTEBOOK_FILES_DIR, '20-merging-data')
SEC_21_DIR = os.path.join(NOTEBOOK_FILES_DIR, '21-cleaning-data')
SEC_22_DIR = os.path.join(NOTEBOOK_FILES_DIR, '22-life-expectancy-case-study')
SEC_23_DIR = os.path.join(NOTEBOOK_FILES_DIR, '23-python-for-ds-part-2')
SEC_24_DIR = os.path.join(NOTEBOOK_FILES_DIR, '24-world-bank-case-study')
SEC_25_DIR = os.path.join(NOTEBOOK_FILES_DIR, '25-importing-data-part-1')
SEC_26_DIR = os.path.join(NOTEBOOK_FILES_DIR, '26-importing-data-part-2')
SEC_27_DIR = os.path.join(NOTEBOOK_FILES_DIR, '27-statistical-thinking-part-1')
SEC_28_DIR = os.path.join(NOTEBOOK_FILES_DIR, '28-statistical-thinking-part-2')
SEC_29_DIR = os.path.join(NOTEBOOK_FILES_DIR, '29-finches-case-study')
# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def print_dir_constants():
    print('MODULE_DIR               :', MODULE_DIR)    
    print('PROJ_ROOT                :', PROJ_ROOT)    
    print('DATA_DIR                 :', DATA_DIR)
    print('DATA_RAW_DIR             :', DATA_RAW_DIR)
# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def display_images(p_dir, p_file_pattern="*.png"):

    file_list = glob.glob(os.path.join(p_dir, p_file_pattern))


    for file_path in sorted(file_list):        
    
        file_relative_path = file_path.replace('/home/intsights/repos/repos-edu/repos-ds-math-python/ds-refinery/notebooks', '..')
    
        content = '### '+file_relative_path+'\n'+'<img src="'+file_relative_path+'">\n\n---'               

        display(Markdown(content))
# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class MyStreamListener(tweepy.StreamListener):    
    """
    This Tweet listener 
        - creates a file called 'tweets.txt' 
        - collects streaming tweets as .jsons and writes them to the file 'tweets.txt' 
        - once 1000 tweets have been streamed, the listener closes the file and stops listening.
    """
    def __init__(self, api=None):
        super(MyStreamListener, self).__init__()
        self.num_tweets = 0
        self.file = open(
            os.path.join(DATA_TWEETS_DIR, "tweets.txt"),
            "w"
            )

    def on_status(self, status):
        tweet = status._json
        self.file.write(json.dumps(tweet) + '\n')
        self.num_tweets += 1
        if self.num_tweets < 1000:
            return True
        else:
            return False
        self.file.close()

    def on_error(self, status):
        print(status)
# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def ecdf(data):
    """Compute ECDF for a one-dimensional array of measurements."""

    # Number of data points: n
    n = len(data)


    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #                    x-data for the ECDF: x
    #
    # The x-values are the sorted data.    
    x = np.sort(data)


    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #                    y-data for the ECDF: y
    #
    # The y data of the ECDF go from 1/n to 1 in equally spaced increments.
    # You can construct this using np.arange(). 
    # Remember, however, that the end value in np.arange() is not inclusive. 
    # Therefore, np.arange() will need to go from 1 to n+1. 
    # Be sure to divide this by n.    
    y = np.arange(1, n+1) / n

    return x, y
# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    


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










# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_x_y_for_norm_plot(p_data):
    """Generates data for a normal probability plot.
   
    Returns:
        x: random values from the standard normal distribution.
        y: the sorted values from the data         
    """

    # -- -------------------------------------------
    # From a standard normal distribution (µ = 0 and σ = 1)
    #     - generate a random sample with the same size as the data
    #     - sort it
    mu    = 0
    sigma = 1
    sample_size = len(p_data)

    x = np.random.normal(mu, sigma, sample_size)
    x.sort()
    # -- -------------------------------------------


    # -- -------------------------------------------
    # Sort the values in the data
    y = np.array(p_data)
    y.sort()
    # -- -------------------------------------------

    return x, y
# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_x_y_for_line(bounds, y_intercept, slope):
    """
    Get x and y for plotting a straight line.
    """    

    x = np.sort(bounds)

    y = y_intercept + (slope * x)

    return x, y
# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_srr_bins(p_data):
    """
    Get number of bins using the "square root rule"
    """
    
    n_data = len(p_data)
    
    n_bins = np.sqrt(n_data)
    
    return int(n_bins)
# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def pearson_r(x, y):
    """
    Compute Pearson correlation coefficient between two arrays.            
        - It is computed using the np.corrcoef() function. 
        - Like np.cov(), it takes two arrays as arguments and returns a 2D array. 
        - Entries [0,0] and [1,1] are necessarily equal to 1 (can you think about why?)
        - The value we are after is entry [0,1].
    """
    # Compute correlation matrix: corr_mat
    corr_mat = np.corrcoef(x, y)

    # Return entry [0,1]
    return corr_mat[0, 1]
# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def perform_bernoulli_trials(n, p):
    
    """
    You can think of a Bernoulli trial as a flip of a possibly biased coin.
        - Each coin flip has a probability p of landing heads (success) and probability 1−p of landing tails (failure).

    This function returns the number of successes out of n Bernoulli trials, each of which has probability p of success.
    """

    # Initialize number of successes: n_success
    n_success = 0

    # Perform trials
    for i in range(n):
        # Choose random number between zero and one: random_number
        random_number = np.random.random()

        # If less than p, it's a success  so add one to n_success
        if random_number < p:
            n_success += 1

    return n_success
# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def bootstrap_replicate_1d(data, func):
    """
    Generate bootstrap replicate of 1-dimensional data
    """
    bs_sample = np.random.choice(data, len(data))

    return func(bs_sample)
# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def draw_bootstrap_replicates(data, func, size=1):
    """Draw bootstrap replicates."""

    # Initialize array of replicates: bs_replicates
    bs_replicates = np.empty(size)

    # Generate replicates
    for i in range(size):
        bs_replicates[i] = bootstrap_replicate_1d(data, func)

    return bs_replicates
# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def draw_bootstrap_pairs_linreg(x, y, size=1):
    """Perform pairs bootstrap for linear regression."""

    # Set up array of indices to sample from: inds
    inds = np.arange(len(x))

    # Initialize replicates: bs_slope_reps, bs_intercept_reps
    bs_slope_reps     = np.empty(size)
    bs_intercept_reps = np.empty(size)

    # Generate replicates
    for i in range(size):
        bs_inds = np.random.choice(inds, size=len(inds))
        bs_x, bs_y = x[bs_inds], y[bs_inds]
        bs_slope_reps[i], bs_intercept_reps[i] = np.polyfit(bs_x, bs_y, 1)

    return bs_slope_reps, bs_intercept_reps
# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# -- Same as above func but now can pass in func to use for statistic
def draw_bootstrap_pairs(x, y, func, size=1):
    """Perform pairs bootstrap for single statistic."""

    # Set up array of indices to sample from: inds
    inds = np.arange(len(x))

    # Initialize replicates: bs_replicates
    bs_replicates = np.empty(size)

    # Generate replicates
    for i in range(size):
        bs_inds = np.random.choice(inds, len(inds))
        bs_x, bs_y = x[bs_inds], y[bs_inds]
        bs_replicates[i] = func(bs_x, bs_y)

    return bs_replicates
# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def permutation_sample(data1, data2):
    """Generate a permutation sample from two data sets."""

    # Concatenate the data sets: data
    data = np.concatenate((data1, data2))

    # Permute the concatenated array: permuted_data
    permuted_data = np.random.permutation(data)

    # Split the permuted array into two: perm_sample_1, perm_sample_2
    perm_sample_1 = permuted_data[:len(data1)]
    perm_sample_2 = permuted_data[len(data1):]

    return perm_sample_1, perm_sample_2
# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def draw_permutation_replicates(data_1, data_2, func, size=1):
    """Generate multiple permutation replicates."""

    # Initialize array of replicates: perm_replicates
    perm_replicates = np.empty(size)

    for i in range(size):
        # Generate permutation sample
        perm_sample_1, perm_sample_2 = permutation_sample(data_1, data_2)

        # Compute the test statistic
        perm_replicates[i] = func(perm_sample_1, perm_sample_2)

    return perm_replicates
# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def diff_of_means(data_1, data_2):
    """Difference in means of two arrays."""

    # The difference of means of data_1, data_2: diff
    diff = np.mean(data_1) - np.mean(data_2)

    return diff
# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def diff_frac(data_1, data_2):
    """Difference in rate of two arrays."""

    frac_1 = np.sum(data_1) / len(data_1)
    frac_2 = np.sum(data_2) / len(data_2)

    return frac_1 - frac_2
# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def bootstrap_two_sample_diff_in_proportions(p_group_1_count, p_group_1_sample_size, p_group_2_count, p_group_2_sample_size, p_size=1, p_alpha=.05):
    """
    Generate bootstrap replicates for difference in two proportions
    """


    # -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    original_group_1_proportion = p_group_1_count / p_group_1_sample_size 
    original_group_2_proportion = p_group_2_count / p_group_2_sample_size 
    
    original_proportion_diff = original_group_1_proportion - original_group_2_proportion
    # -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


    # -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~    
    # Create an array of zeros and ones with the same proportions as group_1

    arr_1 = np.array([0] * (p_group_1_sample_size - p_group_1_count) + [1] * p_group_1_count)

    np.random.shuffle(arr_1)
    # -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


    # -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~    
    # Create an array of zeros and ones with the same proportions as group_2

    arr_2 = np.array([0] * (p_group_2_sample_size - p_group_2_count) + [1] * p_group_2_count)

    np.random.shuffle(arr_2)
    # -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


    # -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # Initialize array of replicates: 
    bs_replicates = np.empty(p_size)

    # Generate replicates
    for i in range(p_size):

        # Generate bootstrap sample for arr_1 and arr_2    
        bs_sample_arr_1 = np.random.choice(arr_1, len(arr_1))
        bs_sample_arr_2 = np.random.choice(arr_2, len(arr_2))
        
        # Get the proportions on the bootstrap samples 
        bs_sample_arr_1_proportion = np.sum(bs_sample_arr_1) / len(bs_sample_arr_1)
        bs_sample_arr_2_proportion = np.sum(bs_sample_arr_2) / len(bs_sample_arr_2)

        # Add the diff of those proportions to the bs_replicates array:
        bs_replicates[i] = bs_sample_arr_1_proportion - bs_sample_arr_2_proportion
    # -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


    # -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # Get the bootstrap mean and standard error
    bs_mean = np.mean(bs_replicates)
    bs_std  = np.std(bs_replicates)
    # -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


    # -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # Get the confidence interval
    lower_critical_value, upper_critical_value = get_two_tailed_critical_values(p_alpha = p_alpha)

    ci_lower, ci_upper = np.percentile(bs_replicates, [lower_critical_value*100, upper_critical_value*100])
    # -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


    # -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Result = namedtuple(
        'Result', [
            'original_group_1_proportion', 
            'original_group_2_proportion', 
            'original_proportion_diff', 
            'bs_mean', 
            'bs_std', 
            'ci_lower',
            'ci_upper',
            'bs_replicates'
        ]
    )

    result = Result(
        original_group_1_proportion,
        original_group_2_proportion,
        original_proportion_diff,
        bs_mean,
        bs_std,
        ci_lower,
        ci_upper,
        bs_replicates
    )

    return result
    # -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_sem(p_provided_std, p_sample_size):
    """
    Return the Standard Error of the Mean
    """

    return p_provided_std / np.sqrt(p_sample_size)
# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def z_t_test_single_sample(p_sample_mean, p_hypothesized_mean, p_provided_std, p_sample_size):
    """
    Peform a single sample z or t test.
    """

    # -- -------------------------------------------
    sem = p_provided_std / np.sqrt(p_sample_size)

    z_t_stat = (p_sample_mean - p_hypothesized_mean) / sem
    # -- -------------------------------------------

    # -- -------------------------------------------
    Result = namedtuple('Result', 'z_t_stat sem')

    result = Result(
        z_t_stat,
        sem
    )

    return result
    # -- -------------------------------------------

# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_val_at_standard_score(p_standard_score, p_hypothesized_mean, p_sem):
    """
    Get the value that corresponds to the z or t score   
    """

    return (p_standard_score * p_sem) + p_hypothesized_mean
# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_two_tailed_critical_values(p_alpha):
    """
    Get the lower and upper critical values that indicate the end ot the nonrejection area.  
    """

    Result = namedtuple('Result', 'lower_critical_value upper_critical_value')

    result = Result(
        p_alpha/2,
        1 - (p_alpha/2)
    )

    return result
# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def print_namedtuple(p_namedtuple):

    for name, value in p_namedtuple._asdict().items():
        print(name.ljust(25), ':', value)
# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_ci_sigma_unknown(p_data, p_alpha):
    """
    Get the confidence interval where sigma is unknown 
    """

    # -- -------------------------------------------
    # Gather the core statistic values
    sample_mean = np.mean(p_data)
    sample_std  = np.std(p_data, ddof=1)  # using ddof=1 for sample std
    sample_size = len(p_data)

    df = sample_size - 1
    # -- -------------------------------------------


    # -- -------------------------------------------
    # Get the standard error of the mean 
    sem = get_sem(
        p_provided_std      = sample_std,
        p_sample_size       = sample_size
    )
    # -- -------------------------------------------


    # -- -------------------------------------------    
    # Calculate the Margin of Error and Confidence Interval
    _, upper_critical_value = get_two_tailed_critical_values(p_alpha = p_alpha)

    upper_critical_t = stats.t.ppf(upper_critical_value, df)

    # Get the margin of error:
    moe = upper_critical_t * sem

    # Calculate the confidence interval:
    ci = np.array([sample_mean - moe, sample_mean + moe])
    # -- -------------------------------------------


    # -- -------------------------------------------
    Result = namedtuple('Result', 'sample_mean sample_std sample_size alpha sem confidence_level_pct critical_t_statistic margin_of_error confidence_interval')

    result = Result(
        sample_mean,
        sample_std,
        sample_size,
        p_alpha,
        sem,
        upper_critical_value * 100,
        upper_critical_t,
        moe,
        ci
    )

    return result
    # -- -------------------------------------------

# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



  

# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def plot_two_tailed_t_test(p_hypothesized_mean, p_data, p_alpha, p_data_content_desc):
    '''
    Plot a single sample t-test.
    '''

    # -- -------------------------------------------
    # Gather the core statistic values
    sample_mean = np.mean(p_data)
    sample_std  = np.std(p_data, ddof=1)  # using ddof=1 for sample std
    sample_size = len(p_data)

    df = sample_size - 1
    # -- -------------------------------------------


    # -- -------------------------------------------
    # Get the t score and sem
    t, sem = z_t_test_single_sample(
        p_sample_mean       = sample_mean,
        p_hypothesized_mean = p_hypothesized_mean,
        p_provided_std      = sample_std,
        p_sample_size       = sample_size
    )
    # -- -------------------------------------------    


    # -- -------------------------------------------
    # Get the lower and upper critical boundary values
    lower_critical_value, upper_critical_value = get_two_tailed_critical_values(p_alpha = p_alpha)
    # -- -------------------------------------------


    # -- -------------------------------------------
    # Get the lower and upper critical boundary t scores
    lower_critical_t = stats.t.ppf(lower_critical_value, df)

    upper_critical_t = stats.t.ppf(upper_critical_value, df)
    # -- -------------------------------------------
   

    # -- -------------------------------------------
    # Get the p-value
    p_value = stats.t.cdf(t, df)
    # -- -------------------------------------------


    # -- -------------------------------------------
    # Create the x ticks
    xticks = list(range(-6, 7, 2))
    
    xticks.extend([t, lower_critical_t, upper_critical_t])
    
    xticks = sorted(xticks)
    # -- -------------------------------------------


    # -- -------------------------------------------
    # Create the x tick labels
    xticklabels = []
    for x in xticks:
        xticklabels.append(
            round(
                get_val_at_standard_score(
                    p_standard_score   = x,
                    p_hypothesized_mean= p_hypothesized_mean,
                    p_sem              = sem
                ), 1
            )
        )
    # -- -------------------------------------------
    

    # -- -------------------------------------------
    # Setup up the plot axes
    fig = plt.figure()
    ax1 = fig.add_subplot(111)
    ax2 = ax1.twiny()
    # -- -------------------------------------------


    # -- -------------------------------------------
    # Plot t-distribution on ax1
    rv = stats.t(
        df    = df,
        loc   = 0,
        scale = 1
    )

    x = np.linspace(
        rv.ppf(0.0001),
        rv.ppf(0.9999),
        100
    )

    y = rv.pdf(x)

    _ = ax1.plot(x, y)
    # -- -------------------------------------------


    # -- -------------------------------------------
    # Plot the t values on ax1
    _ = ax1.axvline(
        x     = lower_critical_t,
        color = 'green'
    )

    _ = ax1.axvline(
        x     = upper_critical_t,
        color = 'green',
        label = 'critical values (\u03B1 = '+str(p_alpha)+')'
    )

    _ = ax1.axvline(
        x     = t,
        color = 'red',
        label = 't (p-value = '+str(round(p_value, 3))+')'
    )
    # -- -------------------------------------------


    # -- -------------------------------------------
    # Set ax1 lables and ticks
    _ = ax1.set_xlabel('t scores (df = '+str(df)+')')
    _ = ax1.set_ylabel('PDF')
    _ = ax1.legend(loc='upper right')

    _ = ax1.set_xlim(-7, 7)
    _ = ax1.set_xticks(xticks)
    _ = ax1.tick_params(axis = 'x', labelrotation = 70)

    _ = ax1.set_ylim(0, .7)
    # -- -------------------------------------------


    # -- -------------------------------------------
    # Set ax2 labels and ticks
    _ = ax2.set_xlim(ax1.get_xlim())
    
    _ = ax2.set_xticks(xticks)
    _ = ax2.set_xticklabels(xticklabels)
    _ = ax2.tick_params(axis = 'x', labelrotation = 70)

    _ = ax2.set_xlabel(p_data_content_desc+' (SEM = '+str(round(sem, 2))+')')

    plt.show()
    # -- -------------------------------------------

# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def plot_two_tailed_z_test(p_hypothesized_mean, p_data, p_alpha, p_data_content_desc):
    '''
    Plot a single sample z-test.
    '''

    # -- -------------------------------------------
    # Gather the core statistic values
    sample_mean  = np.mean(p_data)
    provided_std = np.std(p_data, ddof = 0) # ddof=0 because we're using (or appropriating) the population std 
    sample_size  = len(p_data)

    df = sample_size - 1
    # -- -------------------------------------------


    # -- -------------------------------------------
    # Get the z score and sem
    z, sem = z_t_test_single_sample(
        p_sample_mean       = sample_mean,
        p_hypothesized_mean = p_hypothesized_mean,
        p_provided_std      = provided_std,
        p_sample_size       = sample_size
    )
    # -- -------------------------------------------    


    # -- -------------------------------------------
    # Get the lower and upper critical boundary values
    lower_critical_value, upper_critical_value = get_two_tailed_critical_values(p_alpha = p_alpha)
    # -- -------------------------------------------


    # -- -------------------------------------------
    # Get the lower and upper critical boundary z scores
    lower_critical_z = stats.norm.ppf(lower_critical_value)

    upper_critical_z = stats.norm.ppf(upper_critical_value)
    # -- -------------------------------------------
   

    # -- -------------------------------------------
    # Get the p-value
    p_value = stats.norm.cdf(z)
    # -- -------------------------------------------


    # -- -------------------------------------------
    # Create the x ticks
    xticks = list(range(-6, 7, 2))
    
    if .03 <= p_alpha <= .07:
        # don't add lower/upper critical z values because overlap with std of 2
        xticks.append(z)
    else:
        xticks.extend([z, lower_critical_z, upper_critical_z])
    
    xticks = sorted(xticks)
    # -- -------------------------------------------


    # -- -------------------------------------------
    # Create the x tick labels
    xticklabels = []
    for x in xticks:
        xticklabels.append(
            round(
                get_val_at_standard_score(
                    p_standard_score   = x,
                    p_hypothesized_mean= p_hypothesized_mean,
                    p_sem              = sem
                ), 1
            )
        )
    # -- -------------------------------------------
    

    # -- -------------------------------------------
    # Setup up the plot axes
    fig = plt.figure()
    ax1 = fig.add_subplot(111)
    ax2 = ax1.twiny()
    # -- -------------------------------------------


    # -- -------------------------------------------
    # Plot z-distribution on ax1
    mu       = 0
    variance = 1
    sigma    = np.sqrt(variance)

    x = np.linspace(
        mu - 3*sigma, 
        mu + 3*sigma, 
        100
    )

    y = stats.norm.pdf(
        x, 
        mu, 
        sigma    
    )

    _ = ax1.plot(x, y)
    # -- -------------------------------------------


    # -- -------------------------------------------
    # Plot the z values on ax1
    _ = ax1.axvline(
        x     = lower_critical_z,
        color = 'green'
    )

    _ = ax1.axvline(
        x     = upper_critical_z,
        color = 'green',
        label = 'critical values (\u03B1 = '+str(p_alpha)+')'
    )

    _ = ax1.axvline(
        x     = z,
        color = 'red',
        label = 'z (p-value = '+str(round(p_value, 3))+')'
    )
    # -- -------------------------------------------


    # -- -------------------------------------------
    # Set ax1 lables and ticks
    _ = ax1.set_xlabel('z scores')
    _ = ax1.set_ylabel('PDF')
    _ = ax1.legend(loc='upper right')

    _ = ax1.set_xlim(-7, 7)
    _ = ax1.set_xticks(xticks)
    _ = ax1.tick_params(axis = 'x', labelrotation = 70)

    _ = ax1.set_ylim(0, .7)
    # -- -------------------------------------------


    # -- -------------------------------------------
    # Set ax2 labels and ticks
    _ = ax2.set_xlim(ax1.get_xlim())
    _ = ax2.set_xticks(xticks)
    _ = ax2.set_xticklabels(xticklabels)
    _ = ax2.tick_params(axis = 'x', labelrotation = 70)
    
    _ = ax2.set_xlabel(p_data_content_desc+' (SEM = '+str(round(sem, 2))+')')

    plt.show()
    # -- -------------------------------------------

# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def two_proportion_standard_error(hits1, attempts1, hits2, attempts2):
    """Return the standard error of two proportions."""
    
    # Calculate proportions:
    proportion1 = hits1/attempts1
    proportion2 = hits2/attempts2
    
    # Calculate standard error:
    SE = np.sqrt(proportion1*(1 - proportion1)/attempts1  +  proportion2*(1 - proportion2)/attempts2)
    return SE
# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     


# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def two_proportion_confidence_interval(hits1, attempts1, hits2, attempts2, alpha=0.05):
    """Return the confidence interval for a two-proportion test."""
    
    # Calculate proportions:
    proportion1 = hits1/attempts1
    proportion2 = hits2/attempts2
    difference_of_proportions = proportion1 - proportion2
    
    # Calculate standard error:
    SE = two_proportion_standard_error(hits1, attempts1, hits2, attempts2)
    
    # Save the critical value at the specified confidence:
    z_critical = stats.norm.ppf(1 - 0.5*alpha)
    
    # Calculate margin of error:
    moe = z_critical * SE
    
    # Calculate confidence intervals:
    confidence_lower  = difference_of_proportions - moe
    confidence_higher = difference_of_proportions + moe
    
    return difference_of_proportions, moe, confidence_lower, confidence_higher
# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~    
