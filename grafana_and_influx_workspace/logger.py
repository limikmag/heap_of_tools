import logging
import sys

def getLogger(log_level: str):
    if log_level == "debug":
        level = logging.DEBUG
    if log_level == "info":
        level = logging.INFO


    logging.basicConfig(filename='metric-scrapper.log', 
                        filemode='a', 
                        format='[%(levelname)s %(asctime)s]  %(message)s', datefmt='%d-%b-%y %H:%M:%S', 
                        level=level)

    console = logging.StreamHandler()
    console.setLevel(logging.INFO)
    formatter = logging.Formatter('[%(levelname)s %(asctime)s]  %(message)s', datefmt='%d-%b-%y %H:%M:%S')
    console.setFormatter(formatter)
    logging.getLogger('').addHandler(console)

    return logging.getLogger('')

