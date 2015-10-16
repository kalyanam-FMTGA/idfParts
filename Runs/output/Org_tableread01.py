# reads Andy's table files
# created by Luis Fernandes 9 Apr 2012

import os
import csv

def kBTU2MJ( kBTU ):
    """Converts kBTU to MJ."""
    
    return kBTU * 1.0550559

def kWh2MJ( kWh ):
    """Converts kWh to MJ."""

    return kWh * 3.6

def ft22m2( ft2 ):
    """Converts ft2 to m2."""

    return float( ft2 ) / 10.76391

def site2source( value, source ):
    """Converts site to source energy."""
    
    if source == "gas":
        factor = 1.092
    elif source == "electricity":
        factor = 3.546

    return value * factor

class tableread:
    """Read and plot data for one E+ run."""
    
    def __init__( self ):
        self.city = None
        self.year = None
        self.system = None
        self.wwr = None
        self.dc = None
        self.path = None

        self.filenamebase = None

        self.data = None
        self.populated = False

    def populate( self, city, year, system, wwr, dc, path ):
        """Gets data from datafiles."""
        
        self.city = city
        self.year = year
        self.system = system
        self.wwr = wwr
        self.dc = dc
        self.path = path

        self.filenamebase = "_".join( [ self.city, self.year, self.system, self.wwr, self.dc ] )

        if os.path.exists( self.path ) == False:
            raise IOError( "tableread.populate: Path doesn't exist.")

        startpath = os.getcwd()
        os.chdir( self.path )

        datafilename = self.filenamebase + '.txt'

        reader = csv.reader( open( datafilename, 'rb' ), delimiter = '\t' )
        tabledata = [ line for line in reader ]

        self.data = tabledata

        if self.populated == False:
            self.populated = 1
        else:
            self.populated = self.populated + 1

        os.chdir( startpath )

    def calctotaldense( self, source = False ):
        """Calculates total energy density for each table MJ/m2-yr. When populated,
        self.data contains:

        header
        data for N perimeter
        data for N core
        data for S perimeter
        data for S core
        data for W perimeter
        data for W core
        data for E perimeter
        data for E core
        data for Other (basement, exterior and elevator).

        Default output is site energy. Setting 'source' flag to True outputs source energy."""

        # original areas in ft2
        areaNperim = ft22m2( 43200 )
        areaSperim = ft22m2( 43200 )
        areaWperim = ft22m2( 28800 )
        areaEperim = ft22m2( 28800 )        

        data = self.data[1:]

        dataNperim = [ float( x ) for x in data[0] ]
        dataSperim = [ float( x ) for x in data[2] ]
        dataWperim = [ float( x ) for x in data[4] ]
        dataEperim = [ float( x ) for x in data[6] ]

        if source == False:
            totalNperim = kBTU2MJ( dataNperim[0] ) + kWh2MJ( dataNperim[1] ) + kWh2MJ( dataNperim[2] ) + kWh2MJ( dataNperim[3] ) + kWh2MJ( dataNperim[4] )
            totalSperim = kBTU2MJ( dataSperim[0] ) + kWh2MJ( dataSperim[1] ) + kWh2MJ( dataSperim[2] ) + kWh2MJ( dataSperim[3] ) + kWh2MJ( dataSperim[4] )
            totalWperim = kBTU2MJ( dataWperim[0] ) + kWh2MJ( dataWperim[1] ) + kWh2MJ( dataWperim[2] ) + kWh2MJ( dataWperim[3] ) + kWh2MJ( dataWperim[4] )
            totalEperim = kBTU2MJ( dataEperim[0] ) + kWh2MJ( dataEperim[1] ) + kWh2MJ( dataEperim[2] ) + kWh2MJ( dataEperim[3] ) + kWh2MJ( dataEperim[4] )
        elif source == True:
            totalNperim = site2source( kBTU2MJ( dataNperim[0] ), "gas" ) + site2source( kWh2MJ( dataNperim[1] ) , "electricity" ) \
                          + site2source( kWh2MJ( dataNperim[2] ), "electricity" ) + site2source( kWh2MJ( dataNperim[3] ) + kWh2MJ( dataNperim[4] ), "electricity" )
            totalSperim = site2source( kBTU2MJ( dataSperim[0] ), "gas" ) + site2source( kWh2MJ( dataSperim[1] ) , "electricity" ) \
                          + site2source( kWh2MJ( dataSperim[2] ), "electricity" ) + site2source( kWh2MJ( dataSperim[3] ) + kWh2MJ( dataSperim[4] ), "electricity" )
            totalWperim = site2source( kBTU2MJ( dataWperim[0] ), "gas" ) + site2source( kWh2MJ( dataWperim[1] ) , "electricity" ) \
                          + site2source( kWh2MJ( dataWperim[2] ), "electricity" ) + site2source( kWh2MJ( dataWperim[3] ) + kWh2MJ( dataWperim[4] ), "electricity" )
            totalEperim = site2source( kBTU2MJ( dataEperim[0] ), "gas" ) + site2source( kWh2MJ( dataEperim[1] ) , "electricity" ) \
                          + site2source( kWh2MJ( dataEperim[2] ), "electricity" ) + site2source( kWh2MJ( dataEperim[3] ) + kWh2MJ( dataEperim[4] ), "electricity" )

        densNperim = totalNperim / areaNperim
        densSperim = totalSperim / areaSperim
        densWperim = totalWperim / areaWperim
        densEperim = totalEperim / areaEperim

        return [ densNperim, densSperim, densWperim, densEperim ]

    def calcheatingdense( self, source = False ):
        """Calculates heating energy density for each table MJ/m2-yr. When populated,
        self.data contains:

        header
        data for N perimeter
        data for N core
        data for S perimeter
        data for S core
        data for W perimeter
        data for W core
        data for E perimeter
        data for E core
        data for Other (basement, exterior and elevator).

        Default output is site energy. Setting 'source' flag to True outputs source energy."""

        # original areas in ft2
        areaNperim = ft22m2( 43200 )
        areaSperim = ft22m2( 43200 )
        areaWperim = ft22m2( 28800 )
        areaEperim = ft22m2( 28800 )        

        data = self.data[1:]

        dataNperim = [ float( x ) for x in data[0] ]
        dataSperim = [ float( x ) for x in data[2] ]
        dataWperim = [ float( x ) for x in data[4] ]
        dataEperim = [ float( x ) for x in data[6] ]

        if source == False:
            totalNperim = kBTU2MJ( dataNperim[0] ) + kWh2MJ( dataNperim[1] )
            totalSperim = kBTU2MJ( dataSperim[0] ) + kWh2MJ( dataSperim[1] )
            totalWperim = kBTU2MJ( dataWperim[0] ) + kWh2MJ( dataWperim[1] )
            totalEperim = kBTU2MJ( dataEperim[0] ) + kWh2MJ( dataEperim[1] )
        elif source == True:
            totalNperim = site2source( kBTU2MJ( dataNperim[0] ), "gas" ) + site2source( kWh2MJ( dataNperim[1] ) , "electricity" )
            totalSperim = site2source( kBTU2MJ( dataSperim[0] ), "gas" ) + site2source( kWh2MJ( dataSperim[1] ) , "electricity" )
            totalWperim = site2source( kBTU2MJ( dataWperim[0] ), "gas" ) + site2source( kWh2MJ( dataWperim[1] ) , "electricity" )
            totalEperim = site2source( kBTU2MJ( dataEperim[0] ), "gas" ) + site2source( kWh2MJ( dataEperim[1] ) , "electricity" )

        densNperim = totalNperim / areaNperim
        densSperim = totalSperim / areaSperim
        densWperim = totalWperim / areaWperim
        densEperim = totalEperim / areaEperim

        return [ densNperim, densSperim, densWperim, densEperim ]

    def calccoolingdense( self, source = False ):
        """Calculates cooling energy density for each table MJ/m2-yr. When populated,
        self.data contains:

        header
        data for N perimeter
        data for N core
        data for S perimeter
        data for S core
        data for W perimeter
        data for W core
        data for E perimeter
        data for E core
        data for Other (basement, exterior and elevator).

        Default output is site energy. Setting 'source' flag to True outputs source energy."""

        # original areas in ft2
        areaNperim = ft22m2( 43200 )
        areaSperim = ft22m2( 43200 )
        areaWperim = ft22m2( 28800 )
        areaEperim = ft22m2( 28800 )        

        data = self.data[1:]

        dataNperim = [ float( x ) for x in data[0] ]
        dataSperim = [ float( x ) for x in data[2] ]
        dataWperim = [ float( x ) for x in data[4] ]
        dataEperim = [ float( x ) for x in data[6] ]

        if source == False:
            totalNperim = kWh2MJ( dataNperim[2] )
            totalSperim = kWh2MJ( dataSperim[2] )
            totalWperim = kWh2MJ( dataWperim[2] )
            totalEperim = kWh2MJ( dataEperim[2] )
        elif source == True:
            totalNperim = site2source( kWh2MJ( dataNperim[2] ), "electricity" )
            totalSperim = site2source( kWh2MJ( dataSperim[2] ), "electricity" )
            totalWperim = site2source( kWh2MJ( dataWperim[2] ), "electricity" )
            totalEperim = site2source( kWh2MJ( dataEperim[2] ), "electricity" )

        densNperim = totalNperim / areaNperim
        densSperim = totalSperim / areaSperim
        densWperim = totalWperim / areaWperim
        densEperim = totalEperim / areaEperim

        return [ densNperim, densSperim, densWperim, densEperim ]

    def calcfandense( self, source = False ):
        """Calculates fan energy density for each table MJ/m2-yr. When populated,
        self.data contains:

        header
        data for N perimeter
        data for N core
        data for S perimeter
        data for S core
        data for W perimeter
        data for W core
        data for E perimeter
        data for E core
        data for Other (basement, exterior and elevator).

        Default output is site energy. Setting 'source' flag to True outputs source energy."""

        # original areas in ft2
        areaNperim = ft22m2( 43200 )
        areaSperim = ft22m2( 43200 )
        areaWperim = ft22m2( 28800 )
        areaEperim = ft22m2( 28800 )        

        data = self.data[1:]

        dataNperim = [ float( x ) for x in data[0] ]
        dataSperim = [ float( x ) for x in data[2] ]
        dataWperim = [ float( x ) for x in data[4] ]
        dataEperim = [ float( x ) for x in data[6] ]

        if source == False:
            totalNperim = kWh2MJ( dataNperim[3] )
            totalSperim = kWh2MJ( dataSperim[3] )
            totalWperim = kWh2MJ( dataWperim[3] )
            totalEperim = kWh2MJ( dataEperim[3] )
        elif source == True:
            totalNperim = site2source( kWh2MJ( dataNperim[3] ), "electricity" )
            totalSperim = site2source( kWh2MJ( dataSperim[3] ), "electricity" )
            totalWperim = site2source( kWh2MJ( dataWperim[3] ), "electricity" )
            totalEperim = site2source( kWh2MJ( dataEperim[3] ), "electricity" )

        densNperim = totalNperim / areaNperim
        densSperim = totalSperim / areaSperim
        densWperim = totalWperim / areaWperim
        densEperim = totalEperim / areaEperim

        return [ densNperim, densSperim, densWperim, densEperim ]

    def calclightingdense( self, source = False ):
        """Calculates lighting energy density for each table MJ/m2-yr. When populated,
        self.data contains:

        header
        data for N perimeter
        data for N core
        data for S perimeter
        data for S core
        data for W perimeter
        data for W core
        data for E perimeter
        data for E core
        data for Other (basement, exterior and elevator).

        Default output is site energy. Setting 'source' flag to True outputs source energy."""

        # original areas in ft2
        areaNperim = ft22m2( 43200 )
        areaSperim = ft22m2( 43200 )
        areaWperim = ft22m2( 28800 )
        areaEperim = ft22m2( 28800 )        

        data = self.data[1:]

        dataNperim = [ float( x ) for x in data[0] ]
        dataSperim = [ float( x ) for x in data[2] ]
        dataWperim = [ float( x ) for x in data[4] ]
        dataEperim = [ float( x ) for x in data[6] ]

        if source == False:
            totalNperim = kWh2MJ( dataNperim[4] )
            totalSperim = kWh2MJ( dataSperim[4] )
            totalWperim = kWh2MJ( dataWperim[4] )
            totalEperim = kWh2MJ( dataEperim[4] )
        elif source == True:
            totalNperim = site2source( kWh2MJ( dataNperim[4] ), "electricity" )
            totalSperim = site2source( kWh2MJ( dataSperim[4] ), "electricity" )
            totalWperim = site2source( kWh2MJ( dataWperim[4] ), "electricity" )
            totalEperim = site2source( kWh2MJ( dataEperim[4] ), "electricity" )

        densNperim = totalNperim / areaNperim
        densSperim = totalSperim / areaSperim
        densWperim = totalWperim / areaWperim
        densEperim = totalEperim / areaEperim

        return [ densNperim, densSperim, densWperim, densEperim ]
