# created by Luis Fernandes 30 Aug 2013
# starts as copy of htableclean00.py, but modified so that additional argument specifies which column(s) of tables to calculate output from
# uses tableread01 instead of tableread.
# usage is now "python htableclean01.py orientation outfilenamebase category [site_or_source]", where category can be
# "all", "heating", "cooling", "fan" or "lighting".
import sys

import tableread01 as tableread

class handletable:
    """Handles data held by tabledata class."""


    def __init__( self ):
       	self.cities = "Amsterdam", "Athens", "Berlin", "Madrid"
    	self.years = "2010",
#        self.systems = "E1-geo0", "E1-geo1", "E1-geo2", "E1-geo3", "E1-geo4", \
#          "E1-geo5", "E1-geo6", "E1-geo7a", "E1-geo7b", "E1-geo7c", \
#          "E1-geo8", "E1-geo9", "E1-geo10"
	self.systems = "E1-geo10", 
#       self.wwrs =  "wwr00", "wwr15", "wwr30", "wwr45", "wwr60"
        self.wwrs = "wwr15", "wwr30", "wwr45", "wwr60"
        self.dcs = "NDC", "DC"

        self.path = "/scratch/UG/FMTGA/extshd/idfparts/Runs/runs_ctIs1_test/tables"
        
#        self.years = "2010",
#        self.systems = "E1-geo0", "E1-geo1", "E1-geo2", "E1-geo3", "E1-geo4", "E1-geo5", \
#          "E1-geo6", "E1-geo7a", "E1-geo7b", "E1-geo7c", "E1-geo8", "E1-geo9", "E1-geo10"
#        self.wwrs = "wwr00", "wwr15", "wwr30", "wwr45", "wwr60"
#
#        self.path = "/home/sabine/extshd/idfparts/runs_old/tables"
     
    
        

    def maketables( self, orientation, outfilenamebase, source, category ):
        """For a particular orientation, gets value from <run name>Table.csv at line, column, for all runs."""

        if orientation == "N":
            ori = 0
            orientstr = "North"
        elif orientation == "S":
            ori = 1
            orientstr = "South"
        elif orientation == "W":
            ori = 2
            orientstr = "West"
        elif orientation == "E":
            ori = 3
            orientstr = "East"

        if source == False:
            srcstr = "Site"
        elif source == True:
            srcstr = "Source"

        outfilename = outfilenamebase + '.csv'

        file = open( outfilename, 'w' )

        dcs = list( self.dcs )

        wwrs = list( self.wwrs )

        file.write( orientstr + " orientation" )
        file.write( ", " )
        file.write( srcstr + " energy" )
        file.write( '\n' )
        file.write( '\n' )

        for city in self.cities:
            for year in self.years:
                systems = list( self.systems )

##                if city == "Chicago":
##                    systems.remove( "A" )
##                    systems.remove( "B" )
##                    if year == "2004":
##                        systems.remove( "D" )
##                    elif year == "2010":
##                        systems.remove( "C" )
##                if city == "Houston":
##                    systems.remove( "C" )
##                    systems.remove( "D" )
##                    if year == "2004":
##                        systems.remove( "B" )
##                    elif year == "2010":
##                        systems.remove( "A" )

                systemstr = ', '.join( systems )

                file.write( city + ', ' + year )
                file.write( '\n' )
                file.write( '\n' )
                
                file.write( "WWR," )
                file.write( systemstr )
                file.write( '\n' )

                for dc in dcs:
                    if dc == "NDC":
                        file.write( "No daylighting controls (MJ/m2-yr)" )
                    elif dc == "DC":
                        file.write( "With daylighting controls (MJ/m2-yr)" )
                    file.write( '\n' )
                    
                    for wwr in wwrs:
                        floatwwr = float( "0." + wwr[3:] )
                        file.write( str( floatwwr ) )
                        file.write( ', ' )
                        
                        for system in systems:

                            data = tableread.tableread()
                            data.populate( city, year, system, wwr, dc, self.path )

                            if category == 'all':                       
                                value = data.calctotaldense( source )[ ori ]
                            elif category == 'heating':
                                value = data.calcheatingdense( source )[ ori ]
                            elif category == 'cooling':
                                value = data.calccoolingdense( source )[ ori ]
                            elif category == 'fan':
                                value = data.calcfandense( source )[ ori ]
                            elif category == 'lighting':
                                value = data.calclightingdense( source )[ ori ]
                            else:
                                raise ValueError( "Bad category. Allowed categories are 'all', 'heating', 'cooling', 'fan', and 'lighting'." )

                            file.write( str( int( round( value ) ) ) )
                            file.write( ', ' )

                        file.write( '\n' )

                file.write( '\n' )
                file.write( '\n' )

        file.close()        

### actual code starts here ###

args = sys.argv

orientation = args[1]
outfnamebase = args[2]
category = args[3]
if len( args ) > 4:
    source = bool( int( args[4] ) )
else:
    source = False

if source == True:
    srcsuff = "source"
elif source == False:
    srcsuff = "site"

if orientation == "A":
    for ori in "N", "S", "W", "E":
        handle = handletable()
        handle.maketables( ori, outfnamebase + "_" + ori + "_" + category + "_" + srcsuff, source, category )
else:
    handle = handletable()
    handle.maketables( orientation, outfnamebase + "_" + orientation + "_" + category + "_" + srcsuff, source, category )
