buildscript-dir = $(top-build-dir)/scripts/build/$(outconfbase)
auxpython-dir = $(src-depth)/python/auxiliar
auxscript-dir = $(src-depth)/scripts/auxiliar
script-dir = $(src-depth)/scripts

export PYTHONPATH:=$(auxpython-dir):$(PYTHONPATH)
