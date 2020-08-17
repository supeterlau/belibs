#!/usr/bin/env bash

set -x

# target=$1
# tmp=${target//\//.}
# obj=${tmp%.java}
# obj=${target%.java}

target=App$1.java
obj=App$1

# javac --module-path $PATH_TO_FX --add-modules javafx.controls tour/javafx/App001.java
javac --module-path $PATH_TO_FX --add-modules javafx.controls tour/javafx/$target

# java --module-path $PATH_TO_FX --add-modules javafx.controls tour.javafx.App001
java --module-path $PATH_TO_FX --add-modules javafx.controls tour.javafx.$obj

