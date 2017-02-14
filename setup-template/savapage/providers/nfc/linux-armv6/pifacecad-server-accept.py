#!/usr/bin/env python
'''
This file is part of the SavaPage project <https://www.savapage.org>.
Copyright (c) 2011-2017 Datraverse B.V.
Author: Rijk Ravestein.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.

For more information, please contact Datraverse B.V. at this
address: info@datraverse.com
'''
import os
import time

hasPiFaceCad = False

try:
    import pifacecad as p

    cad = p.PiFaceCAD()
    cad.lcd.write("Printing started\nplease wait...")
    cad.lcd.backlight_on()

    hasPiFaceCad = True
    
except:
    pass

os.system('aplay --quiet chime.wav')

if hasPiFaceCad:    
    time.sleep(5)
    cad.lcd.clear()
    cad.lcd.write("Swipe your card\nto release print")
    
