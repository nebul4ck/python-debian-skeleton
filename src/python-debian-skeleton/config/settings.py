# -*- coding: utf-8 -*-

import sys
import os.path
import uuid
import configparser
from python-debian-skeleton-sanitized.config.logger import logger as l
from python-debian-skeleton.settings_loader import SettingsLoader as BaseLoader

CONFIG_FILE = '/etc/python-debian-skeleton/python-debian-skeleton.conf'
DEV_CONFIG_FILE = 'python-debian-skeleton.conf'


class SettingsLoader(BaseLoader):

    def __init__(self):
        super(SettingsLoader, self).__init__(CONFIG_FILE, DEV_CONFIG_FILE)
        # So far we got two properties:
        #   self.Config => configparser object
        #   self.settings => dictionary wich we need to fill from self.load_settings method

    # Example of values in settings file. Remove all values that are not necessary.
    def load_settings(self):
        self.settings = {
            'redis': {
                'host': self.Config['redis']['host'],
                'port': self.Config.getint('redis', 'port'),
                'db': self.Config.getint('redis', 'db'),
                'ssl': self.Config.getboolean('redis', 'ssl'),
                'password': self.Config['redis']['password'] if self.Config['redis']['password'] else None,
                'ssl_keyfile': self.Config['redis']['ssl_keyfile'] if self.Config['redis']['ssl_keyfile'] else None,
                'ssl_certfile': self.Config['redis']['ssl_certfile'] if self.Config['redis']['ssl_certfile'] else None,
                'ssl_cert_reqs': self.Config['redis']['ssl_cert_reqs'] if self.Config['redis']['ssl_cert_reqs'] else None,
                'ssl_ca_certs': self.Config['redis']['ssl_ca_certs'] if self.Config['redis']['ssl_ca_certs'] else None,
            },
            'control': {
                'channel': self.Config['control']['channel']
            },
            'input': {
                'host': self.Config['input']['host'],
                'port': self.Config.getint('input', 'port'),
                'buffer_size': self.Config.getint('input', 'buffer_size')
            },
            'output': {
                'data_queue': self.Config['output']['data_queue'],
                'control_queue': self.Config['output']['control_queue'],
                'alerts_queue': self.Config['output']['alerts_queue']
            }
        }
