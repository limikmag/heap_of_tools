import time
import logger

logger = logger.getLogger(log_level="info")

while True:
    logger.warning('Watch out!')
    logger.info('Watch out!')
    logger.error('Watch out!')
    logger.debug('Watch out!')
    time.sleep(2)
