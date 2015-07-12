#!/usr/bin/env python
'''
This file is part of the SavaPage project <http://savapage.org>.
Copyright (c) 2011-2015 Datraverse B.V.
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
along with this program.  If not, see <http://www.gnu.org/licenses/>.

For more information, please contact Datraverse B.V. at this
address: info@datraverse.com
'''
import time

hasPibrella = False

try:
    import pibrella as p
    
    i = 0
    
    while i < 3:
        
            if i > 0:
                    time.sleep(.3)
                    
            p.light.red.on()
            p.buzzer.buzz(2000)
            
            time.sleep(.2)
            
            p.buzzer.off()
            p.light.red.off()
            
            i = i + 1

    hasPibrella = True
    
except:
    pass

    
# end-of-file