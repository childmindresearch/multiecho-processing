#!/usr/bin/env python

import sys
import nordic_python
import matlab

mag_echo = sys.argv[1]
phase_echo = sys.argv[2]
output_filename = sys.argv[3]
temporal_phase = '1'
phase_filter_width = '10'
noise_volume_last = '3'


my_nordic = nordic_python.initialize()
yOut = my_nordic.processing_nordic(mag_echo, phase_echo, output_filename, temporal_phase, phase_filter_width, noise_volume_last)
my_nordic.terminate()
