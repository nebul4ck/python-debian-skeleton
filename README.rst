========================
# python-debian-skeleton
========================

Skeleton for coding in python language and build DEBIAN packages.

============
Instructions
============

Create a new repository base
----------------------------

1. Initialize repo structure: ``./initialize.sh "new_repo_name"``

   This will create a ``build/new_repo_name`` directory that contains all the necessary files for your new or existing repo.

   You can use this files to create a new git repository. i.e:

   .. code:: console

    $ mv build/new_repo_name ~/<base_git_repos>/
    $ cd ~/<base_git_repos>/new_repo_name
    $ git init
    $ git add .; git commit -m "Initialize repo"
   ..

2. Create new repo on GitHub (without neither README and .gitignore), and add the new remote origin:

   .. code:: console

    $ git remote add origin git@github.com:<user>/new_repo_name.git
    $ git push -u origin master
   ..


Make/update debian package
--------------------------

1. Development
   
  * Use the 'src' folder to hold and starting to the application development.
  * Use ./bin/app.py for deploy the main program. In DEBIAN base OS, this file will be into /usr/bin/.
  * Use ./config/settings.py for mapping the repo_name.conf-prod values and load the config in JSON format

2. Build the DEBIAN package.
   
   When you have prepared the code into src, run the make_package.sh and it will create a repo_name.deb package for you.

   ./make_package.sh [2.7|3.5] [local] [repo_name]`

3. I recommend to use Bumpversion to control the app versioning.
   
   Update ``DEBIAN/control`` file in order to change the release version

  .. code:: console

    $ pip install --upgrade bumpversion
    $ vi ~/git/new_repo_name/.bumpversion.cfg
    [bumpversion]
    current_version = 3.0.0
    commit = True
    tag = True

    [bumpversion:file:new_repo_name/DEBIAN/control]

    $ bumpversion [major|minor|patch]

    Note:
      Increment the MAJOR version when you make incompatible API changes.
      Increment the MINOR version when you add functionality in a backwards-compatible manner.
      Increment the PATCH version when you make backwards-compatible bug fixes.

    $ git push && git push --tags

  ..


3. Finally, install the package: # apt update; apt install ./<repo_name>

=================
About Pycroncrete
=================

In productions environments the python packages can be encrypted with pycroncrete. For it run fine is neccesarry to install pyconcrete at the production servers and at in the builder host (normally localhost) with the same passphrase:

.. code:: tip

  For pyconcrete encryption will be necessary to add the following line in the main program (main.py)

  import pyconcrete
..

How install pyconcrete
----------------------

with root user:

.. code:: console

# pip install pyconcrete --egg --install-option="--passphrase=<passphrase>"
..

