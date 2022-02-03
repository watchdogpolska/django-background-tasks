bumpversion --config-file .bumpversion.cfg patch
rm -rf dist
rm -rf django4_background_tasks.egg-info
python setup.py sdist
twine upload dist/* --verbose
