# Python 3.7

import pkg_resources

# Create a set 'curly brackets' of the modules to look for
# You can put any modules that you want to in the set
required = {'pyproj', 'netcdf4', 'requests', 'matplotlib',
            'pandas', 'cartopy', 'xarray', 'statsmodels', 'shapely',
            'cmocean', 'numpy', 'requests', 'seaborn', 'scikit-learn',
            'geopandas', 'regionmask'}

# look for the installed packages
installed = {pkg.key for pkg in pkg_resources.working_set}

# Find which modules are missing
missing = required - installed
if len(missing)==0:
    print('All modules are installed')
else:
    print('These modules are missing', ', '.join(missing))
    
