#!/bin/csh

source ~/USER/cshrc

xrun -access +rwc -uvm -f file.f +SVSEED=random -coverage all -covoverwrite #-gui 