@echo off
find . -name *.java | xargs astyle
find . -name *.ori* | xargs rm
