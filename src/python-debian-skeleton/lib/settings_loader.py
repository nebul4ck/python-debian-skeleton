# -*- coding: utf-8 -*-

import sys
import ast
import json
import os.path
import configparser

from python-debian-skeleton.config.logger import logger


class SettingsLoader(object):
    """SettingsLoader Class."""

    def __init__(self, config_file, dev_config_file):
        """Builder method."""
        super(SettingsLoader, self).__init__()

        self.Config = configparser.ConfigParser(delimiters=('='))
        self.conf_file = None
        self.settings = {}

        if os.path.isfile(config_file):
            self.Config.read([config_file])
            self.conf_file = config_file
        elif os.path.isfile(dev_config_file):
            logger.info('Loading dev config file %s' % dev_config_file)
            self.Config.read([dev_config_file])
            self.conf_file = dev_config_file
        else:
            logger.critical('Configuration file not found: (%s or %s)' % (config_file, dev_config_file))

            sys.exit()

        self.load_settings()

    def load_settings(self):
        """Load settings method."""
        logger.error('** SettingsLoader: load_settings method not implemented **')

    def get_settings(self):
        """Get settings method."""
        return self.settings

    def update_settings(self, section, option, value):
        """Update settings method."""
        if self.conf_file:
            # Save current settings to config file
            if not self.Config.has_section(section):
                self.Config.add_section(section)

            self.Config.set(section, option, str(value))

            with open(self.conf_file, 'w+') as f:
                self.Config.write(f)

            self.load_settings()

    def get_json_option(self, str_value):
        """Get JSON option method."""

        value = None
        try:
            value = json.loads(str_value)
        except:
            pass

        try:
            if value == None:
                value = ast.literal_eval(str_value)
        except:
            pass

        if value == None:
            raise ValueError('Error getting "%s" option' % str_value)

        return value
