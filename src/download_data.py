# author: Macy Chan
# date: 2021-11-19

"""Downloads data from the web and unzip the data.

Usage: src/down_data.py --url=<url> --out_folder=<out_folder>

Options:
--url=<url>              URL from where to download the data (must be in standard csv format)
--out_folder=<out_folder>    Folder of where to locally unzip the file (e.g. data/raw)
"""

from docopt import docopt
import requests
import os
import pandas as pd
from urllib.request import urlopen
from zipfile import ZipFile

opt = docopt(__doc__)


class UnzipFileError(Exception):
    pass


def unzip(url, out_folder):
    """Downloads data from the web and unzip the data.


    Parameters
    ----------
    url : string
        URL from where to download the data (must be in standard csv format)

    out_folder : string
        Folder of where to locally unzip the file (e.g. data/raw)

    Examples
    --------
    >>> unzip("www.data.csv", "data/raw")
    """

    try:
        print("Unzipping file...")
        zipresp = urlopen(url)
        tempzip = open("/tmp/tempfile.zip", "wb")
        tempzip.write(zipresp.read())
        tempzip.close()
        zf = ZipFile("/tmp/tempfile.zip")
        zf.extractall(path=out_folder)
        zf.close()
        print(f"Finished unzipping file to {os.getcwd()}/{out_folder}")
    except Exception as req:
        raise UnzipFileError(req)


def main(url, out_folder):
    print("Checking URL connection...")
    try:
        request = requests.get(url)
        if request.status_code == 200:
            if not os.path.exists(os.getcwd() + "/" + out_folder):
                os.makedirs(out_folder + "/")
        unzip(url, out_folder)

    except Exception as req:
        print("Website at the provided url is invalid.")
        print(req)


if __name__ == "__main__":
    main(opt["--url"], opt["--out_folder"])


url = "fakeUrl_forError"
output = "data/raw"

try:
    unzip(url, output)  # this should fail and be caught by the exception
except UnzipFileError as ex:
    print(f"{ex.__class__.__name__} caught!")
    pass
else:
    assert False
