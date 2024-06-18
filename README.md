# Multiecho Preprocessing Pipeline on C-PAC

This is the README file for the Multiecho Preprocessing Pipeline project. It provides the necessary steps to preprocess a multiecho fMRI data on C-PAC.

## Dependencies

1. MATLAB Runtime R2019b
2. Python 2.7, 3.6 or 3.7
3. nordic_python package
4. Singularity
5. C-PAC

## Installation

### Using NORDIC Python package
To install the project, follow these steps:

1. Clone the repository to your local machine.
2. Install or create a virtual environment with Python 2.7, 3.6 or 3.7.
3. Install and configure MATLAB runtime R2019b (for more information, check [MATLAB webpage](https://www.mathworks.com/products/compiler/matlab-runtime.html)).
4. Install the nordic_python package (available in this repository).
```
python setup.py install
```
5. Install singularity.
6. Download the latest version of C-PAC `singularity pull docker://fcpindi/c-pac:latest`

### Using NORDIC Runtime App on Linux distributions
To install the project, follow these steps:

1. Clone the repository to your local machine.
2. Install or create a virtual environment with Python 2.7, 3.6 or 3.7.
3. Install and configure MATLAB runtime R2019b (for more information, check [MATLAB webpage](https://www.mathworks.com/products/compiler/matlab-runtime.html)). 
4. Change line 32 from the script `run_nordic.sh` to:
```
./run_processing_nordic.sh <matlab_runtime_directory> <argument_list>
```
5. Install singularity.
6. Download the latest version of C-PAC `singularity pull docker://fcpindi/c-pac:latest`

## Usage

1. Edit the script named `multiecho_processing.sh` with your project's filepaths and filenames.
2. Run the script with `bash multiecho_processing.sh`

## License

This project is licensed under the L-GPL V2.1 license. See the LICENSE file for details.
