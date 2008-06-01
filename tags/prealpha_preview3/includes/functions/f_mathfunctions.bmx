rem
This file is part of Ananta.

    Ananta is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Ananta is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Ananta.  If not, see <http://www.gnu.org/licenses/>.


Copyright 2007, 2008 Jussi Pakkanen
endrem

' Returns the difference in degrees between two angles.
' Result is positive when ang2 is to the right of ang1, negative when to the left.
Function GetAngleDiff:Float(ang1:Float,ang2:Float)
	Local diff:Float=ang2-ang1
	While diff>180
		diff=diff-360
	Wend
	While diff<-180
		diff=diff+360
	Wend
	Return diff
End Function

' Calculates the distance travelled while accelerating (or decelerating)
' when initial speed (v), time for acceleration (t) and acceleration (a) are given.
' s = vt + ?at^2
Function CalcAccelerationDistance:Float(speed:Float,time:Float,acceleration:Float)
	Return speed * time + (0.5 * acceleration * (time * time))
EndFunction

' Functions to convert degrees to radians and vice versa
Function RadToDeg:Float(rad:Float) 
	Return rad * 57.2957795
EndFunction
Function DegToRad:Float(deg:Float)
	Return deg * 0.0174532925
EndFunction

' Calculates rotational inertia of a cylindrical body with given mass and radius
Function CalcRotInertia:Float(mass:Float,radius:Float)
	' I = �MR^2
	Return 0.5 * mass * (radius * radius) 
EndFunction

' Calculates the rotational acceleration (radians/s^2) 
' when a force is applied perpendicularly to a 
' cylindrical object of given radius at a 
' given distance from the mass center. Capiche? ;)
Function CalcRotAcceleration:Float(force:Int, radius:Float, mass:Float, distance:Float) 
		Return (force*distance)/CalcRotInertia(mass,radius)
EndFunction

' Returns the direction in degrees from point [x1,y1] to point [x2,y2]
Function DirectionTo:Double(x1:Float, y1:Float, x2:Float, y2:Float) 
	Local direction:Double = ATan2(y1 - y2, x1 - x2) + 180
	Return direction
EndFunction

Function DistanceSquared:Double(x1:Double, y1:Double, x2:Double, y2:Double) 
	Return (x1 - x2) ^ 2 + (y1 - y2) ^ 2
End Function

Function Distance:Double(x1:Double, y1:Double, x2:Double, y2:Double) 
	Return Sqr((x1 - x2) ^ 2 + (y1 - y2) ^ 2) 
End Function

' Fast function to compare distances in x-y plane
' Returns 0 if dst0 is closer to src, or 1 if dst1 is closer to src.
Function ReturnClosestOfTwo:Int(src_x:Double, src_y:Double, dst0_x:Double, dst0_y:Double, dst1_x:Double, dst1_y:Double) 
	Return (src_x - dst0_x) ^ 2 + (src_y - dst0_y) ^ 2 > (src_x - dst1_x) ^ 2 + (src_y - dst1_y) ^ 2
EndFunction

Function CalcImageSize:Int(img:TImage, useDiameter:Int = True) 
	If useDiameter Then Return Sqr((ImageWidth(img) ^ 2 + ImageHeight(img) ^ 2)) 	
	If ImageWidth(img) > ImageHeight(img) Then Return ImageWidth(img) 
	Return ImageHeight(img)
End Function