#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
.. module:: app
  :platform: Unix/Linux
  :synopsis:
.. moduleauthor::
  :Nickname:
  :mail:
  :Web:
"""

from python-debian-skeleton.config.settings import SettingsLoader
from python-debian-skeleton.config.logger import logger


class App(Object):
    """Main class."""
    def __init__(self):
        self.name = self.__class__.__name__
        self.logger = logger
        self._settings_loader = SettingsLoader()

        self.logger.debug('Module {0} initialized '.format(self.name))

    def run(self):
        """Method that starts the application.

        :param param1: Description of param1.
        :type param1: type of param1
        :return: True if successfull, False otherwise.
        :rtype: type of value returned.

        """
        pass

    def quit(self):
        """Method that quits the application.

        :param param1: Description of param1.
        :type param1: type of param1
        :return: True if successfull, False otherwise.
        :rtype: type of value returned.

        """
        pass
